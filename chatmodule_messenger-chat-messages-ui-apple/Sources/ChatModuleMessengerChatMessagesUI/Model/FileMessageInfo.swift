//
//  FileMessageInfo.swift
//  ChatModuleMessengerChatMessagesUI
//

import Foundation
import ChatModuleMessengerUI
import ChatModuleMessengerChatRoomUI

public struct FileMessageInfo {

    public let room: Room
    public let message: MessageInfo
    public let fileAttach: FileAttach
    public let owner: AccountInfo

    public init(room: Room,
                message: MessageInfo,
                fileAttach: FileAttach,
                owner: AccountInfo) {
        
        self.room = room
        self.message = message
        self.fileAttach = fileAttach
        self.owner = owner
    }
}
