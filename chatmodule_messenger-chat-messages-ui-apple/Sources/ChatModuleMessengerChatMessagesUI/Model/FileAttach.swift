//
//  FileAttach.swift
//  ChatModuleMessengerChatMessagesUI
//

import Foundation

public struct FileAttach: Identifiable {

    public let id: String
    public let fileName: String
    public let fileSize: Int
    public let isDownload: Bool
    public let expireDate: Date
    public let createDate: Date
    public let updateDate: Date
    public let thumbnailSize: Int
    public let thumbnailUrl: String
    public let format: String
    public let url: String

    public init(id: String,
                fileName: String,
                fileSize: Int,
                isDownload: Bool,
                expireDate: Date,
                createDate: Date,
                updateDate: Date,
                thumbnailSize: Int,
                thumbnailUrl: String,
                format: String,
                url: String) {
        
        self.id = id
        self.fileName = fileName
        self.fileSize = fileSize
        self.isDownload = isDownload
        self.expireDate = expireDate
        self.createDate = createDate
        self.updateDate = updateDate
        self.thumbnailSize = thumbnailSize
        self.thumbnailUrl = thumbnailUrl
        self.format = format
        self.url = url
    }
    
}
