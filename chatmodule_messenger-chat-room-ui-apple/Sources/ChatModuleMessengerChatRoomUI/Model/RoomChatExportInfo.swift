//
//  RoomChatExportInfo.swift
//  ChatModuleMessengerChatRoomUI
//

import Foundation
import ChatModuleMessengerUI


public struct RoomChatExportInfo: Identifiable {

    public let id: String
    public var statusType: RoomChatExportStatus
    public var format: String
    public var timezone: String
    public let createDate: Date
    public let endDate: Date
    public var members: AccountInfo
    public var downloadUrl: String?

    public init(id: String,
                statusType: RoomChatExportStatus,
                format: String,
                timezone: String,
                createDate: Date,
                endDate: Date,
                members: AccountInfo,
                downloadUrl: String? = nil) {
        
        self.id = id
        self.statusType = statusType
        self.format = format
        self.timezone = timezone
        self.createDate = createDate
        self.endDate = endDate
        self.members = members
        self.downloadUrl = downloadUrl
    }
}
