//
//  SXListPage.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/8/12.
//

import SwiftUI

struct SXListPage: View {
    
    @State private var isLoading: Bool = false
    @State private var showDialog = false
    @State private var result = ""
    @State private var title = ""
    
    var body: some View {
        ZStack{
            Color.pageBackground.edgesIgnoringSafeArea(.all)
            ScrollView{
                VStack(spacing: 10) {
                    ForEach(Dev.SXList, id: \.self){item in
                        SXItem(item: item, itemClick: {
                            isLoading = true
                            title = item.name
                            Dev.getTestResult(req: [ChatReq(role: "user", content: "introduction to the \(item.name) in the Chinese Zodiac")]){
                                response in
                                result = response
                                showDialog = true
                                isLoading = false
                            }
                        })
                    }
                }.padding()
            }
            
            if isLoading {
                LoadingView(text: "Obtaining results")
            }
            if showDialog{

                TestResultDialogView(isPresented: $showDialog, message: result, title: title)
            }
        }
    }
}


struct SXItem: View {
    let item: StarEntity
    
    let itemClick:()->Void
    
    var body: some View {
        Button(action: {
            itemClick()
        }) {
            HStack {
                Image(item.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .padding()
                Text(item.name).bold().font(.system(size: 16))
                Spacer()
                Text("->").padding()
            }
            .frame(maxWidth: .infinity, maxHeight: 60)
            .foregroundColor(.white)
            .background(Color(hex: item.color).opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .frame(height: 60)
    }
}
