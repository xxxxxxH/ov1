//
//  ChaterListPage.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/12.
//

import SwiftUI

struct ChaterListPage: View {
    
    @State var startChat = false
    @Environment(\.presentationMode) var presentationMode
    @State private var didSelectItem = false
    
    var body: some View {
        GeometryReader{g in
            ZStack {
                Color.pageBackground.edgesIgnoringSafeArea(.all)
                VStack{
                    CustomNavigationBar(title: "Chat", backAction: {
                        Dev.update = false
                        presentationMode.wrappedValue.dismiss()
                    })
                    
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(Dev.chaterList, id: \.id) { chater in
                                ChaterRowView(chater: chater)
                                    .padding(.horizontal)
                                    .onTapGesture {
                                        Dev.currentChater = chater
                                        startChat = true
                                        Dev.update = true
                                        presentationMode.wrappedValue.dismiss()
                                    }
                            }
                        }
                    }
                }
              
            }
        }.navigationBarHidden(true).navigationBarBackButtonHidden()
    }
}

