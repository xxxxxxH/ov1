//
//  HomePageVIew.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/12.
//

import SwiftUI

struct HomePageVIew: View {
    @State private var startChat = false
    var body: some View {
        NavigationView {
            HomePage(startChat: $startChat)
                .background(
                    NavigationLink(
                        destination: ChatPage(),
                        isActive: $startChat
                    ) {
                        EmptyView()
                    }
                )
        }.navigationBarBackButtonHidden()
    }
}
