//
//  HomePage.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/11.
//

import SwiftUI
import Lottie
import TunnelKitManager
import NetworkExtension
import TunnelKit

struct HomePage: View {
    @Binding var startChat: Bool
    @StateObject private var vpnStatusManager = VPNStatusManager()
    private var vpn = NetworkExtensionVPN()
    @State var startSet:Bool = false
    @State var startNode:Bool = false
    @State var cuurentNode:HotData?
    @State private var showToast = false
    @State private var toastMessage = ""
    
    init(startChat: Binding<Bool>) {
        self._startChat = startChat
    }
    
    var body: some View {
        ZStack{
            Color.pageBackground.edgesIgnoringSafeArea(.all)
            GeometryReader { geometry in
                ScrollView{
                    VStack() {
                        HStack{
                            
                            Button(action: {
                                print("clicked")
                                startSet = true
                            }){
                                ZStack{
                                    Image("ic_func").resizable()
                                        .scaledToFit().frame(width: 25,height: 25)
                                    
                                }.frame(width: 45, height: 45)
                                
                                NavigationLink(destination: SettingPage(), isActive: $startSet){
                                    EmptyView()
                                }
                            }.overlay(
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                            Spacer().frame(width: 20)
                            Button(action: {
                                startNode = true
                            }){
                                ZStack{
                                    Image("ic_node").resizable()
                                        .scaledToFit().frame(width: 25,height: 25)
                                }.frame(width: 45, height: 45)
                                
                                NavigationLink(destination: NodePage(), isActive: $startNode){
                                    EmptyView()
                                }
                            }.overlay(
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                            
                        }
                        
                        Button(action: {
                            prepareConnect()
                        }, label: {
                            ZStack{
                                LottieView(animation: .named("connect"))
                                    .playing()
                                    .looping()
                                    .frame(width: 240, height: 240).padding()
                                
                                Text("\(vpnStatusManager.statusDescription(for: vpnStatusManager.vpnStatus))").foregroundColor(.white).font(.title2).bold()
                            }
                        })
                        
                        CarouselView(){ info in
                            Dev.currentChater = info
                            startChat = true
                        }.padding(.bottom, 50)
                        
                        
                    }.frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
            
            if showToast{
                ToastView(message: toastMessage, isShowing: $showToast)
            }
        }.onAppear{
            self.cuurentNode = Dev.nodeInfo
            if Dev.switchNode{
                Downloadx.downloadFileToDocuments(from: self.cuurentNode!.hotUrl){
                    if vpnStatusManager.vpnStatus == .connected{
                        connect()
                    }else{
                        prepareConnect()
                    }
                }
            }
        }.navigationBarHidden(true)
        
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


struct HomeNavigationBar: View {
    var funcAction: () -> Void
    var nodeAction: () -> Void
    var body: some View {
        HStack {
            Button(action: funcAction) {
                Image("ic_func")
                    .foregroundColor(.white)
            }
            
            
            Button(action: nodeAction) {
                Image("ic_node")
                    .foregroundColor(.white)
            }
        }
        .padding()
        .frame(height: 80)
    }
}
