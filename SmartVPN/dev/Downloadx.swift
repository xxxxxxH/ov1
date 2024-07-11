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
    
    static  func downloadFileToDocuments(from urlString: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        let documentsDirectoryURL = getDocumentsDirectory()
        let destinationURL = documentsDirectoryURL.appendingPathComponent("config.ovpn")
        
        let task = URLSession.shared.downloadTask(with: url) { (tempFileURL, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let tempFileURL = tempFileURL else {
                completion(.failure(NSError(domain: "Download Error", code: -1, userInfo: nil)))
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
                completion(.success(destinationURL.path))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    
    
}
