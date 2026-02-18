//
//  ChatRoomRepository.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

public struct ChatRoomRepository: ChatRoomRepositoryInterface {
    private let dataSource: ChatRoomDataSourceInterface?

    internal init(dataSource: ChatRoomDataSourceInterface? = nil) {
        self.dataSource = dataSource
    }

    public func createRoom(_ value: ChatRoomCreateUseCase.Request) -> AnyPublisher<ChatRoomEntity, Error> {
        guard let dataSource = dataSource else {
            return Fail(error: ChatRoomError.unknown)
                .eraseToAnyPublisher()
        }

        return Just(value)
            .setFailureType(to: Error.self)
            .tryAsyncMap { try await dataSource.createRoom($0) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    public func fetchRoomList() -> AnyPublisher<[ChatRoomEntity], Error> {
        guard let dataSource = dataSource else {
            return Fail(error: ChatRoomError.unknown)
                .eraseToAnyPublisher()
        }

        return Just(())
            .setFailureType(to: Error.self)
            .tryAsyncMap { try await dataSource.fetchRoomList() }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    public func leaveRoom(roomId: Int64) -> AnyPublisher<Bool, Error> {
        guard let dataSource = dataSource else {
            return Fail(error: ChatRoomError.unknown)
                .eraseToAnyPublisher()
        }

        return Just(roomId)
            .setFailureType(to: Error.self)
            .tryAsyncMap { try await dataSource.leaveRoom(roomId: $0) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    public func exportAllMessage(roomId: Int64) -> AnyPublisher<Bool, Error> {
        guard let dataSource = dataSource else {
            return Fail(error: ChatRoomError.unknown)
                .eraseToAnyPublisher()
        }

        return Just(roomId)
            .setFailureType(to: Error.self)
            .tryAsyncMap { try await dataSource.exportAllMessage(roomId: $0) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    public func deleteAllMessage(roomId: Int64) -> AnyPublisher<Bool, Error> {
        guard let dataSource = dataSource else {
            return Fail(error: ChatRoomError.unknown)
                .eraseToAnyPublisher()
        }

        return Just(roomId)
            .setFailureType(to: Error.self)
            .tryAsyncMap { try await dataSource.deleteAllMessage(roomId: $0) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    public func modifyRoomWallpaper(_ value: ChatRoomModifyWallpaperUseCase.Request) -> AnyPublisher<Bool, Error> {
        guard let dataSource = dataSource else {
            return Fail(error: ChatRoomError.unknown)
                .eraseToAnyPublisher()
        }

        return Just(value)
            .setFailureType(to: Error.self)
            .tryAsyncMap { try await dataSource.modifyRoomWallpaper($0) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    public func modifyRoomTextTone(_ value: ChatRoomModifyTextToneUseCase.Request) -> AnyPublisher<Bool, Error> {
        guard let dataSource = dataSource else {
            return Fail(error: ChatRoomError.unknown)
                .eraseToAnyPublisher()
        }

        return Just(value)
            .setFailureType(to: Error.self)
            .tryAsyncMap { try await dataSource.modifyRoomTextTone($0) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    public func modifyRoomName(_ value: ChatRoomModifyRoomNameUseCase.Request) -> AnyPublisher<Bool, Error> {
        guard let dataSource = dataSource else {
            return Fail(error: ChatRoomError.unknown)
                .eraseToAnyPublisher()
        }

        return Just(value)
            .setFailureType(to: Error.self)
            .tryAsyncMap { try await dataSource.modifyRoomName($0) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
