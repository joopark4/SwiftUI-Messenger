//
//  MessageInfo.swift
//  ChatModuleMessengerChatMessagesUI
//

import Foundation
import ChatModuleMessengerUI

public struct MessageInfo {

    public let id: String
    public let type: MessageType
    public let payload: Payload
    public let roomId: String
    public let toAccount: AccountInfo
    public let fromAccount: AccountInfo
    public let flow: MessageFlow
    public let date: Int
    public let status: MessageStatus
    public let participantStatus: ParticipantStatus
    public let isRead: Bool
    public let isDeleted: Bool

    public init(id: String = "",
                type: MessageType = .TEXT,
                payload: Payload = .init(payloadType: .TEXT(text: "")),
                roomId: String = "",
                toAccount: AccountInfo = AccountInfo(signInId: "", username: ""),
                fromAccount: AccountInfo = AccountInfo(signInId: "", username: ""),
                flow: MessageFlow = .SENT_MESSAGE,
                date: Int = 0,
                status: MessageStatus = .SUCCESS,
                participantStatus: ParticipantStatus = .NONE,
                isRead: Bool = false,
                isDeleted: Bool = false) {
        self.id = id
        self.type = type
        self.payload = payload
        self.roomId = roomId
        self.toAccount = toAccount
        self.fromAccount = fromAccount
        self.flow = flow
        self.date = date
        self.status = status
        self.participantStatus = participantStatus
        self.isRead = isRead
        self.isDeleted = isDeleted
    }
}


