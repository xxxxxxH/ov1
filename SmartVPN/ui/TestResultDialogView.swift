//
//  TestResultDialogView.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/8/5.
//

import SwiftUI
struct TestResultDialogView:View{
    @Binding var isPresented: Bool
    let message: String
    let title:String
    
    @State private var displayedText = ""
    @State private var currentIndex = 0
    private let typingInterval = 0.05
    
    var body: some View {
        if isPresented {
            
            VStack {
                
                Text(title).font(.system(size: 16)).bold().padding()
                
                ScrollViewReader{proxy in
                    ScrollView{
                        Text(displayedText)
                            .padding()
                            .id("textContent")
                            .onAppear(perform: startTyping)
                            .onChange(of: displayedText.count) {_ in
                                withAnimation {
                                    proxy.scrollTo("textContent", anchor: .bottom)
                                }
                            }
                    }
                }
                
                
                Button("OK") {
                    isPresented = false
                }
                .padding()
            }.frame(maxWidth: .infinity)
                .background(Color.white).cornerRadius(10).padding()
            
            
        }
    }
    
    private func startTyping() {
        displayedText = ""
        currentIndex = 0
        Timer.scheduledTimer(withTimeInterval: typingInterval, repeats: true) { timer in
            if currentIndex < message.count {
                let index = message.index(message.startIndex, offsetBy: currentIndex)
                displayedText += String(message[index])
                currentIndex += 1
            } else {
                timer.invalidate()
            }
        }
    }
}
