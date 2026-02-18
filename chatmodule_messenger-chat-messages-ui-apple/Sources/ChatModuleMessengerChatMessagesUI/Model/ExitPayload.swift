//
//  ExitPayload.swift
//  ChatModuleMessengerChatMessagesUI
//

import Foundation
import ChatModuleMessengerUI

public struct ExitPayload {

    public let exit: AccountInfo
    public let isInvite: Bool

    public init(exit: AccountInfo, isInvite: Bool) {
        self.exit = exit
        self.isInvite = isInvite
    }
}
