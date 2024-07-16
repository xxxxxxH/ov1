//
//  FbPage.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/15.
//

import SwiftUI

struct FbPage: View {
    @Environment(\.presentationMode) var presentationMode
    @State var inputStr = ""
    @State private var showToast = false
    @State private var toastMessage = ""
    var body: some View {
        ZStack{
            Color.pageBackground.edgesIgnoringSafeArea(.all)
            VStack{
                
                TextEditor(text: $inputStr)
                                    .frame(height: 250)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                                    .foregroundColor(.black)
                                    .font(.system(size: 16))
                                    .padding()
                Spacer()
                
            }.navigationBarItems(
                trailing: Button(action: {
                    showToast = true
                    if inputStr.isEmpty{
                        toastMessage =  "Content is empty"
                    }else{
                        toastMessage =  "Thanks for you advice"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    
                
                    
                    
                    
                }) {
                    Text("Submit").foregroundColor(.blue)
                }
            )
            
            if showToast{
                ToastView(message: toastMessage, isShowing: $showToast)
            }
        }
        
    }
}

struct ToastView: View {
    var message: String
    @Binding var isShowing: Bool
    var duration: Double = 2.0
    
    var body: some View {
        if isShowing {
            VStack {
                Spacer()
                Text(message)
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .foregroundColor(Color.white)
                    .cornerRadius(8)
                    .padding(.bottom, 50)
            }
            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    withAnimation {
                        self.isShowing = false
                    }
                }
            }
        } else {
            EmptyView()
        }
    }
}


struct CustomTextFieldStyleX: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.all, 10)
            .frame(height: 250)
            .foregroundColor(.black)
            .font(.system(size: 16))
            .multilineTextAlignment(.leading)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
    }
}
