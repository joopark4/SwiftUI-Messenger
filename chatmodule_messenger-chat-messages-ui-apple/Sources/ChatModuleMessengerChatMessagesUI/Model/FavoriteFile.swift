//
//  FavoriteFile.swift
//  ChatModuleMessengerChatMessagesUI
//

import Foundation
import ChatModuleMessengerUI

public struct FavoriteFile {

    public let account: AccountInfo
    public let file: FileAttach

    public init(account: AccountInfo, file: FileAttach) {
        self.account = account
        self.file = file
    }
}
