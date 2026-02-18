//
//  RoomMember.swift
//  ChatModuleMessengerChatRoomUI
//

import Foundation
import ChatModuleMessengerUI

public struct RoomMember: Identifiable {

    public let id: String
    public let roomId: Room
    public let memberId: AccountInfo
    public var isLeave: Bool
    public var unreadCount: Int

    public init(id: String,
                roomId: Room,
                memberId: AccountInfo,
                isLeave: Bool = false,
                unreadCount: Int = 0) {

        self.id = id
        self.roomId = roomId
        self.memberId = memberId
        self.isLeave = isLeave
        self.unreadCount = unreadCount
    }
}
