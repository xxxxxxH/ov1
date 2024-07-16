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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let loadingMessage = Message(text: "", isSentByUser: false, isLoading: true)
            self.messages.append(loadingMessage)
            
            self.fetchResponse()
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
    
    private func fetchResponse() -> AnyPublisher<String, Never> {
        // Simulate a network request with a delay
        Just("This is a response from the network")
            .delay(for: 2, scheduler: DispatchQueue.main)
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
