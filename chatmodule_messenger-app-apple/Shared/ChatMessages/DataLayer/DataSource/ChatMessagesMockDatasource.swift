//
//  ChatMessagesMockDatasource.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine
import ChatModuleMessengerUI
import ChatModuleMessengerChatRoomUI
import ChatModuleMessengerChatMessagesUI

public final actor ChatMessagesMockDatasource: ChatMessagesDatasourceInterface {
    var mockDates = [ChatMessageEntity]([
        ChatMessageEntity(id: "1", type: .PREVIOUS_DATE,
                     date: Int(Date().timeIntervalSince1970)),
        ChatMessageEntity(id: "2", type: .INVITE,
                     toAccount: AccountEntity(signInId: "", username: "김가렌"),
                     fromAccount: AccountEntity(signInId: "", username: "박티모"),
                     participantStatus: .INVITED_CHATROOM),

        ChatMessageEntity(id: "3", type: .EXIT,
                     fromAccount: AccountEntity(signInId: "", username: "티모"),
                     participantStatus: .REINVITE_CHATROOM),
        ChatMessageEntity(id: "4", type: .EXIT,
                     fromAccount: AccountEntity(signInId: "", username: "티모"),
                     participantStatus: .REINVITE_CHATROOM),
        ChatMessageEntity(id: "5", type: .TEXT,
                          payload: .init(payloadType: .TEXT(text: "Hello world!!")),
                     flow: .RECEIVED_MESSAGE),
        ChatMessageEntity(id: "6", type: .TEXT,
                          payload: .init(payloadType: .TEXT(text: "Hello world!!")),
                     flow: .SENT_MESSAGE),
        ChatMessageEntity(id: "7", type: .MASS_TEXT,
                          payload: .init(payloadType: .TEXT(text: "헬로 www.google.com blahblah 헬로 www.google.com" +
                                                            "blahblah 헬로 www.google.com blah")), flow: .SENT_MESSAGE),
        ChatMessageEntity(id: "8", type: .MASS_TEXT,
                          payload: .init(payloadType: .TEXT(text: "헬로 www.google.com blahblah 헬로 www.google.com" +
                                                            "blahblah 헬로 www.google.com blah")), flow: .RECEIVED_MESSAGE),
        ChatMessageEntity(id: "9", type: .IMAGE,
                          payload: .init(payloadType: .IMAGE(id: "", extensionInfo: "",
                                                             images: [ImageInfo](repeating: ImageInfo(), count: 7))),
                                                            flow: .SENT_MESSAGE),
        ChatMessageEntity(id: "10", type: .IMAGE,
                          payload: .init(payloadType: .IMAGE(id: "", extensionInfo: "",
                                                             images: [ImageInfo](repeating: ImageInfo(), count: 7))),
                                                            flow: .RECEIVED_MESSAGE),
        ChatMessageEntity(id: "11", type: .VIDEO, flow: .SENT_MESSAGE),
        ChatMessageEntity(id: "12", type: .VIDEO, flow: .RECEIVED_MESSAGE),
        ChatMessageEntity(id: "13", type: .SMILEME, flow: .SENT_MESSAGE),
        ChatMessageEntity(id: "14", type: .SMILEME, flow: .RECEIVED_MESSAGE),
        ChatMessageEntity(id: "15", type: .FILE, flow: .SENT_MESSAGE),
        ChatMessageEntity(id: "16", type: .FILE, flow: .RECEIVED_MESSAGE)
    ])

    public func fetchMessagesList(roomId: Int64) async throws -> [ChatMessageEntity] {
        return mockDates
    }

    public func getMessage(id: String) async throws -> ChatMessageEntity {
        if let data = mockDates.filter({ $0.id == id }).first {
            return data
        } else {
            throw ChatMessageError.unknown
        }
    }

    public func addMessage(message: ChatMessageEntity) async throws -> Bool {
        mockDates.append(message)

        return true
    }

}
