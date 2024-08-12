//
//  VPNPage.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/8/9.
//

import SwiftUI
import TunnelKitManager
import Lottie

struct VPNPage: View {
    @StateObject private var vpnStatusManager = VPNStatusManager()
    private var vpn = NetworkExtensionVPN()
    @State private var showToast = false
    @State private var startNode = false
    @State private var toastMessage = ""
    @State var cuurentNode:HotData?
    @State private var startResult = false
    @State private var vpnStatus = ""
    @State private var isNeedRoute = false
    
    var body: some View {
        ZStack{
            Color.pageBackground.edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer().frame(height: 30)
                Button(action: {
                    isNeedRoute = true
                    prepareConnect()
                    //                                                        startResult = true
                }, label: {
                    ZStack{
                        LottieView(animation: .named("connect"))
                            .playing()
                            .looping()
                            .frame(width: 240, height: 240).padding()
                        
                        Text("\(vpnStatusManager.statusDescription(for: vpnStatusManager.vpnStatus))").foregroundColor(.white).font(.title2).bold()
                    }
                })
                
                Button(action: {
                    startNode = true
                }, label: {
                    
                    Text(Dev.nodeInfo == nil ? "Please select node" : Dev.nodeInfo!.smartName)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 60)
                    
                        .background(Color.chatButton.cornerRadius(10))
                })
                Spacer()
                
                NavigationLink(destination: NodePage(), isActive: $startNode){EmptyView()}
                NavigationLink(destination: ConnectResultPage(vpnStatus: vpnStatus), isActive: $startResult){EmptyView()}
            }
             
             
            if showToast{
                ToastView(message: toastMessage, isShowing: $showToast)
            }
        }.onAppear{
            Task{
                await vpn.prepare()
            }
            self.cuurentNode = Dev.nodeInfo
            if Dev.switchNode{
                isNeedRoute = true
                Downloadx.downloadFileToDocuments(from: self.cuurentNode!.smartUrl){
                    if vpnStatusManager.vpnStatus == .connected{
                        connect()
                    }else{
                        prepareConnect()
                    }
                }
            }else{
                isNeedRoute = false
            }
        }.onChange(of: vpnStatusManager.vpnStatus) { newValue in
            if newValue == .connected && isNeedRoute {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    vpnStatus = "Connected"
                    startResult = true
                })
                
            }
        }.onDisappear{
            isNeedRoute = false
            Dev.switchNode = false
        }
    }
    
    func prepareConnect(){
        if Dev.connecting{
            toastMessage = "Connecting,plesae try later"
            showToast = true
        }else{
            if Dev.nodeInfo == nil || Downloadx.config_url == nil || Downloadx.config_path.isEmpty{
                toastMessage = "No node info"
                showToast = true
            }else{
                Dev.connecting = true
                
                if vpnStatusManager.vpnStatus == .invalid || vpnStatusManager.vpnStatus == .disconnected{
                    connect()
                }else if vpnStatusManager.vpnStatus == .connected{
                    Task{
                        await vpn.disconnect()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            vpnStatus = "Disconnected"
                            startResult = true
                        })
                    }
                }
            }
        }
    }
    
    func connect(){
        guard let cfg = Config.makeConfig() else { return }
        Task {
            let extra = NetworkExtensionExtra()
            try await vpn.reconnect(
                Dev.extPkg,
                configuration: cfg,
                extra: extra,
                after: .seconds(2)
            )
        }
    }
    
    func switchNode(){ 
        Task {
            await vpn.disconnect()
            
            DispatchQueue.main.asyncAfter(deadline: .now()+1){
                connect()
            }
        }
    }
}

