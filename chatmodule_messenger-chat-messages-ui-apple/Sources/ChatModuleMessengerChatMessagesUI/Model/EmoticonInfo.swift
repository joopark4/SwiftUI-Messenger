//
//  EmoticonInfo.swift
//  ChatModuleMessengerChatMessagesUI
//

import Foundation

public struct EmoticonInfo {
    let id: String
    let version: Int
    let name: String
    let index: Int
    let urlOn: String
    let urlOff: String
    let useYn: Int
    let items: [EmoticonItemInfo]
    
    public init(id: String,
                version: Int,
                name: String,
                index: Int,
                urlOn: String,
                urlOff: String,
                useYn: Int,
                items: [EmoticonItemInfo]) {
        self.id = id
        self.version = version
        self.name = name
        self.index = index
        self.urlOn = urlOn
        self.urlOff = urlOff
        self.useYn = useYn
        self.items = items
    }

}
