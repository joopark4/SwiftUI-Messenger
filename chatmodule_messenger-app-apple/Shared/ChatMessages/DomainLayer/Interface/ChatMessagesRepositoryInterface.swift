//
//  ChatMessagesRepositoryInterface.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

public protocol ChatMessagesRepositoryInterface {

    func fetchMessagesList(roomId: Int64) -> AnyPublisher<[ChatMessageEntity], Error>
    func getMessage(id: String) -> AnyPublisher<ChatMessageEntity, Error>
    func addMessage(message: ChatMessageEntity) -> AnyPublisher<Bool, Error>
}
