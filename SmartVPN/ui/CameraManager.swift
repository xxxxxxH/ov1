//
//  CameraManager.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/31.
//

import SwiftUI

import AVFoundation

class CameraManager: ObservableObject {
    private var captureDevice: AVCaptureDevice?

    init() {
        configure()
    }

    private func configure() {
        if let device = AVCaptureDevice.default(for: .video) {
            self.captureDevice = device
        }
    }

    func toggleFlashlight(on: Bool) {
        guard let device = captureDevice, device.hasTorch else { return }

        do {
            try device.lockForConfiguration()
            device.torchMode = on ? .on : .off
            device.unlockForConfiguration()
        } catch {
            print("Error toggling flashlight: \(error)")
        }
    }
}
