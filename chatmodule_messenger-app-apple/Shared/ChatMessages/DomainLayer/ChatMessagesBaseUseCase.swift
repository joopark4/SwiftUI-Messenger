//
//  ChatMessagesBaseUseCase.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

protocol ChatMessagesBaseUseCase {
    associatedtype RequestValue
    associatedtype ResponseValue

    var repository: ChatMessagesRepositoryInterface { get }

    init(repository: ChatMessagesRepositoryInterface)

    func execute(value: RequestValue) -> ResponseValue
}

// 해당 방 모든 메시지 가져오기
public struct ChatMessagesListFetchUseCase: ChatMessagesBaseUseCase {

    typealias RequestValue = Int64
    typealias ResponseValue = AnyPublisher<[ChatMessageEntity], Error>
    let repository: ChatMessagesRepositoryInterface

    init(repository: ChatMessagesRepositoryInterface) {
        self.repository = repository
    }

    func execute(value: Int64) -> AnyPublisher<[ChatMessageEntity], Error> {
        self.repository.fetchMessagesList(roomId: value)
    }

}

// 메시지 하나 가져오기
public struct ChatMessageGetUseCase: ChatMessagesBaseUseCase {

    typealias RequestValue = String
    typealias ResponseValue = AnyPublisher<ChatMessageEntity, Error>
    let repository: ChatMessagesRepositoryInterface

    init(repository: ChatMessagesRepositoryInterface) {
        self.repository = repository
    }

    func execute(value: String) -> AnyPublisher<ChatMessageEntity, Error> {
        self.repository.getMessage(id: value)
    }
}

// 메시지 하나 저장
public struct ChatMessageAddUseCase: ChatMessagesBaseUseCase {

     typealias RequestValue = ChatMessageEntity
     typealias ResponseValue = AnyPublisher<Bool, Error>

     let repository: ChatMessagesRepositoryInterface

     init(repository: ChatMessagesRepositoryInterface) {
         self.repository = repository
     }

     func execute(value: ChatMessageEntity) -> AnyPublisher<Bool, Error> {
         self.repository.addMessage(message: value)
     }

 }
