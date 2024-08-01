//
//  SpeedTest.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/8/1.
//

import Foundation
import NDT7

class SpeedTest:ObservableObject{
    @Published var urlInput: String = "https://github.com"
    @Published var downloadTestSelected: Bool = true
    @Published var uploadTestSelected: Bool = true
    @Published var downloadSpeed: String = "00.0"
    @Published var uploadSpeed: String = "00.0"
    @Published var selectedThemeIndex: Int = 0
    private var ndt7Test: NDT7Test?
    
    func startTest() {
        guard let url = URL(string: urlInput) else {
            print("Invalid URL")
            return
        }
        let settings = NDT7Settings()
        ndt7Test = NDT7Test(settings: settings)
        ndt7Test?.delegate = self
        ndt7Test?.startTest(download: downloadTestSelected, upload: uploadTestSelected) { [weak self] (error) in
            if let error = error {
                print("NDT7 iOS Example app - Error during test: \(error.localizedDescription)")
            } else {
                print("NDT7 iOS Example app - Test finished.")
            }
        }
    }
    
    
    func cancelTest() {
        ndt7Test?.cancel()
    }
}

extension SpeedTest: NDT7TestInteraction {
    func test(kind: NDT7TestConstants.Kind, running: Bool) {
    }
    
    func measurement(origin: NDT7TestConstants.Origin, kind: NDT7TestConstants.Kind, measurement: NDT7Measurement) {
        switch kind {
        case .download:
            if let numBytes = measurement.appInfo?.numBytes, let elapsedTime = measurement.appInfo?.elapsedTime {
                let speed = (((Double(numBytes) * 8) / (Double(elapsedTime) / 1_000_000))) / 1_000_000
                downloadSpeed = String(format: "%.2f", speed)
            }
        case .upload:
            if let numBytes = measurement.appInfo?.numBytes, let elapsedTime = measurement.appInfo?.elapsedTime {
                let speed = (((Double(numBytes) * 8) / (Double(elapsedTime) / 1_000_000))) / 1_000_000
                uploadSpeed = String(format: "%.2f", speed)
            }
        }
    }
    
    func error(kind: NDT7TestConstants.Kind, error: NSError) {
        print("NDT7 iOS Example app - Error during test: \(error.localizedDescription)")
    }
}
