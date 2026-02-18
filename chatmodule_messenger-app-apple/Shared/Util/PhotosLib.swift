//
//  PhotosLib.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Photos

class PhotoLib {

    var allPhotos = PHFetchResult<PHAsset>()

    init() {
        self.fetchAllPhotos()
    }

    func fetchAllPhotos() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        allPhotos = PHAsset.fetchAssets(with: fetchOptions)
    }
}

struct PHFetchResultCollection: RandomAccessCollection, Equatable {

    typealias Element = PHAsset
    typealias Index = Int

    let fetchResult: PHFetchResult<PHAsset>

    var endIndex: Int { fetchResult.count }
    var startIndex: Int { 0 }

    subscript(position: Int) -> PHAsset {
        fetchResult.object(at: fetchResult.count - position - 1)
    }
}
