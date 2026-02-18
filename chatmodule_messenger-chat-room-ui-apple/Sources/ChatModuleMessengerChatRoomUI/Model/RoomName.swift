//
//  RoomName.swift
//  ChatModuleMessengerChatRoomUI
//

import Foundation

public struct RoomName: Identifiable {

    public var id: String {
        get { roomId }
    }

    public let roomId: String
    public let memberId: String
    public var name: String

    public init(roomId: String,
                memberId: String,
                name: String) {
        self.roomId = roomId
        self.memberId = memberId
        self.name = name
    }
}
