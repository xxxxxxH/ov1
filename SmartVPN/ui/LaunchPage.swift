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
    @State private var showAlert = false
    @Environment(\.scenePhase) private var scenePhase
    
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
//                    destination: HomePageVIew(),
                    destination: MainPage(),
                    isActive: $jump
                ) {
                    EmptyView()
                }
            }
            .onAppear {
                //checkCountryAndPrompt()
                Dev.fetchHotData(){
                    Downloadx.downloadFileToDocuments(from: Dev.hotDatas[0].smartUrl){}
                }
                Dev.buildChaterList()
                Dev.recommendWord()
                Dev.settingList()
                Dev.getStarList()
                Dev.getStarDetailsList()
                Dev.getShengXiaoList()
                Dev.setRecommends()
                Dev.setStyles()
                Dev.setModels()
                Dev.setSizes()
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    if !showAlert{
                        jump = true
                    }
                }
            }.alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Service Unavailable"),
                    message: Text("Due to regional restrictions, this app is not available in your area. Please contact support for more information."),
                    dismissButton: .default(Text("Exit App")) {
                        exit(0)
                    }
                )
            }.onChange(of: scenePhase) { newPhase in
                if newPhase == .background {
                    //checkCountryAndPrompt()
                }
            }
        }
    }
    
    private func checkCountryAndPrompt() {
        let countryCode = Locale.current.regionCode
        if countryCode == "CN" {
            showAlert = true
        }
    }
}


