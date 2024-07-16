//
//  Dev.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/10.
//

import Foundation
import UIKit
class Dev{
    
    static var hotDatas: [HotData] = []
    static let url_nodes = "https://hotvpn.top/hotData/getOpenUrl"
    static var nodeInfo:HotData?
    static var chaterList:[ChaterEntity] = []
    static var currentChater:ChaterEntity?
    static var update = false
    static var rList:[String] = []
    static var sList:[SettingItemData] = []
    static var switchNode = false
    static let extPkg = "com.apps.smartx.SmartVPN.SmartT"
    static var connecting = false
    
    static func fetchHotData(success:@escaping()->Void) {
        guard let url = URL(string: url_nodes) else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }

            guard let data = data else {
                print("Data Error")
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(HotDataResponse.self, from: data)
                hotDatas = response.result
                if !hotDatas.isEmpty{
                    nodeInfo = hotDatas[0]
                    success()
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        task.resume()
    }
    
    static func buildChaterList(){
        chaterList.append(ChaterEntity(name: "Emily", introduce: "Emily is an avid reader who loves exploring new genres and sharing her favorite books with friends.", background: "b1", hBackground: "1h", avatar: "t1"))
        
        chaterList.append(ChaterEntity(name: "Sophia", introduce: "Sophia is a talented dancer with a passion for ballet and contemporary dance styles.", background: "b2", hBackground: "2h", avatar: "t2"))
        
        chaterList.append(ChaterEntity(name: "Olivia", introduce: "Olivia is a budding artist known for her vibrant paintings and creative use of colors.", background: "b3", hBackground: "3h", avatar: "t3"))
        
        chaterList.append(ChaterEntity(name: "Isabella", introduce: "Isabella enjoys playing the piano and often performs at local community events.", background: "b4", hBackground: "4h", avatar: "t4"))
        
        chaterList.append(ChaterEntity(name: "Ava", introduce: "Ava is a nature enthusiast who loves hiking, bird watching, and spending time outdoors.", background: "b5", hBackground: "5h", avatar: "t5"))
        
        chaterList.append(ChaterEntity(name: "Mia", introduce: "Mia is a tech-savvy girl who enjoys coding and developing her own mobile apps.", background: "b6", hBackground: "6h", avatar: "t6"))
        
        chaterList.append(ChaterEntity(name: "Charlotte", introduce: "Charlotte has a green thumb and takes pride in her beautiful garden filled with various flowers and plants.", background: "b7", hBackground: "7h", avatar: "t7"))
        
        chaterList.append(ChaterEntity(name: "Amelia", introduce: "Amelia is an aspiring chef who loves experimenting with new recipes and flavors in the kitchen.", background: "b8", hBackground: "8h", avatar: "t8"))
        
        chaterList.append(ChaterEntity(name: "Harper", introduce: "Harper is a dedicated athlete who excels in soccer and is the captain of her school team.", background: "b9", hBackground: "9h", avatar: "t9"))
        
        chaterList.append(ChaterEntity(name: "Evelyn", introduce: "Evelyn is a compassionate volunteer who spends her weekends helping out at the local animal shelter.", background: "b10", hBackground: "10h", avatar: "t10"))
    }
    
    static func recommendWord(){
        rList.append("What kind of movies do you like?")
        rList.append("How's the weather today?")
        rList.append("Tell me a joke!")
        rList.append("Can you sing?")
        rList.append("Popular travel destinations")
        rList.append("Any good book recommendations lately?")
        rList.append("What kind of sports do you like?")
        rList.append("What are some fun games?")
        rList.append("What should I name my pet?")
        rList.append("What's trending in fashion?")
    }
    
    static func settingList(){
        sList.append(SettingItemData(text:"Like us",icon:"ic_like"))
        sList.append(SettingItemData(text:"Share",icon:"ic_share"))
        sList.append(SettingItemData(text:"Feedback",icon:"ic_fb"))
        sList.append(SettingItemData(text:"Provacy Policy",icon:"ic_private"))
        sList.append(SettingItemData(text:"Update",icon:"ic_update"))
    }
    
    static func openAppStore() {
           guard let url = URL(string: "https://apps.apple.com/app/id=\(Bundle.main.bundleIdentifier)") else {
               return
           }
           
           UIApplication.shared.open(url, options: [:], completionHandler: nil)
       }
    
    static func shareContent() {
        let text = "Hello" // 要分享的文本内容
        let url = URL(string: "https://apps.apple.com/app/id=\(Bundle.main.bundleIdentifier)") // 可选的URL
        
        // 创建分享的内容
        var items: [Any] = [text]
        if let url = url {
            items.append(url)
        }
        
        // 创建并配置ActivityViewController
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        // 在iPad上，为了使分享框正确显示，必须指定sourceView和sourceRect
        if let topViewController = UIApplication.shared.windows.first?.rootViewController {
            activityViewController.popoverPresentationController?.sourceView = topViewController.view
            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: topViewController.view.bounds.midX, y: topViewController.view.bounds.midY, width: 0, height: 0)
        }
        
        // 显示分享框
        topViewController?.present(activityViewController, animated: true, completion: nil)
    }
    
    // 获取顶层视图控制器的方法
    private static var topViewController: UIViewController? {
        guard var topController = UIApplication.shared.windows.first?.rootViewController else {
            return nil
        }
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }
}

