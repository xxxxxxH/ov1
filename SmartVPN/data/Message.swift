//
//  Message.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/12.
//

import Foundation
struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isSentByUser: Bool
    var isLoading: Bool = false
}
