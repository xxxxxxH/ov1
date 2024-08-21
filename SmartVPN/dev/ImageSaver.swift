//
//  ImageSaver.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/8/20.
//

import UIKit

class ImageSaver: NSObject {
    func saveImage(base64String: String, result: @escaping (Bool) -> Void) {
        DispatchQueue.global(qos: .background).async {
                    if let imageData = Data(base64Encoded: base64String),
                       let image = UIImage(data: imageData) {
                        
                        // 切换回主线程保存图片
                        DispatchQueue.main.async {
                            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.saveError), nil)
                            self.resultCallback = result
                        }
                    } else {
                        // 如果解码失败，直接在子线程回调
                        DispatchQueue.main.async {
                            result(false)
                        }
                    }
                }
    }

    // 用于保存闭包回调
    private var resultCallback: ((Bool) -> Void)?

    @objc private func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let _ = error {
            // 保存失败，回调 false
            resultCallback?(false)
        } else {
            // 保存成功，回调 true
            resultCallback?(true)
        }
    }
}
