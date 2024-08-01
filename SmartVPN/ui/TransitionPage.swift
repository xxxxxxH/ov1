//
//  TransitionPage.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/8/1.
//

import SwiftUI

struct TransitionPage: View {
    @State private var startTest = false
    var body: some View {
            ZStack{
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                NavigationLink(destination: SpeedTestPage(), isActive: $startTest){
                    EmptyView()
                }
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                    startTest = true
                }
            }
        
        
    }
}

