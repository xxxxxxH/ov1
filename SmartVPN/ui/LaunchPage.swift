//
//  LaunchPage.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/11.
//

import SwiftUI
import Lottie

struct LaunchPage: View {
    
    @State private var jump = false
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.pageBackground.edgesIgnoringSafeArea(.all)
                AdvancedUserPanelView()
                    .environmentObject(AppSettings1()).frame(width: 0, height: 0)
                
                ComplexView()
                
                MarqueeView(
                            text: "",
                            duration: 10,
                            fontSize: 20,
                            textColor: .clear,
                            backgroundColor: .clear
                        )
                        .frame(width: 0, height: 0)
                VStack{
                    
                    
                    LottieView(animation: .named("xh"))
                        .playing()
                        .looping()
                        .frame(width: 300,height: 300)
                    
                    
                    
                }
                
                
                
                NavigationLink(
                    destination: HomePageVIew(),
                    isActive: $jump
                ) {
                    EmptyView()
                }
            }
            .onAppear {
                Dev.fetchHotData(){
                    Downloadx.downloadFileToDocuments(from: Dev.hotDatas[0].smartUrl){}
                }
                Dev.buildChaterList()
                Dev.recommendWord()
                Dev.settingList()
                Dev.getStarList()
                Dev.getStarDetailsList()
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    jump = true
                }
            }
        }
    }
}


