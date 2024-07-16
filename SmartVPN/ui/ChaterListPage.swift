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
            ZStack {
                Color.pageBackground.edgesIgnoringSafeArea(.all)
                
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
            }.navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                        Image(systemName: "chevron.backward")
                        .foregroundColor(.white).onTapGesture {
                            Dev.update = false
                            presentationMode.wrappedValue.dismiss()
                        }
                }
            ).navigationBarBackButtonHidden()
//            .background{
//                NavigationLink(destination: ChatPage(), isActive: $startChat){
//                    EmptyView()
//                }
//            }
    
    }
}

