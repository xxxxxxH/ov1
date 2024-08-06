//
//  StarDetailsPage.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/8/2.
//

import SwiftUI

struct StarDetailsPage: View {
    let starEntity:StarEntity
    let columns = 2
    @State private var _index = 0
    @State private var isLoading: Bool = false
    @State private var showDialog = false
    @State private var result = ""
    @State private var title = ""
    var body: some View {
        ZStack{
            Color(hex: starEntity.color).opacity(0.5).edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(0..<numberOfRows(), id: \.self) { rowIndex in
                        HStack(spacing: 10) {
                            ForEach(0..<columns, id: \.self) { columnIndex in
                                let index = rowIndex * columns + columnIndex
                                if index < Dev.starDetailsList.count {
                                    Item(data: Dev.starDetailsList[index], ItemClick: {
                                        _index = index
                                        isLoading = true
                                        let reqText = "\(starEntity.name),\(Dev.currentMonthString()),\(Dev.starDetailsList[index].type)"
                                        title = reqText
                                        Dev.getTestResult(req: [ChatReq(role: "user", content: "Horoscope:\(reqText)")]){
                                            response in
                                            result = response
                                            showDialog = true
                                            isLoading = false
                                        }
                                    })
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            if isLoading {
                LoadingView(text: "Testing")
            }
            if showDialog{

                TestResultDialogView(isPresented: $showDialog, message: result, title: title)
            }
        }.navigationTitle(starEntity.name)
    }
    
    private func numberOfRows() -> Int {
        return (Dev.starDetailsList.count + columns - 1) / columns // 向上取整
    }
}

struct Item: View {
    let data:StarDetailsEntity
    let ItemClick:()->Void
   
    
    var body: some View {
        Button(action: {
            ItemClick()
        }) {
            VStack{
                HStack {
                    Image(data.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: 120)
                .foregroundColor(.white).padding(.horizontal,20)
                HStack{
                    Text(data.type).bold().foregroundColor(.white).font(.system(size: 16))
                    Spacer()
                    
                }.padding(.horizontal,20)
                HStack{
                    Text(data.desc).foregroundColor(.white).font(.system(size: 12))
                    Spacer()
                }.padding(.horizontal,20)
                
                Spacer()
            } .background(Color(hex: data.bg).opacity(0.9))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
        }
        .frame(height: 120)
    }
}

