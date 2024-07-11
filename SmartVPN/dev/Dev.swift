//
//  Dev.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/10.
//

import Foundation
class Dev{
    
    static var hotDatas: [HotData] = []
    static let url_nodes = "https://hotvpn.top/hotData/getOpenUrl"
    
    static func fetchHotData() {
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
                print("Data fetched and assigned to global variable")
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        task.resume()
    }
}
