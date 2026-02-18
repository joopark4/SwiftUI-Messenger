//
//  FileUploadItem.swift
//  ChatModuleMessengerChatMessagesUI
//

import Foundation

public struct FileUploadItem {

    public let uploadTime: Date
    public let progress: Int
    public let isUploading: Bool
    public let iscancel: Bool

    public init(uploadTime: Date, progress: Int, isUploading: Bool, iscancel: Bool) {
        self.uploadTime = uploadTime
        self.progress = progress
        self.isUploading = isUploading
        self.iscancel = iscancel
    }
}
