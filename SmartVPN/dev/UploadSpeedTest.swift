//
//  UploadSpeedTest.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/30.
//

import Foundation
class UploadSpeedTest{
    private var startTime: Date?
    private var totalBytes: Int64 = 0
    private let dataSize: Int = 1024 * 1024 // 每次上传 100 KB 数据块
    private let interval: TimeInterval = 2.0 // 间隔时间（2 秒）
    private let uploadUrl = ""
    
    func startMonitoring(completion: @escaping (String) -> Void) {
        guard let url = URL(string: uploadUrl) else {
            completion("")
            return
        }
        
        self.startTime = Date()
        
        // Start the periodic upload
        scheduleNextUpload(url: url, completion: completion)
    }
    
    private func scheduleNextUpload(url: URL, completion: @escaping (String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.uploadNextChunk(url: url, completion: completion)
        }
    }
    
    private func uploadNextChunk(url: URL, completion: @escaping (String) -> Void) {
        let data = Data(count: dataSize) // 每次上传的数据块
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        
        let task = URLSession.shared.uploadTask(with: request, from: data) { _, _, error in
            if error == nil {
                self.totalBytes += Int64(data.count)
                self.updateSpeed(completion: completion)
                
                // Schedule the next upload
                self.scheduleNextUpload(url: url, completion: completion)
            } else {
                completion("")
            }
        }
        
        task.resume()
    }
    
    private func updateSpeed(completion: @escaping (String) -> Void) {
        let now = Date()
        let elapsedTime = now.timeIntervalSince(startTime ?? now)
        
        if elapsedTime > 0 {
            let bytesPerSecond = Double(totalBytes) / elapsedTime
            let speed = bytesPerSecond / 1024.0 / 1024.0 // MB/s
            let formattedSpeed = Dev.formatSpeed(speed)
            
            completion(formattedSpeed)
        }
    }
}
