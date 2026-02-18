//
//  ImagePayload.swift
//  ChatModuleMessengerChatMessagesUI
//

import Foundation

public struct ImagePayload {

    public let images: [ImageInfo]
    public let isfavorite: Bool
    public let totalSize: Int
    public let totalCount: Int

    public init(images: [ImageInfo],
                isfavorite: Bool,
                totalSize: Int,
                totalCount: Int) {
        
        self.images = images
        self.isfavorite = isfavorite
        self.totalSize = totalSize
        self.totalCount = totalCount
    }
}
