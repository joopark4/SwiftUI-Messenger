//
//  RoomTextTone.swift
//  ChatModuleMessengerChatRoomUI
//

import Foundation

public struct RoomTextTone {
    public let fileName: String?
    public let fileExtension: String?
    public let category: String?
    public let index: Int?
    public let isDefault: Bool?

    public init(fileName: String? = nil,
                fileExtension: String? = nil,
                category: String? = nil,
                index: Int? = nil,
                isDefault: Bool? = nil) {

        self.fileName = fileName
        self.fileExtension = fileExtension
        self.category = category
        self.index = index
        self.isDefault = isDefault
    }
}
