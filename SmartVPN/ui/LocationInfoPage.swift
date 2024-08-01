//
//  LocationInfoPage.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/31.
//

import SwiftUI
import Lottie

struct LocationInfoPage: View {
    @State private var IP = "UnKnown"
    @State private var City = "UnKnown"
    @State private var Region = "UnKnown"
    @State private var Country = "UnKnown"
    @State private var Location = "UnKnown"
    @State private var Organization = "UnKnown"
    @State private var Timezone = "UnKnown"
    @State private var showToast = false
    @State private var toastMessage = "Copy success"
    
    var body: some View {
        ZStack{
            Color.pageBackground.edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    HStack{
                        Text("IP: \(IP)").foregroundColor(.white).padding()
                        Spacer()
                        
                    }.frame(maxWidth: .infinity, maxHeight: 60).overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 1)
                    ).padding(.top,10)
                    
                    Image("ic_copy").resizable()
                        .scaledToFit().frame(width: 25,height: 25).padding().onTapGesture {
                            copyContent(s: IP)
                        }
                }
                
                HStack{
                    HStack{
                        Text("City: \(City)").foregroundColor(.white).padding()
                        Spacer()
                    }.frame(maxWidth: .infinity, maxHeight: 60).overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 1)
                    ).padding(.top,10)
                    Image("ic_copy").resizable()
                        .scaledToFit().frame(width: 25,height: 25).padding().onTapGesture {
                            copyContent(s: City)
                        }
                }
                
                
                
                HStack{
                    HStack{
                        Text("Region: \(Region)").foregroundColor(.white).padding()
                        Spacer()
                    }.frame(maxWidth: .infinity, maxHeight: 60).overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 1)
                    ).padding(.top,10)
                    Image("ic_copy").resizable()
                        .scaledToFit().frame(width: 25,height: 25).padding().onTapGesture {
                            copyContent(s: Region)
                        }
                }
                
                
                HStack{
                    HStack{
                        Text("Country: \(Country)").foregroundColor(.white).padding()
                        Spacer()
                    }.frame(maxWidth: .infinity, maxHeight: 60).overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 1)
                    ).padding(.top,10)
                    Image("ic_copy").resizable()
                        .scaledToFit().frame(width: 25,height: 25).padding().onTapGesture {
                            copyContent(s: Country)
                        }
                }
                
                
                HStack{
                    HStack{
                        Text("Location: \(Location)").foregroundColor(.white).padding()
                        Spacer()
                    }.frame(maxWidth: .infinity, maxHeight: 60).overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 1)
                    ).padding(.top,10)
                    Image("ic_copy").resizable()
                        .scaledToFit().frame(width: 25,height: 25).padding().onTapGesture {
                            copyContent(s: Location)
                        }
                }
                
                
                HStack{
                    HStack{
                        Text("Organization: \(Organization)").foregroundColor(.white).padding()
                        Spacer()
                    }.frame(maxWidth: .infinity, maxHeight: 60).overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 1)
                    ).padding(.top,10)
                    Image("ic_copy").resizable()
                        .scaledToFit().frame(width: 25,height: 25).padding().onTapGesture {
                            copyContent(s: Organization)
                        }
                }
                
                
                HStack{
                    HStack{
                        Text("Timezone: \(Timezone)").foregroundColor(.white).padding()
                        Spacer()
                    }.frame(maxWidth: .infinity, maxHeight: 60).overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 1)
                    ).padding(.top,10)
                    
                    Image("ic_copy").resizable()
                        .scaledToFit().frame(width: 25,height: 25).padding().onTapGesture {
                            copyContent(s: Timezone)
                        }
                    
                }
                
                Spacer()
            }.padding()
            
            if showToast{
                ToastView(message: toastMessage, isShowing: $showToast)
            }
        }.onAppear{
            Dev.fetchIPInfo(completion: {
                infos in
                if infos != nil{
                    IP = infos!.ip
                    City = infos!.city
                    Region = infos!.region
                    Country = infos!.country
                    Location = infos!.loc
                    Organization = infos!.org
                    Timezone = infos!.timezone
                }
            })
        }.navigationBarItems(trailing:
                                Button(action: {
            copyContent(s: "IP: \(IP) City: \(City) Region: \(Region) Country: \(Country) Loaction: \(Location) Org: \(Organization) Timezone: \(Timezone)")
        }, label: {
            Text("Copy")
        })
        )
    }
    
    private func copyContent(s:String){
        UIPasteboard.general.string = s
        showToast = true
    }
}

#Preview {
    LocationInfoPage()
}
