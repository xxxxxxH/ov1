//
//  CustomNavigationBar.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/16.
//

import SwiftUI

struct CustomNavigationBar: View {
    var title: String
    var backAction: () -> Void
    var overlay = false

    var body: some View {
        HStack {
            
            Button(action: backAction) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.white).padding(.leading, 20)
                    
            }
            Text(title)
                .foregroundColor(.white)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
            Spacer()
            if overlay{
                OverlappingImagesView(images: Array(Dev.chaterList.shuffled().prefix(3)))
            }
        }
        .frame(width:.infinity,height: 80)
    }
}

