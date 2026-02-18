//
//  ChatMessagesDatasourceInterface.swift
//  ChatModuleMessengerAppApple
//

import Foundation

public protocol ChatMessagesDatasourceInterface {
    func fetchMessagesList(roomId: Int64) async throws -> [ChatMessageEntity]
    func getMessage(id: String) async throws -> ChatMessageEntity
    func addMessage(message: ChatMessageEntity) async throws -> Bool
}
