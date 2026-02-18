//
//  RoomSetting.swift
//  ChatModuleMessengerChatRoomUI
//

import Foundation

public struct RoomSetting: Identifiable {

    public var id: String {
        get {roomId}
    }

    public let roomId: String
    public let memberId: String
    public var currentBackground: RoomBackground
    public var currentTextTone: RoomTextTone
    public var isNotReceiveNotifivation: Bool
    public var roomName: String
    public var roomProfileUrl: String

    public init(roomId: String,
                memberId: String,
                currentBackground: RoomBackground,
                currentTextTone: RoomTextTone,
                isNotReceiveNotifivation: Bool,
                roomName: String,
                roomProfileUrl: String) {
        
        self.roomId = roomId
        self.memberId = memberId
        self.currentBackground = currentBackground
        self.currentTextTone = currentTextTone
        self.isNotReceiveNotifivation = isNotReceiveNotifivation
        self.roomName = roomName
        self.roomProfileUrl = roomProfileUrl
    }
}
