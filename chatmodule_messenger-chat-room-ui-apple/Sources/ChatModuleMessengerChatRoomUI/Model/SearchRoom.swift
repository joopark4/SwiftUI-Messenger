//
//  SearchRoom.swift
//  ChatModuleMessengerChatRoomUI
//

import Foundation

public struct SearchRoom {

    public let searchWord: String
    public let pageSize: Int
    public let pageCount: Int

    public init(searchWord: String,
                pageSize: Int = 0,
                pageCount: Int = 0) {
        self.searchWord = searchWord
        self.pageSize = pageSize
        self.pageCount = pageCount
    }
}
