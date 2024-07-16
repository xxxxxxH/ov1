//
//  LocalData.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/15.
//

import Foundation
class LocalData{
    static func setChatCount(count:Int){
        UserDefaults.standard.setValue(count, forKey: "chatCount")
    }
    
    static func getChatCount()->Int{
        return UserDefaults.standard.integer(forKey: "chatCount")
    }
}
