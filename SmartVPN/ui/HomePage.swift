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
    @State private var startResult = false
    @State private var startInfo = false
    @State private var startScan = false
    @State private var startTest = false
    @State private var rotation: Double = 0
    @State private var startStar = false
    
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
                            ScrollView(.horizontal, showsIndicators: true) {
                                HStack{
                                    Spacer().frame(width: 20)
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
                                    
                                    //                                    Spacer().frame(width: 20)
                                    //                                    Button(action: {
                                    //                                        startInfo = true
                                    //                                    }){
                                    //                                        ZStack{
                                    //                                            Image("ic_netinfo").resizable()
                                    //                                                .scaledToFit().frame(width: 25,height: 25)
                                    //                                        }.frame(width: 45, height: 45)
                                    //
                                    //                                        NavigationLink(destination: NodePage(), isActive: $startNode){
                                    //                                            EmptyView()
                                    //                                        }
                                    //                                    }.overlay(
                                    //                                        RoundedRectangle(cornerRadius: 2)
                                    //                                            .stroke(Color.white, lineWidth: 1)
                                    //                                    )
                                    
                                    
                                    Spacer().frame(width: 20)
                                    Button(action: {
                                        startScan = true
                                    }){
                                        ZStack{
                                            Image("ic_scan").resizable()
                                                .scaledToFit().frame(width: 25,height: 25)
                                        }.frame(width: 45, height: 45)
                                        
                                        NavigationLink(destination: NodePage(), isActive: $startNode){
                                            EmptyView()
                                        }
                                    }.overlay(
                                        RoundedRectangle(cornerRadius: 2)
                                            .stroke(Color.white, lineWidth: 1)
                                    )
                                    
                                    
                                    Spacer().frame(width: 20)
                                    
                                    Button(action: {
                                        startTest = true
                                    }){
                                        ZStack{
                                            Image("ic_speed").resizable()
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
                            }
                            
                            
                            Image("ic_horoscope").resizable().scaledToFit().frame(width: 80, height: 80).padding(.horizontal, 10).rotationEffect(.degrees(rotation))
                                .onAppear {
                                    withAnimation(
                                        Animation.linear(duration: 10)
                                            .repeatForever(autoreverses: false)
                                    ) {
                                        rotation = 360
                                    }
                                }.onTapGesture(perform: {
                                    startStar = true
                                })
                        }
                        
                        Button(action: {
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
                        
                        CarouselView(){ info in
                            Dev.currentChater = info
                            startChat = true
                        }.padding(.bottom, 50)
                        
                        NavigationLink(destination: ConnectResultPage(), isActive: $startResult){
                            EmptyView()
                        }
                        
                        NavigationLink(destination: LocationInfoPage(), isActive: $startInfo){
                            EmptyView()
                        }
                        
                        NavigationLink(destination: ScanPage(), isActive: $startScan){
                            EmptyView()
                        }
                        
                        NavigationLink(destination: SpeedTestPage(), isActive: $startTest){
                            EmptyView()
                        }
                        
                        NavigationLink(destination: StarListPage(), isActive: $startStar){
                            EmptyView()
                        }
                        
                        
                    }.frame(width: geometry.size.width, height: geometry.size.height)
                }
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
                Downloadx.downloadFileToDocuments(from: self.cuurentNode!.smartUrl){
                    if vpnStatusManager.vpnStatus == .connected{
                        connect()
                    }else{
                        prepareConnect()
                    }
                }
            }
        }.onChange(of: vpnStatusManager.vpnStatus) { newValue in
            startResult = newValue == .connected
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
