//
//  ChatViewModel.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/12.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    static let shared = ChatViewModel()
    
    init() {
        // 添加默认的回复数据
        messages.append(Message(text: Dev.currentChater!.introduce, isSentByUser: false))
    }
    
    func sendMessage(_ text: String) {
        guard !isLoading else {
            return
        }
        
        let count = LocalData.getChatCount() + 1
        print("chat count = \(count)")
        LocalData.setChatCount(count: count)
        
        let newMessage = Message(text: text, isSentByUser: true)
        messages.append(newMessage)
        
        isLoading = true
        
        // Simulate network request for a response
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let loadingMessage = Message(text: "", isSentByUser: false, isLoading: true)
            self.messages.append(loadingMessage)
            
            self.fetchResponse(text: text)
                .sink(receiveCompletion: { _ in
                    self.isLoading = false
                }, receiveValue: { response in
                    if let index = self.messages.firstIndex(where: { $0.isLoading }) {
                        self.messages[index] = Message(text: response, isSentByUser: false)
                    }
                })
                .store(in: &self.cancellables)
            
        }
    }
    
    private func fetchResponse(text:String) -> AnyPublisher<String, Never> {
        Future { promise in
                   Dev.getAiAnswer(req: [ChatReq(role: "user", content: text)]) { response in
                       promise(.success(response))
                   }
               }
               .eraseToAnyPublisher()
        
    }
    

    func clearMessages() {
            // Example: Clear all messages
            messages.removeAll()
        }
    
    func updateChatData() {
            messages.append(Message(text: Dev.currentChater!.introduce, isSentByUser: false))
        }
}
