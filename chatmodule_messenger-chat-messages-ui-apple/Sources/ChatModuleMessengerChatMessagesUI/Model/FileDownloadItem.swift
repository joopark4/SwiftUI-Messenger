//
//  FileDownloadItem.swift
//  ChatModuleMessengerChatMessagesUI
//

import Foundation

public struct FileDownloadItem {

    public let downloadTime: Date
    public let progress: Int
    public let isDownloading: Bool
    public let isCancel: Bool

    public init(downloadTime: Date, progress: Int, isDownloading: Bool, isCancel: Bool) {
        self.downloadTime = downloadTime
        self.progress = progress
        self.isDownloading = isDownloading
        self.isCancel = isCancel
    }
}
