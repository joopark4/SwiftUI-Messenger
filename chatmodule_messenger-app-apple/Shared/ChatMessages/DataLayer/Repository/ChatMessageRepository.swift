//
//  ChatMessageRepository.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

public class ChatMessageRepository: ChatMessagesRepositoryInterface {
    private let messagesDataSource: ChatMessagesDatasourceInterface?

    init(messagesDataSource: ChatMessagesDatasourceInterface? = nil) {
        self.messagesDataSource = messagesDataSource
    }

    public func fetchMessagesList(roomId: Int64) -> AnyPublisher<[ChatMessageEntity], Error> {

        guard let messagesDataSource = messagesDataSource else {
            return Fail(error: ChatMessageError.unknown).eraseToAnyPublisher()
        }

        return Just(())
            .setFailureType(to: Error.self)
            .tryAsyncMap { try await messagesDataSource.fetchMessagesList(roomId: roomId) }
            .eraseToAnyPublisher()
    }

    public func getMessage(id: String) -> AnyPublisher<ChatMessageEntity, Error> {
        guard let messagesDataSource = messagesDataSource else {
            return Fail(error: ChatMessageError.unknown).eraseToAnyPublisher()
        }

        return Just(())
            .setFailureType(to: Error.self)
            .tryAsyncMap { try await messagesDataSource.getMessage(id: id) }
            .eraseToAnyPublisher()
    }

    public func addMessage(message: ChatMessageEntity) -> AnyPublisher<Bool, Error> {
        guard let messagesDataSource = messagesDataSource else {
            return Fail(error: ChatMessageError.unknown).eraseToAnyPublisher()
        }

        return Just(())
            .setFailureType(to: Error.self)
            .tryAsyncMap { try await  messagesDataSource.addMessage(message: message) }
            .eraseToAnyPublisher()
    }

}
