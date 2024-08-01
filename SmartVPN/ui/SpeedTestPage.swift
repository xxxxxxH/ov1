//
//  SpeedTestPage.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/8/1.
//

import SwiftUI
import Lottie

struct SpeedTestPage: View {
    
    @StateObject var viewModel = SpeedTest()
    @State private var showAnim = true
    @State private var startIpInfo = false
    @State private var startScan = false
    @State private var startChat = false
    @State private var startChatList = false
    @State private var avaIndex1 = 0
    @State private var avaIndex2 = 0
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        ZStack {
            Color.pageBackground.edgesIgnoringSafeArea(.all)
            
            VStack{
                
                if showAnim{
                    
                    LottieView(animation: .named("speed"))
                        .playing()
                        .looping()
                    
                    Text("Testing, please wait...").foregroundColor(.white)
                    
                }else{
                    CustomNavigationBar(title: "", backAction: {
                        presentationMode.wrappedValue.dismiss()
                    },overlay:false)
                    HStack{
                        Text("Download speed: \n⬇️\(viewModel.downloadSpeed) Mbps").frame(maxWidth: .infinity,maxHeight: 200,alignment: .center).foregroundColor(.white).background(Color.chatButton).clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Text("Upload speed: \n⬆️\(viewModel.uploadSpeed) Mbps").frame(maxWidth: .infinity,maxHeight: 200, alignment: .center).foregroundColor(.white).background(Color.chatButton).clipShape(RoundedRectangle(cornerRadius: 10))
                    }.frame(height:200).padding(.horizontal, 20)
                    
                    HStack{
                        
                        Button(action: {startIpInfo = true}, label: {
                            
                            HStack{
                                Image("ic_netinfo").resizable()
                                    .scaledToFit().frame(width: 25,height: 25)
                                Text("My IP")
                            }.frame(maxWidth: .infinity,maxHeight: 100,alignment: .center).foregroundColor(.white).background(Color.chatButton).clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            
                        })
                        
                        Button(action: {startScan = true}, label: {
                            HStack{
                                Image("ic_scan").resizable()
                                    .scaledToFit().frame(width: 25,height: 25)
                                Text("QR Scanner")
                            }.frame(maxWidth: .infinity,maxHeight: 100, alignment: .center).foregroundColor(.white).background(Color.chatButton).clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        })
                        
                        NavigationLink(destination: LocationInfoPage(), isActive: $startIpInfo, label: {EmptyView()})
                        NavigationLink(destination: ScanPage(), isActive: $startScan, label: {EmptyView()})
                        
                    }.frame(height:100).padding(.horizontal, 20)
                    
                    HStack{
                        ZStack{
                            
                            Image(Dev.chaterList[avaIndex1].avatar).clipShape(Circle()).overlay(
                                Rectangle()
                                    .fill(Color.black.opacity(0.5))
                                    .clipShape(Circle())
                            )
                            
                            Button(action: {
                                Dev.currentChater = Dev.chaterList[avaIndex1]
                                startChat = true
                            }){
                                Text("chat")
                                    .foregroundColor(.white)
                                    .padding(.horizontal,20)
                                    .padding(.vertical,10)
                            }.background(Color.chatButton)
                                .cornerRadius(10)
                        }.frame(maxWidth: .infinity)
                        
                        ZStack{
                            Image(Dev.chaterList[avaIndex2].avatar).clipShape(Circle()).overlay(
                                Rectangle()
                                    .fill(Color.black.opacity(0.5))
                                    .clipShape(Circle())
                            )
                            
                            
                            Button(action: {
                                Dev.currentChater = Dev.chaterList[avaIndex2]
                                startChat = true
                            }){
                                Text("chat")
                                    .foregroundColor(.white)
                                    .padding(.horizontal,20)
                                    .padding(.vertical,10)
                            }.background(Color.chatButton)
                                .cornerRadius(10)
                        }.frame(maxWidth: .infinity)
                        
                        NavigationLink(destination: ChatPage(), isActive: $startChat, label: {EmptyView()})
                    }.padding()
                    Spacer()
                }
                
            }
            
            
        }.onAppear{
            (avaIndex1, avaIndex2) = Dev.getRandomIndex()
            DispatchQueue.global(qos: .background).async {
                viewModel.startTest()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    showAnim = false
                }
            }
        }.onDisappear{
            viewModel.cancelTest()
        }.navigationBarHidden(true)
        
    }
}


