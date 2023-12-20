//
//  PhotosManager.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 19/12/2023.
//

import Foundation
import Photos
import UIKit

struct PhotosManager {
    
    static func hasCameraPermission() async -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        guard status == .authorized else {
            let isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
            return isAuthorized
        }
        return true
    }
    
    static func hasPhotoLibraryPermission() async -> Bool {
        let currentStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        guard currentStatus != .authorized else { return true }
        let updatedStatus = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
        if updatedStatus == .authorized {
            return true
        } else {
            return false
        }
    }
    
    
    static func openAppPrivacySettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) else {
            print("Not able to open App privacy settings")
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    
}
