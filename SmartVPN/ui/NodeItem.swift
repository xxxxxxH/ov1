//
//  NodeItem.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/16.
//

import SwiftUI

struct NodeItem: View {
    var itemData:HotData
    let itemClick:()->Void
    var body: some View {
        Button(action: {
            Dev.nodeInfo = itemData
            
            Dev.switchNode = true
            itemClick()
        }, label: {
            
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white, lineWidth: 0.6)
                HStack{
                    Image(systemName: "globe").padding().foregroundColor(.white)
                    Text(itemData.hotName)
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

