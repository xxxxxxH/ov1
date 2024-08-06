//
//  Dev.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/10.
//

import Foundation
import UIKit
class Dev{
    //smartvpn.top/getSmart/getSmartUrl
    //hotvpn.top/hotData/getOpenUrl
    static var hotDatas: [HotData] = []
    static let url_nodes = "https://smartvpn.top/getSmart/getSmartUrl"
    static var nodeInfo:HotData?
    static var chaterList:[ChaterEntity] = []
    static var currentChater:ChaterEntity?
    static var update = false
    static var rList:[String] = []
    static var sList:[SettingItemData] = []
    static var switchNode = false
    static let extPkg = "com.apps.smartx.joy.SmartT"
    static let group = ""
    static var connecting = false
    static var dSpeed = true
    static var starList: [StarEntity] = []
    static var starDetailsList:[StarDetailsEntity] = []
    
    static func fetchHotData(success:@escaping()->Void) {
        guard let url = URL(string: url_nodes) else {
            print("xxxxxxH->Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("xxxxxxH->Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("xxxxxxH->Data Error")
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
                print("xxxxxxH->获取节点成功 \(hotDatas.count)")
                
            } catch {
                print("xxxxxxH->获取节点失败: \(error)")
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
        sList.append(SettingItemData(text:"Privacy Policy",icon:"ic_private"))
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
    
    static func getAiAnswer(req:[ChatReq], success:@escaping(String)->Void){
        guard let url = URL(string: "https://ai.smartvpn.top/SmartAI/chatAnswer") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        guard let httpBody = try? JSONEncoder().encode(req) else {
            print("Invalid JSON")
            return
        }
        if let jsonString = String(data: httpBody, encoding: .utf8) {
            print("xxxxxxH-> json = \(jsonString)")
        }
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                success("error")
                return
            }
            
            guard let data = data else {
                print("No data received")
                success("error")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ChatResp.self, from: data)
                success(response.result)
                print("xxxxxxH->\(response)")
            } catch {
                success("error")
                print("xxxxxxH->: \(error)")
            }
        }.resume()
    }
    
    static func formatSpeed(_ speed: Double) -> String {
        var formattedSpeed: String = "0.0 kB/s"
        
        if speed < 1_000 {
            // Less than 1 KB, use bytes
            formattedSpeed = String(format: "%.0f B/s", speed)
        } else if speed < 1_000_000 {
            // Less than 1 MB, use KB
            let kbSpeed = speed / 1_000
            formattedSpeed = String(format: "%.2f KB/s", kbSpeed)
        } else {
            // 1 MB or more, use MB
            let mbSpeed = speed / 1_000_000
            formattedSpeed = String(format: "%.2f MB/s", mbSpeed)
        }
        
        return formattedSpeed
    }
    
    static func fetchIPInfo(completion: @escaping (LocationInfoEntity?) -> Void) {
        let url = URL(string: "https://ipinfo.io/json")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let locationInfo = try decoder.decode(LocationInfoEntity.self, from: data)
                print("location info = \(locationInfo)")
                completion(locationInfo)
            } catch {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    static func getRandomIndex() -> (Int, Int) {
        var uniqueNumbers = Set<Int>()
        
        while uniqueNumbers.count < 2 {
            let randomNumber = Int.random(in: 0...9)
            uniqueNumbers.insert(randomNumber)
        }
        
        let numbersArray = Array(uniqueNumbers)
        return (numbersArray[0], numbersArray[1])
    }
    
    static func getStarList(){
        starList.append(StarEntity(name: "Aries", color: "#FF4C4C", icon: "ic_by"))
        starList.append(StarEntity(name: "Taurus", color: "#4CAF50",icon: "ic_jn"))
        starList.append(StarEntity(name: "Gemini", color: "#F8E71C",icon: "ic_sz"))
        starList.append(StarEntity(name: "Cancer", color: "#C0C0C0",icon: "ic_jx"))
        starList.append(StarEntity(name: "Leo", color: "#FFD700",icon: "ic_shizi"))
        starList.append(StarEntity(name: "Virgo", color: "#3D9970",icon: "ic_cn"))
        starList.append(StarEntity(name: "Libra", color: "#0099FF",icon: "ic_tc"))
        starList.append(StarEntity(name: "Scorpio", color: "#C8102E",icon: "ic_tx"))
        starList.append(StarEntity(name: "Sagittarius", color: "#8A2BE2",icon: "ic_ss"))
        starList.append(StarEntity(name: "Capricorn", color: "#8B4513",icon: "ic_mj"))
        starList.append(StarEntity(name: "Aquarius", color: "#00FFFF",icon: "ic_sp"))
        starList.append(StarEntity(name: "Pisces", color: "#1E90FF",icon: "ic_sy"))
    }
    
    static func getStarDetailsList(){
        starDetailsList.append(StarDetailsEntity(type: "Fortune", icon: "ic_yunshi", bg: "#83B1E3", desc: "10K+ used"))
        starDetailsList.append(StarDetailsEntity(type: "Love", icon: "ic_aiqing", bg: "#E6ADCE", desc: "20.5K+ used"))
        starDetailsList.append(StarDetailsEntity(type: "Complex", icon: "ic_fuhe", bg: "#444D92", desc: "5K+ used"))
        starDetailsList.append(StarDetailsEntity(type: "Relationship", icon: "ic_guanxi", bg: "#B14CB6", desc: "2.5K+ used"))
        starDetailsList.append(StarDetailsEntity(type: "Career", icon: "ic_shiye", bg: "#96BCBD", desc: "6K+ used"))
        starDetailsList.append(StarDetailsEntity(type: "Wealth", icon: "ic_caifu", bg: "#C4967C", desc: "10K+ used"))
    }
    
    static func getTestResult(req:[ChatReq], success:@escaping(String)->Void){
        guard let url = URL(string: "https://ai.smartvpn.top/SmartAI/chatAnswer") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        guard let httpBody = try? JSONEncoder().encode(req) else {
            print("Invalid JSON")
            return
        }
        if let jsonString = String(data: httpBody, encoding: .utf8) {
            print("xxxxxxH-> json = \(jsonString)")
        }
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                success("error")
                return
            }
            
            guard let data = data else {
                print("No data received")
                success("error")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ChatResp.self, from: data)
                success(response.result)
                print("xxxxxxH->\(response)")
            } catch {
                success("error")
                print("xxxxxxH->: \(error)")
            }
        }.resume()
    }
    
    static func currentMonthString() -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        let monthNumber = calendar.component(.month, from: currentDate)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let monthName = dateFormatter.string(from: calendar.date(bySetting: .month, value: monthNumber, of: currentDate)!)
        
        return monthName
    }
}

