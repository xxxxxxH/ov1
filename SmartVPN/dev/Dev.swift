//
//  Dev.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/10.
//

import Foundation
import UIKit
class Dev{
    static var chaterList:[ChaterEntity] = []
    static var currentChater:ChaterEntity?
    static var update = false
    static var rList:[String] = []
    static var sList:[SettingItemData] = []
    static var dSpeed = true
    static var aiChat_url = "https://ai.aichatboxonline.top/SmartAI/chatAnswer"
    static var aiImg_url = "https://ai.aichatboxonline.top/SmartAI/XfImage"
    static var recommends:[String] = []
    static var styles:[AiImageEntity] = []
    static var models:[AiImageEntity] = []
    static var sizes:[AiImageEntity] = []
    static var currentStyle:AiImageEntity?
    static var currentModel:AiImageEntity?
    static var currentSize:AiImageEntity?
    

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
        guard let url = URL(string: aiChat_url) else {
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
    
    static func getAiImage(content:String, result:@escaping(String)->Void) {
        // 构建基础 URL
        guard var components = URLComponents(string: aiImg_url) else {
            print("Invalid URL")
            result("")
            return
        }
        
        // 添加查询参数
        components.queryItems = [
            URLQueryItem(name: "content", value: content),
            URLQueryItem(name: "width", value: "512"),
            URLQueryItem(name: "height", value: "512")
        ]
        
        // 获取带有参数的完整 URL
        guard let url = components.url else {
            print("Invalid URL components")
            result("")
            return
        }
        
        print("url = \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // 发起请求
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let e = error {
                result("")
                return
            }
            
            guard let data = data else {
                result("")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ChatResp.self, from: data)
                result(response.result)
                print("xxxxxxH->\(response.code)")
            } catch {
                result("")
                print("xxxxxxH->: \(error)")
            }
        }
        
        task.resume()
    }
    
    static func setRecommends(){
        recommends.append("Milky Way in the sky.")
        recommends.append("Pink Maid.")
        recommends.append("Pure white wedding dress.")
        recommends.append("Movie Star.")
        recommends.append("Sunset view.")
        recommends.append("Girl in White.")
        recommends.append("An old oil painting.")
        recommends.append("Dragon Girl.")
    }
    
    static func setStyles(){
        styles.append(AiImageEntity(type: "2D", icon: "ic_erciyuan"))
        styles.append(AiImageEntity(type: "Cartoon", icon: "ic_katong"))
        styles.append(AiImageEntity(type: "Plate", icon: "ic_chahua"))
        styles.append(AiImageEntity(type: "Art", icon: "ic_yishu"))
        styles.append(AiImageEntity(type: "3D", icon: "ic_sand"))
        styles.append(AiImageEntity(type: "Chinese style", icon: "ic_guofeng"))
        styles.append(AiImageEntity(type: "Mecha", icon: "ic_qita"))
    }
    
    static func setModels(){
        models.append(AiImageEntity(type: "Summer", icon: "ic_summer"))
        models.append(AiImageEntity(type: "Desk Girl", icon: "ic_desk"))
        models.append(AiImageEntity(type: "Cat girl", icon: "ic_cat"))
        models.append(AiImageEntity(type: "Ski Girl", icon: "ic_ski"))
        models.append(AiImageEntity(type: "Wolf Gril", icon: "ic_wolf"))
        models.append(AiImageEntity(type: "Wizard", icon: "ic_wizard"))
        models.append(AiImageEntity(type: "Dragon Girl", icon: "ic_longzu"))
        models.append(AiImageEntity(type: "Pink Girl", icon: "ic_fenhong"))
        models.append(AiImageEntity(type: "Deep forest", icon: "ic_senlin"))
        models.append(AiImageEntity(type: "Gorgeous Queen", icon: "ic_nvwang"))
        models.append(AiImageEntity(type: "Shy Girl", icon: "ic_shy"))
        models.append(AiImageEntity(type: "Wedding dress", icon: "ic_hunsha"))
        models.append(AiImageEntity(type: "Movie star", icon: "ic_dianying"))
        models.append(AiImageEntity(type: "Secretary", icon: "ic_mishu"))
        models.append(AiImageEntity(type: "Opera Girl", icon: "ic_xiqu"))
        models.append(AiImageEntity(type: "Elf Girl", icon: "ic_jingling"))
    }
    
    static func setSizes(){
        sizes.append(AiImageEntity(type: "1:1", icon: "ic_1_1"))
        sizes.append(AiImageEntity(type: "4:3", icon: "ic_1_1"))
        sizes.append(AiImageEntity(type: "3:4", icon: "ic_1_1"))
        sizes.append(AiImageEntity(type: "16:9", icon: "ic_1_1"))
        sizes.append(AiImageEntity(type: "9:16", icon: "ic_1_1"))
    }
    
    static func getWH() -> (CGFloat, CGFloat) {
        let w: CGFloat = 512
        var h: CGFloat = w

        if let type = currentSize?.type {
            switch type {
            case "1:1":
                h = w
            case "4:3":
                h = w * 3 / 4
            case "3:4":
                h = w * 4 / 3
            case "16:9":
                h = w * 9 / 16
            case "9:16":
                h = w * 16 / 9
            default:
                break
            }
        }

        return (w, h)
    }
    
}

