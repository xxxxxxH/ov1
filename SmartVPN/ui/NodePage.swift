//
//  NodePage.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/16.
//

import SwiftUI

struct NodePage: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            Color.pageBackground.edgesIgnoringSafeArea(.all)
            VStack{
                ForEach(Dev.hotDatas){item in
                    NodeItem(itemData: item){
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            presentationMode.wrappedValue.dismiss()
                        })
                    }
                }
                Spacer()
            }
            
        }.background(.clear)
    }
}
