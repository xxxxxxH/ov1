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
                VStack{
                    
                
                    LottieView(animation: .named("xh"))
                      .playing()
                      .looping()
                    
                      
                    Text("Loading...")
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .font(.system(.largeTitle)).padding()
                }
                
                NavigationLink(
                    destination: ContentView(),
                    isActive: $jump
                ) {
                    EmptyView()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    //jump = true
                }
            }
        }
    }
}

#Preview {
    LaunchPage()
}

