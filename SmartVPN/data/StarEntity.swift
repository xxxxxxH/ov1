//
//  StarEntity.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/8/2.
//

import Foundation
struct StarEntity:Codable,Hashable{
    var id = UUID()
    let name:String
    let color:String
    let icon:String
}
