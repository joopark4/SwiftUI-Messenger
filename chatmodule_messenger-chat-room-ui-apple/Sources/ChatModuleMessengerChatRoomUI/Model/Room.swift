//
//  Room.swift
//  ChatModuleMessengerChatRoomUI
//

import Foundation


public struct Room: Identifiable {

    public let id: String
    public let roomType: RoomType
    public var lastMessageDate: Date?
    public var memberCount: Int
    public var maxMemberCount: Int
    public var lastMessage: String?
    public var name: String
    public var roomProfileUrl: String

    public init(id: String,
                roomType: RoomType,
                lastMessageDate: Date? = nil,
                memberCount: Int,
                maxMemberCount: Int,
                lastMessage: String? = nil,
                name: String,
                roomProfileUrl: String) {
        
        self.id = id
        self.roomType = roomType
        self.lastMessageDate = lastMessageDate
        self.memberCount = memberCount
        self.maxMemberCount = maxMemberCount
        self.lastMessage = lastMessage
        self.name = name
        self.roomProfileUrl = roomProfileUrl
    }
}
