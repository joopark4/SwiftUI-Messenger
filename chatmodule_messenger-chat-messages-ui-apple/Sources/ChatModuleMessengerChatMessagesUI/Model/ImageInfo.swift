//
//  ImageInfo.swift
//  ChatModuleMessengerChatMessagesUI
//

import Foundation

public struct ImageInfo {
    public let id: String
    public let width: Int
    public let height: Int
    public let url: String
    public let type: ImageType
    public let size: Int

    public init(id: String = "",
                width: Int = 0,
                height: Int = 0,
                url: String = "",
                type: ImageType = .ORIGINAL,
                size: Int = 0) {
        self.id = id
        self.width = width
        self.height = height
        self.url = url
        self.type = type
        self.size = size
    }
}
