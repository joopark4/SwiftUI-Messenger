//
//  Photos+Extension.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import SwiftUI
import Photos

extension PHPhotoLibrary {

    static func checkAuthorizationStatus(completion: @escaping (_ status: Bool) -> Void) {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            completion(true)
        } else {
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                if newStatus == PHAuthorizationStatus.authorized {
                    completion(true)
                } else {
                    completion(false)
                }
            })
        }
    }
}

extension PHAsset {
    func getAssetThumbnail(size: CGSize) -> UIImage {
        let manager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        var thumbnail = UIImage()

        requestOptions.isSynchronous = true
        requestOptions.isNetworkAccessAllowed = true
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.opportunistic

        manager.requestImage(for: self,
                                targetSize: size,
                                contentMode: .default,
                                options: requestOptions,
                                resultHandler: {(result, _) -> Void in

            if let result = result {
                thumbnail = result
            }
        })

        return thumbnail
    }

    func getOrginalImage(complition:@escaping (UIImage) -> Void) {
        let manager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        var image = UIImage()

        manager.requestImage(for: self,
                targetSize: PHImageManagerMaximumSize,
                contentMode: .default,
                options: requestOptions,
                resultHandler: {(result, _) -> Void in

            if let result = result {
                image = result
            }

            complition(image)
        })
    }

    func getImageFromPHAsset() -> UIImage {
        var image = UIImage()
        let manager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()

        requestOptions.resizeMode = PHImageRequestOptionsResizeMode.none
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
        requestOptions.isSynchronous = true
        requestOptions.isNetworkAccessAllowed = true

        manager.requestImage(for: self,
                                targetSize: PHImageManagerMaximumSize,
                                contentMode: .default,
                                options: requestOptions,
                                resultHandler: { (pickedImage, _) in
            if let pickedImage = pickedImage {
                image = pickedImage
            }
        })

        return image
    }

}
