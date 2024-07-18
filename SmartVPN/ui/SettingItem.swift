//
//  SettingItem.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/15.
//

import SwiftUI

struct SettingItem: View {
    var itemData:SettingItemData
    @State private var startFb = false
    let update:()->Void
    let privacy:()->Void
    
    var body: some View {
        Button(action: {
            print("clicked")
            switch (itemData.text){
            case "Like us":
                Dev.openAppStore()
                break
            case "Share":
                Dev.shareContent()
                break
            case "Feedback":
                startFb = true
                break
            case "Update":
                update()
                break
            case "Privacy Policy":
                privacy()
                break
            default:
                break
                
            }
        }, label: {
            NavigationLink(destination: FbPage(), isActive: $startFb){
                EmptyView()
            }
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white, lineWidth: 0.6)
                HStack{
                    Image(itemData.icon).padding()
                    Text(itemData.text)
                        .foregroundColor(.white)
                    Spacer()
                    Image("ic_arrow_right")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding()
                }
            }.frame(height: 50).padding(.horizontal, 20).padding(.top, 20)
        })
    }
}

