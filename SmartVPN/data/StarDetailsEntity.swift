//
//  StarDetailsEntity.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/8/5.
//

import Foundation
struct StarDetailsEntity:Codable,Hashable{
    var id = UUID()
    let type:String
    let icon:String
    let bg:String
    let desc:String
}
