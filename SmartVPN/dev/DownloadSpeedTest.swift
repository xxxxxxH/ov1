//
//  DownloadSpeedTest.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/30.
//

import Foundation

class DownloadSpeedTest{
    private let interval: TimeInterval = 3.0
    private let testURL = URL(string: "https://smartvpn.top/install/testfile.zip")!
    let result:(String)->Void
    
    init(result: @escaping (String) -> Void) {
        self.result = result
    }
    
    func startTesting() {
        testSpeedAndRepeat()
    }
    
    private func testSpeedAndRepeat() {
        downloadSpeedTest(completion: {
            if Dev.dSpeed{
                DispatchQueue.main.asyncAfter(deadline: .now() + self.interval) {
                    self.testSpeedAndRepeat()
                }
            }
        })
    }
    
    private func downloadSpeedTest(completion: @escaping () -> Void) {
        // 临时文件路径
            let tempDirectory = FileManager.default.temporaryDirectory
            let tempFileURL = tempDirectory.appendingPathComponent(testURL.lastPathComponent)
            
            // 开始下载时间
            let startTime = CFAbsoluteTimeGetCurrent()
            
            let task = URLSession.shared.downloadTask(with: testURL) { location, response, error in
                guard let location = location, error == nil else {
                    print("Error downloading file: \(error?.localizedDescription ?? "Unknown error")")
                    completion()
                    return
                }
                
                // 移动文件到临时目录
                do {
                    try FileManager.default.moveItem(at: location, to: tempFileURL)
                    
                    // 计算下载时间
                    let endTime = CFAbsoluteTimeGetCurrent()
                    let duration = endTime - startTime
                    print("duration = \(duration)")
                    let fileSize = try FileManager.default.attributesOfItem(atPath: tempFileURL.path)[.size] as? NSNumber ?? 0
                    print("file size = \(fileSize)")
                    let speed = Double(fileSize.intValue) / duration
                    
                    // 删除文件
                    try FileManager.default.removeItem(at: tempFileURL)
                    
                    // 调用完成闭包返回速度
                    self.result(Dev.formatSpeed(speed))
                    completion()
                } catch {
                    print("Error handling file: \(error.localizedDescription)")
                    completion()
                }
            }
        
        task.resume()
    }
}
