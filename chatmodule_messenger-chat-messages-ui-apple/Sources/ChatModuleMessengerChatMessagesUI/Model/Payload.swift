//
//  Payload.swift
//  ChatModuleMessengerChatMessagesUI
//

import Foundation

public struct Payload {
    public let payloadType: PayloadType
    
    public init(payloadType: PayloadType) {
        self.payloadType = payloadType
    }
}
