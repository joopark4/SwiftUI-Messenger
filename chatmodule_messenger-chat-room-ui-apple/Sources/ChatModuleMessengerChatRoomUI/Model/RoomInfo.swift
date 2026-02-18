//
//  RoomInfo.swift
//  ChatModuleMessengerChatRoomUI
//

import Foundation
import ChatModuleMessengerUI

public struct RoomInfo: Identifiable {
    public var id: Int64 {
        get { roomId }
    }
    
    public let roomId: Int64
    public let owner: AccountInfo?
    public var members: [Int]
    public var currentBackground: RoomBackground?
    public var currentTextTone: RoomTextTone?
    public var isLeave: Bool?
    public var isFavorite: Bool
    public var isNotReceiveNotification: Bool
    public var unreadCount: Int
    public var roomType: RoomType
    public var lastMessage: String?
    public var lastMessageDate: String?
    public var memberCount: Int
    public var maxMemberCount: Int
    public var roomName: String?
    public var roomProfileUrl: String?
    public var defaultName: String?
    public var defaultProfileUrl: String?

    public init(roomId: Int64,
                owner: AccountInfo? = nil,
                members: [Int] = [],
                currentBackground: RoomBackground? = nil,
                currentTextTone: RoomTextTone? = nil,
                isLeave: Bool? = nil,
                isFavorite: Bool = false,
                isNotReceiveNotification: Bool = false,
                unreadCount: Int = 0,
                roomType: RoomType = .SINGLE,
                lastMessage: String? = nil,
                lastMessageDate: String? = nil,
                memberCount: Int = 0,
                maxMemberCount: Int = 100,
                roomName: String? = nil,
                roomProfileUrl: String? = nil,
                defaultName: String? = nil,
                defaultProfileUrl: String? = nil) {

        self.roomId = roomId
        self.owner = owner
        self.members = members
        self.currentBackground = currentBackground
        self.currentTextTone = currentTextTone
        self.isLeave = isLeave
        self.isFavorite = isFavorite
        self.isNotReceiveNotification = isNotReceiveNotification
        self.unreadCount = unreadCount
        self.roomType = roomType
        self.lastMessage = lastMessage
        self.lastMessageDate = lastMessageDate
        self.memberCount = memberCount
        self.maxMemberCount = maxMemberCount
        self.roomName = roomName
        self.roomProfileUrl = roomProfileUrl
        self.defaultName = defaultName
        self.defaultProfileUrl = defaultProfileUrl
    }
}
