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
    
    static  func downloadFileToDocuments(from urlString: String) {
        guard let url = URL(string: urlString) else {
           
            return
        }
        
        let documentsDirectoryURL = getDocumentsDirectory()
        let destinationURL = documentsDirectoryURL.appendingPathComponent("config.ovpn")
        
        let task = URLSession.shared.downloadTask(with: url) { (tempFileURL, response, error) in
            if let error = error {
                
                return
            }
            
            guard let tempFileURL = tempFileURL else {
                
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
                
            } catch {
                print("download error \(error)")
            }
        }
        task.resume()
    }
    
    
    
    
}
