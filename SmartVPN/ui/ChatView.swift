//
//  ChatView.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/12.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var inputText: String = ""
    @State private var showToast: Bool = false
    @State private var toastStr = ""
    
    
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.messages) { message in
                            ChatBubble(message: message)
                                .id(message.id)
                        }
                    }
                }
                .onChange(of: viewModel.messages.count) { _ in
                    if let lastMessage = viewModel.messages.last {
                        withAnimation {
                            proxy.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
                }
            }
            VStack{
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(0..<Dev.rList.count) { index in
                            Text(Dev.rList[index])
                                .padding(.horizontal, 10).padding(.vertical, 12)
                                .background(Color.black.opacity(0.2))
                                .foregroundColor(.white)
                                .font(.system(size: 14)).cornerRadius(8).overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.white, lineWidth: 0.6)
                                ).onTapGesture {
                                    if viewModel.isLoading {
                                        showToast = true
                                        toastStr = "Please wait for the current response."
                                    } else {
                                        if LocalData.getChatCount() > 10{
                                            showToast = true
                                            toastStr = "The maximum number of times has been reached"
                                            return
                                        }
                                        inputText = Dev.rList[index]
                                        viewModel.sendMessage(inputText)
                                        inputText = ""
                                    }
                                }
                        }
                    }.padding(.horizontal, 20)
                    
                }
                
                HStack{
                    TextField("Chat with she", text: $inputText) {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    .textFieldStyle(CustomTextFieldStyle())
                    
                    
                    Button(action: {
                        if inputText.isEmpty{
                            showToast = true
                            toastStr = "Content is empty"
                        }else{
                            if viewModel.isLoading {
                                showToast = true
                                toastStr = "Please wait for the current response."
                            } else {
                                if LocalData.getChatCount() > 10{
                                    showToast = true
                                    toastStr = "The maximum number of times has been reached"
                                    return
                                }
                                viewModel.sendMessage(inputText)
                                inputText = ""
                            }
                        }
                    }){
                        Text("SEND")
                            .foregroundColor(.white)
                            .padding(.horizontal,20)
                            .frame(height: 50)
                            .font(.system(size: 16, weight: .bold))
                    }.background(Color.chatButton)
                        .cornerRadius(10)
                }.padding(.bottom, 20).padding(.horizontal, 20)
            }
            
            
        }.overlay(
            Group {
                if showToast {
                    Toast(message: toastStr)
                        .transition(.opacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    showToast = false
                                }
                            }
                        }
                }
            }, alignment: .top).onAppear{
                if Dev.update{
                    viewModel.clearMessages()
                    viewModel.updateChatData()
                }
                
            }
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.all, 10)
            .frame(height: 50)
            .foregroundColor(.black)
            .font(.system(size: 16))
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
    }
}
