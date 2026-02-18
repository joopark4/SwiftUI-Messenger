//
//  FavoriteEmoticonInfo.swift
//  ChatModuleMessengerChatMessagesUI
//

import Foundation
import ChatModuleMessengerUI

public struct FavoriteEmoticonInfo {

    public let account: AccountInfo
    public let emoticonItem: EmoticonItemInfo

    public init(account: AccountInfo, emoticonItem: EmoticonItemInfo) {
        self.account = account
        self.emoticonItem = emoticonItem
    }
}
