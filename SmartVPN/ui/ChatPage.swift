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
    
    init() {
        //        let appearance = UINavigationBarAppearance()
        //        appearance.configureWithTransparentBackground()
        //        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        //        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        //        appearance.backgroundColor = UIColor.clear
        //        appearance.titleTextAttributes = [
        //            .foregroundColor: UIColor.white,
        //            .font: UIFont.systemFont(ofSize: 24, weight: .bold)
        //        ]
        //        appearance.shadowColor = .clear
        //        UINavigationBar.appearance().standardAppearance = appearance
        //        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        //        UINavigationBar.appearance().compactAppearance = appearance
        //        UINavigationBar.appearance().tintColor = .white
    }
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Button(action: {
                        Dev.update = false
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                    }).padding()
                    Spacer()
                    Text(Dev.currentChater!.name).foregroundColor(.white).bold().font(.title)
                    Spacer()
                    OverlappingImagesView(images: Array(Dev.chaterList.shuffled().prefix(3))).padding()
                    
                }.frame(width: UIScreen().bounds.width, height: 100)
                ChatView().background(Color.clear)
                    .clipped()
                
            }.frame(width: .infinity, height: .infinity)
                .onAppear{
                    self.chater = Dev.currentChater
                }
            if chater != nil {
                Image(chater!.background)
                    .resizable()
                    .scaledToFill()
            }
            
            
            
            
        }.edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
    }
}


