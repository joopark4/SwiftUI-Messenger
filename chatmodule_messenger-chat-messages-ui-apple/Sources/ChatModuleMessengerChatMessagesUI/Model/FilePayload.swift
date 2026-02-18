//
//  FilePayload.swift
//  ChatModuleMessengerChatMessagesUI
//

import Foundation

public struct FilePayload {

    public let file: FileInfo

    public init(file: FileInfo) {
        self.file = file
    }
}
