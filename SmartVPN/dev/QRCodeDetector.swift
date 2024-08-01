//
//  QRCodeDetector.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/31.
//

import UIKit
import Vision

class QRCodeDetector {
    static func detectQRCode(in image: UIImage, completion: @escaping (String?) -> Void) {
        guard let cgImage = image.cgImage else {
            completion(nil)
            return
        }

        let request = VNDetectBarcodesRequest { request, error in
            if let error = error {
                print("Error detecting barcodes: \(error)")
                completion(nil)
                return
            }

            guard let result = request.results?.compactMap({ $0 as? VNBarcodeObservation }).first,
                  let payload = result.payloadStringValue else {
                completion(nil)
                return
            }

            completion(payload)
        }

        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print("Error performing request: \(error)")
                completion(nil)
            }
        }
    }
}
