//
//  ConnectResultPage.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/30.
//

import SwiftUI

struct ConnectResultPage: View {
    var vpnStatus = ""
    @StateObject private var vpnStatusManager = VPNStatusManager()
    @State private var downloadSpeed = "0.0"
    @State private var uploadSpeed = "0.0"
    @State private var avaIndex1 = 0
    @State private var avaIndex2 = 0
    @State private var startChat = false
    @State private var startIpInfo = false
    @State private var startScan = false
    @State private var startSpeed = false
    @State private var startStar = false
    @Environment(\.presentationMode) var presentationMode
    @State private var startImage = false
    @State private var loop = true
    var body: some View {
        ZStack{
            Color.pageBackground.edgesIgnoringSafeArea(.all)
            ScrollView{
                VStack{
                    
                    VStack{
                        Text(vpnStatus).foregroundColor(.white).padding()
                        
                        Spacer().frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/ ,maxHeight:0.5).background(.white).padding(.all, 10)
                        
                        HStack{
                            VStack{
                                Text("\(downloadSpeed) KB/s").foregroundColor(.white)
                                Text("Download speed").foregroundColor(.white).font(.system(size: 12))
                            }
                            
                            Spacer().frame(width: 0.5, height: 50).background(.white).padding()
                            
                            VStack{
                                Text("\(uploadSpeed) KB/s").foregroundColor(.white)
                                Text("Upload speed").foregroundColor(.white).font(.system(size: 12))
                            }
                        }
                        
                    }.padding(.all, 10).frame(maxWidth: .infinity).overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 1)
                    ).padding(.horizontal, 20)
                    
                    
                    Button(action: {
                        startStar = true
                    }, label: {
                        ZStack{
                            Image("ic_ai_img")
                                .resizable()
                                .scaledToFill()
                                .frame(height: 120)
                                .clipped()
                                .cornerRadius(10).overlay(
                                    Rectangle()
                                        .fill(Color.black.opacity(0.5)).cornerRadius(10)
                                    
                                )
                            Text("Image Generator").foregroundColor(.white).bold()
                        }.frame(height: 120).padding(.horizontal, 20)
                    })
                    
                    
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
                        
                        
                        Button(action: {startSpeed = true}, label: {
                            HStack{
                                Image("ic_speed").resizable()
                                    .scaledToFit().frame(width: 25,height: 25)
                                Text("WIFI Speed")
                            }.frame(maxWidth: .infinity,maxHeight: 100, alignment: .center).foregroundColor(.white).background(Color.chatButton).clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        })
                        
                        NavigationLink(destination: LocationInfoPage(), isActive: $startIpInfo, label: {EmptyView()})
                        NavigationLink(destination: ScanPage(), isActive: $startScan, label: {EmptyView()})
                        NavigationLink(destination: SpeedTestPage(), isActive: $startSpeed, label: {EmptyView()})
//                        NavigationLink(destination: StarListPage(), isActive: $startStar, label: {EmptyView()})
                        NavigationLink(destination: CreateImagePage(), isActive: $startStar, label: {EmptyView()})
                        
                    }.frame(height:100).padding(.horizontal, 20)
                    
                    CarouselView(){ info in
                        Dev.currentChater = info
                        startChat = true
                    }.padding(.bottom, 50)
                    

                
                    NavigationLink(destination: CreateImagePage(), isActive: $startImage, label: {EmptyView()})
                    NavigationLink(destination: ChatPage(), isActive: $startChat, label: {EmptyView()})
                    Spacer()
                }
            }
            
            
        }.onAppear{
            (avaIndex1, avaIndex2) = Dev.getRandomIndex()
            
            if vpnStatus == "Connected"{
                
                DispatchQueue.global(qos: .background).async {
                    self.downloadGet()
                }
                DispatchQueue.global(qos: .background).async {
                    self.uploadGet()
                }
            }
        }.onDisappear{
            loop = false
            Dev.dSpeed = false
        }
    }
    
    private func downloadGet(){
        var counter = 0
        while loop{
            counter += 1
            let download = Double.random(in: 0.00...30.00)
            downloadSpeed = String(format: "%.2f", download)
        
            
            if counter >= 10 {
                loop = false
                break
            }
            
            sleep(UInt32(Int.random(in: 1...5)))
        }
    }
    
    private func uploadGet(){
        var counter = 0
        while loop{
            print("loop uploadGet = \(counter)")
            counter += 1
            let upload = Double.random(in: 0.00...30.00)
            uploadSpeed = String(format: "%.2f", upload)
            
            if counter >= 10 {
                loop = false
                break
            }
            
            sleep(UInt32(Int.random(in: 1...5)))
        }
    }
    

}

