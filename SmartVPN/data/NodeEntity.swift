//
//  NodeEntity.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/10.
//

import Foundation
struct HotDataResponse: Codable {
    let code: Int
    let msg: String
    let result: [HotData]
}

struct HotData: Codable,Identifiable {
    let id = UUID()
    let smartId: Int
    let smartName: String
    let smartUrl: String
}
