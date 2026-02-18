//
//  FriendsRepository.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

public struct FriendsRepository: FriendsRepositoryInterface {

    private let friendDataSource: FriendsDataSourceInterface?
    private let phoenNumberDataSource: PhoneNumberDataSourceInterface?

    init(friendDataSource: FriendsDataSourceInterface? = nil,
         phoenNumberDataSource: PhoneNumberDataSourceInterface? = nil) {
        self.friendDataSource = friendDataSource
        self.phoenNumberDataSource = phoenNumberDataSource
    }

    public func addFriend(friendInfo: FriendsAddUseCaseRequestValue) -> AnyPublisher<FriendEntity, Error> {
        guard let friendDataSource = friendDataSource else { return Fail(error: FriendError.unknown).eraseToAnyPublisher() }

        return Just(friendInfo)
            .setFailureType(to: Error.self)
            .tryAsyncMap { try await friendDataSource.addFriend(friendInfo: $0) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    public func modifierFriend(friendInfo: FriendEntity) -> AnyPublisher<FriendEntity, Error> {
        guard let friendDataSource = friendDataSource else { return Fail(error: FriendError.unknown).eraseToAnyPublisher() }

        return Just(friendInfo)
            .setFailureType(to: Error.self)
            .tryAsyncMap { try await friendDataSource.modifierFriend(friendInfo: $0) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    public func fetchFriendsList() -> AnyPublisher<[FriendEntity], Error> {
        guard let friendDataSource = friendDataSource else { return Fail(error: FriendError.unknown).eraseToAnyPublisher() }

        return Just(())
            .setFailureType(to: Error.self)
            .tryAsyncMap { try await friendDataSource.fetchFriendsList() }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    public func fetchCountryList(countryCode: String) -> AnyPublisher<[CountryEntity], Error> {
        guard let phoenNumberDataSource = phoenNumberDataSource else { return Fail(error: FriendError.unknown).eraseToAnyPublisher() }

        return Just(countryCode)
            .setFailureType(to: Error.self)
            .tryAsyncMap { try await phoenNumberDataSource.fetchCountryList(countryCode: $0)}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    public func getRegion(countryCode: String) -> AnyPublisher<String, Error> {
        guard let phoenNumberDataSource = phoenNumberDataSource else { return Fail(error: FriendError.unknown).eraseToAnyPublisher() }

        return Just(countryCode)
            .setFailureType(to: Error.self)
            .tryAsyncMap { try await phoenNumberDataSource.getRegion(countryCode: $0)}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
