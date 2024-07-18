//
//  Downloadx.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/10.
//

import Foundation
class Downloadx{
    
    static var config_path = ""
    
    static var config_url:URL?
    
    static func getDocumentsDirectory() -> URL {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsURL
    }
    
    static  func downloadFileToDocuments(from urlString: String,success:@escaping()->Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let documentsDirectoryURL = getDocumentsDirectory()
        let destinationURL = documentsDirectoryURL.appendingPathComponent("config.ovpn")
        
        let task = URLSession.shared.downloadTask(with: url) { (tempFileURL, response, error) in
            if let error = error {
                print("xxxxxxH->Error dowanload data: \(error)")
                return
            }
            
            guard let tempFileURL = tempFileURL else {
                print("xxxxxxH->Error dowanload tempFileURL")
                return
            }
            
            do {
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: destinationURL.path) {
                    try fileManager.removeItem(at: destinationURL)
                }
                try fileManager.moveItem(at: tempFileURL, to: destinationURL)
                config_path = destinationURL.path
                config_url = destinationURL
                print("xxxxxxH->下载配置文件成功 \(config_path) \(String(describing: config_url))")
                success()
            } catch {
                print("xxxxxxH->下载配置文件失败 \(error)")
            }
        }
        task.resume()
    }
    
    
    
    
}
