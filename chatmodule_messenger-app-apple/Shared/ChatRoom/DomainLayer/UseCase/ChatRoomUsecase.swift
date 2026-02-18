//
//  ChatRoomUsecase.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

protocol ChatRoomBaseUseCase {
    associatedtype RequestValue
    associatedtype ResponseValue

    var repository: ChatRoomRepositoryInterface { get }

    init(repository: ChatRoomRepositoryInterface)

    func execute(_ value: RequestValue) -> ResponseValue
}

public struct ChatRoomCreateUseCase: ChatRoomBaseUseCase {
    public struct Request {
        let roomName: String
    }
    typealias RequestValue = Request
    typealias ResponseValue = AnyPublisher<ChatRoomEntity, Error>

    let repository: ChatRoomRepositoryInterface

    init(repository: ChatRoomRepositoryInterface) {
        self.repository = repository
    }

    func execute(_ value: Request) -> AnyPublisher<ChatRoomEntity, Error> {
        return self.repository.createRoom(value)
    }
}

public struct ChatRoomFetchListUseCase: ChatRoomBaseUseCase {
    typealias RequestValue = Void
    typealias ResponseValue = AnyPublisher<[ChatRoomEntity], Error>

    let repository: ChatRoomRepositoryInterface

    init(repository: ChatRoomRepositoryInterface) {
        self.repository = repository
    }

    func execute(_ value: Void) -> AnyPublisher<[ChatRoomEntity], Error> {
        return self.repository.fetchRoomList()
    }
}

public struct ChatRoomLeaveUseCase: ChatRoomBaseUseCase {
    typealias RequestValue = Int64
    typealias ResponseValue = AnyPublisher<Bool, Error>

    let repository: ChatRoomRepositoryInterface

    init(repository: ChatRoomRepositoryInterface) {
        self.repository = repository
    }

    func execute(_ roomId: Int64) -> AnyPublisher<Bool, Error> {
        return self.repository.leaveRoom(roomId: roomId)
    }
}

public struct ChatRoomExportMessageUseCase: ChatRoomBaseUseCase {
    typealias RequestValue = Int64
    typealias ResponseValue = AnyPublisher<Bool, Error>

    let repository: ChatRoomRepositoryInterface

    init(repository: ChatRoomRepositoryInterface) {
        self.repository = repository
    }

    func execute(_ roomId: Int64) -> AnyPublisher<Bool, Error> {
        return self.repository.exportAllMessage(roomId: roomId)
    }
}

public struct ChatRoomDeleteMessageUseCase: ChatRoomBaseUseCase {
    typealias RequestValue = Int64
    typealias ResponseValue = AnyPublisher<Bool, Error>

    let repository: ChatRoomRepositoryInterface

    init(repository: ChatRoomRepositoryInterface) {
        self.repository = repository
    }

    func execute(_ roomId: Int64) -> AnyPublisher<Bool, Error> {
        return self.repository.deleteAllMessage(roomId: roomId)
    }
}

public struct ChatRoomModifyWallpaperUseCase: ChatRoomBaseUseCase {
    public struct Request {
        let roomId: Int64
        let wallpaper: String
    }
    typealias RequestValue = Request
    typealias ResponseValue = AnyPublisher<Bool, Error>

    let repository: ChatRoomRepositoryInterface

    init(repository: ChatRoomRepositoryInterface) {
        self.repository = repository
    }

    func execute(_ value: Request) -> AnyPublisher<Bool, Error> {
        return self.repository.modifyRoomWallpaper(value)
    }
}

public struct ChatRoomModifyTextToneUseCase: ChatRoomBaseUseCase {
    public struct Request {
        let roomId: Int64
        let textTone: String
    }
    typealias RequestValue = Request
    typealias ResponseValue = AnyPublisher<Bool, Error>

    let repository: ChatRoomRepositoryInterface

    init(repository: ChatRoomRepositoryInterface) {
        self.repository = repository
    }

    func execute(_ value: Request) -> AnyPublisher<Bool, Error> {
        return self.repository.modifyRoomTextTone(value)
    }
}

public struct ChatRoomModifyRoomNameUseCase: ChatRoomBaseUseCase {
    public struct Request {
        let roomId: Int64
        let roomName: String
    }
    typealias RequestValue = Request
    typealias ResponseValue = AnyPublisher<Bool, Error>

    let repository: ChatRoomRepositoryInterface

    init(repository: ChatRoomRepositoryInterface) {
        self.repository = repository
    }

    func execute(_ value: Request) -> AnyPublisher<Bool, Error> {
        return self.repository.modifyRoomName(value)
    }
}
