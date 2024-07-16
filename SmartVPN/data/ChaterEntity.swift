//
//  ChaterEntity.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/12.
//

import Foundation
struct ChaterEntity: Codable {
    let id = UUID()
    let name: String
    let introduce: String
    let background :String
    let hBackground :String
    let avatar: String
}
