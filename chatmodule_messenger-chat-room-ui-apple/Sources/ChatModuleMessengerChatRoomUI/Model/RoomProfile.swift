//
//  RoomProfile.swift
//  ChatModuleMessengerChatRoomUI
//

import Foundation

public struct RoomProfile: Identifiable {

    public var id: String {
        get { roomId }
    }

    public let roomId: String
    public let memberId: String
    public var profileUrl: String?

    public init(roomId: String,
                memberId: String,
                profileUrl: String? = nil) {

        self.roomId = roomId
        self.memberId = memberId
        self.profileUrl = profileUrl
    }
}
