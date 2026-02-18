//
//  EmoticonItemInfo.swift
//  ChatModuleMessengerChatMessagesUI
//

import Foundation

public struct EmoticonItemInfo {
    let id: String
    let emoticonInfoId: String
    let name: String
    let url: String
    let nameThumb: String
    let urlThumb: String
    
    public init(id: String,
                emoticonInfoId: String,
                name: String,
                url: String,
                nameThumb: String,
                urlThumb: String) {
        self.id = id
        self.emoticonInfoId = emoticonInfoId
        self.name = name
        self.url = url
        self.nameThumb = nameThumb
        self.urlThumb = urlThumb
    }

}
