//
//  EmoticonSmileMeInfo.swift
//  ChatModuleMessengerChatMessagesUI
//

import Foundation
import ChatModuleMessengerUI

public struct EmoticonSmileMeInfo {

    public let id: String
    public let account: AccountInfo
    public let infos: [SmileMeInfo]
    public let urlOn: String
    public let urlOff: String

    public init(id: String,
                account: AccountInfo,
                infos: [SmileMeInfo],
                urlOn: String,
                urlOff: String) {

        self.id = id
        self.account = account
        self.infos = infos
        self.urlOn = urlOn
        self.urlOff = urlOff
    }
}
