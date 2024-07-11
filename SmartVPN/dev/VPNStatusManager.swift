//
//  VPNStatusManager.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/11.
//

import NetworkExtension
import Combine

class VPNStatusManager: ObservableObject {
    @Published var vpnStatus: NEVPNStatus = .invalid
    private var connectionStatusObserver: Any?

    init() {
        observeVPNStatus()
    }

    private func observeVPNStatus() {
        connectionStatusObserver = NotificationCenter.default.addObserver(
            forName: .NEVPNStatusDidChange,
            object: nil,
            queue: OperationQueue.main
        ) { [weak self] notification in
            self?.vpnStatusDidChange(notification: notification)
        }
    }

    private func vpnStatusDidChange(notification: Notification) {
        guard let connection = notification.object as? NEVPNConnection else { return }
        vpnStatus = connection.status
    }

    func statusDescription(for status: NEVPNStatus) -> String {
        switch status {
        case .invalid:
            return "Invalid"
        case .disconnected:
            return "Disconnected"
        case .connecting:
            return "Connecting"
        case .connected:
            return "Connected"
        case .reasserting:
            return "Reasserting"
        case .disconnecting:
            return "Disconnecting"
        @unknown default:
            return "Unknown"
        }
    }

    deinit {
        if let observer = connectionStatusObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}


