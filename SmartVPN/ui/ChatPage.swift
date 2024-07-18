//
//  ChatPage.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/12.
//

import SwiftUI

struct ChatPage: View {
    @State var content = ""
    @Environment(\.presentationMode) var presentationMode
    @State var chater:ChaterEntity?
    @State private var isIPhoneXOrLater: Bool = false
    
    var body: some View {
            ZStack{
                Color.pageBackground.edgesIgnoringSafeArea(.all)
                if chater != nil {
                    Image(chater!.background)
                        .resizable()
                        .scaledToFill().ignoresSafeArea()
                }
                
                VStack{
                    CustomNavigationBar(title: Dev.currentChater!.name, backAction: {
                        presentationMode.wrappedValue.dismiss()
                    },overlay:true)
                    ChatView()
                }.frame(width: .infinity, height: .infinity).padding(.horizontal, isIPhoneXOrLater ? 20 : 0)
                
            }.onAppear{
                self.chater = Dev.currentChater
                self.isIPhoneXOrLater = checkIfIPhoneXOrLater()
            }.navigationBarHidden(true).navigationBarBackButtonHidden()
        
    }
    
    func checkIfIPhoneXOrLater() -> Bool {
            let keyWindow = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }

            let safeAreaInsets = keyWindow?.safeAreaInsets ?? UIEdgeInsets.zero
            return safeAreaInsets.top > 20 || safeAreaInsets.bottom > 0
        }
}

