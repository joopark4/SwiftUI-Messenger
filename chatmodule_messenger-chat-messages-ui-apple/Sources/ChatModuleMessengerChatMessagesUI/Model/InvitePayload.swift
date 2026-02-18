//
//  InvitePayload.swift
//  ChatModuleMessengerChatMessagesUI
//

import Foundation
import ChatModuleMessengerUI

public struct InvitePayload {

    public let invitee: AccountInfo

    public init(invitee: AccountInfo) {
        self.invitee = invitee
    }
}
