//
//  MainPage.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/8/9.
//

import SwiftUI

struct MainPage: View {
    @State private var startScan = false
    @State private var startTest = false
    @State private var startStar = false
    @State private var startChat = false
    @State private var startSet = false
    @State private var startVPN = false
    @State private var startSX = false
    @State private var startAIImage = false
    var body: some View {
        ZStack{
            Color.pageBackground.edgesIgnoringSafeArea(.all)
            
            ScrollView{
                VStack{
                    Spacer().frame(height: 30)
//                    HStack{
//                        
//                        Button(action: {
//                             startStar = true
//                        }, label: {
//                            ZStack{
//                                Image("ic_star")
//                                    .resizable()
//                                    .frame(width: UIScreen.main.bounds.width / 2 - 20,height: 150)
//                                    .clipped()
//                                    .cornerRadius(10).overlay(
//                                        Rectangle()
//                                            .fill(Color.black.opacity(0.5)).cornerRadius(10)
//                                        
//                                    )
//                                Text("Horoscope").foregroundColor(.white).bold()
//                            }
//                        })
//                        
//                        Button(action: {
//                            startSX = true
//                        }, label: {
//                            ZStack{
//                                Image("ic_shier")
//                                    .resizable()
//                                    .scaledToFill()
//                                    .frame(width: UIScreen.main.bounds.width / 2 - 20,height: 150)
//                                    .clipped()
//                                    .cornerRadius(10).overlay(
//                                        Rectangle()
//                                            .fill(Color.black.opacity(0.5)).cornerRadius(10)
//                                        
//                                    )
//                                Text("Zodiac").foregroundColor(.white).bold()
//                            }
//                        })
//                        
//                    }.frame(height:150).padding(.horizontal, 20)
                    
                    HStack{
                        
                        Button(action: {
                            startAIImage = true
                        }, label: {
                            ZStack{
                                Image("ic_ai_img")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width - 25,height: 150)
                                    .clipped()
                                    .cornerRadius(10).overlay(
                                        Rectangle()
                                            .fill(Color.black.opacity(0.5)).cornerRadius(10)
                                        
                                    )
                                Text("AI generated pictures").foregroundColor(.white).bold()
                            }
                        })
                        
                        
                    }.frame(height:150).padding(.horizontal, 20)
                    
                    HStack{
                        
                        Button(action: {
                            Dev.currentChater = Dev.chaterList[0]
                            startChat = true
                        }, label: {
                            ZStack{
                                ImageGridView(images: Array(Dev.chaterList.shuffled().prefix(4))).overlay(
                                    Rectangle()
                                        .fill(Color.black.opacity(0.4)).cornerRadius(10)
                                    
                                )
                                Text("Chat with AI cartoon characters").foregroundColor(.white).bold()
                            }
                        })
                        
                        
                    }.frame(height:180).padding(.horizontal, 20)
                    
                    HStack{
                        
                        Button(action: {
                            startScan = true
                        }, label: {
                            ZStack{
                                Image("ic_scan_bg")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width / 2 - 20,height: 150)
                                    .clipped()
                                    .cornerRadius(10).overlay(
                                        Rectangle()
                                            .fill(Color.black.opacity(0.5)).cornerRadius(10)
                                        
                                    )
                                Text("Scan Qr\ncode").foregroundColor(.white).bold()
                            }
                        })
                        
                        Button(action: {
                            startVPN = true
                        }, label: {
                            ZStack{
                                Image("ic_vpn_bg")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width / 2 - 20,height: 150)
                                    .clipped()
                                    .cornerRadius(10).overlay(
                                        Rectangle()
                                            .fill(Color.black.opacity(0.5)).cornerRadius(10)
                                        
                                    )
                                Text("VPN").foregroundColor(.white).bold()
                            }
                        })
                        
                    }.frame(height:150).padding(.horizontal, 20)
                    
                    HStack{
                        
                        Button(action: {
                            startTest = true
                        }, label: {
                            ZStack{
                                Image("ic_speed_test_bg")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width / 2 - 20,height: 150)
                                    .clipped()
                                    .cornerRadius(10).overlay(
                                        Rectangle()
                                            .fill(Color.black.opacity(0.5)).cornerRadius(10)
                                        
                                    )
                                Text("Speed Test").foregroundColor(.white).bold()
                            }
                        })
                        
                        
                        Button(action: {
                            startSet = true
                        }, label: {
                            ZStack{
                                Image("ic_about_us")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width / 2 - 20,height: 150)
                                    .clipped()
                                    .cornerRadius(10).overlay(
                                        Rectangle()
                                            .fill(Color.black.opacity(0.1)).cornerRadius(10)
                                        
                                    )
                            }
                        })
                        
                        
                    }.frame(height:150).padding(.horizontal, 20)
                    Spacer()
                }
                
                NavigationLink(destination: ScanPage(), isActive: $startScan){EmptyView()}
                NavigationLink(destination: SpeedTestPage(), isActive: $startTest){EmptyView()}
//                NavigationLink(destination: StarListPage(), isActive: $startStar){EmptyView()}
                NavigationLink(destination: ChatPage(), isActive: $startChat){EmptyView()}
                NavigationLink(destination: SettingPage(), isActive: $startSet){EmptyView()}
                NavigationLink(destination: VPNPage(), isActive: $startVPN){EmptyView()}
                NavigationLink(destination: SXListPage(), isActive: $startSX){EmptyView()}
                NavigationLink(destination: CreateImagePage(), isActive: $startAIImage){EmptyView()}
            }
        }.navigationBarHidden(true)
    }
}
