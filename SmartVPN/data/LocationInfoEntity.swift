//
//  LocationInfoEntity.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/31.
//

import Foundation
struct LocationInfoEntity:Codable{
    let ip:String
    let city:String
    let region:String
    let country:String
    let loc:String
    let org:String
    let timezone:String
}
