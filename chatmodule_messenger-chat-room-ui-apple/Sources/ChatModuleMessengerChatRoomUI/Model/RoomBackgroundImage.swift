//
//  RoomBackgroundImage.swift
//  ChatModuleMessengerChatRoomUI
//

import Foundation


public struct RoomBackgroundImage {

    public var fileName: String?
    public var fileExtension: String?


    public init(fileName: String? = nil, fileExtension: String? = nil) {
        self.fileName = fileName
        self.fileExtension = fileExtension
    }

}
