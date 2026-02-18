//
//  FriendsUseCase.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

protocol FriendsBaseUseCase {
    associatedtype RequestValue
    associatedtype ResponseValue

    var repository: FriendsRepositoryInterface { get }

    init(repository: FriendsRepositoryInterface)

    func execute(value: RequestValue) -> ResponseValue
}

public struct FriendsAddUseCaseRequestValue {
    public let friendName: String
    public let phoneNumber: String

    public init(friendName: String, phoneNumber: String) {
        self.friendName = friendName
        self.phoneNumber = phoneNumber
    }
}

public struct FriendsAddUseCase: FriendsBaseUseCase {

    typealias RequestValue = FriendsAddUseCaseRequestValue
    typealias ResponseValue = AnyPublisher<FriendEntity, Error>
    let repository: FriendsRepositoryInterface

    init(repository: FriendsRepositoryInterface) {
        self.repository = repository
    }

    func execute(value: FriendsAddUseCaseRequestValue) -> AnyPublisher<FriendEntity, Error> {
        return repository.addFriend(friendInfo: value)
    }
}

public struct FriendsModifierUseCase: FriendsBaseUseCase {

    typealias RequestValue = FriendEntity
    typealias ResponseValue = AnyPublisher<FriendEntity, Error>
    let repository: FriendsRepositoryInterface

    init(repository: FriendsRepositoryInterface) {
        self.repository = repository
    }

    func execute(value: FriendEntity) -> AnyPublisher<FriendEntity, Error> {
        return repository.modifierFriend(friendInfo: value)
    }
}

/*
public struct FriendDeleteUseCase: FriendsBaseUseCase {

    typealias RequestValue = Int64
    typealias ResponseValue = Bool
    let repository: FriendsRepositoryInterface

    init(repository: FriendsRepositoryInterface) {
        self.repository = repository
    }

    func execute(value: Int64) -> Bool {
        return repository.deleteFriend(id: value)
    }
}

public struct FriendSearchUseCase: FriendsBaseUseCase {

    typealias RequestValue = String
    typealias ResponseValue = AnyPublisher<[FriendEntity], Error>
    let repository: FriendsRepositoryInterface

    init(repository: FriendsRepositoryInterface) {
        self.repository = repository
    }

    func execute(value: String) -> AnyPublisher<[FriendEntity], Error> {
        return repository.searchFriend(naem: value)
    }
}
 */

public struct FriendsListFetchUseCase: FriendsBaseUseCase {

    typealias RequestValue = Void
    typealias ResponseValue = AnyPublisher<[FriendEntity], Error>
    let repository: FriendsRepositoryInterface

    init(repository: FriendsRepositoryInterface) {
        self.repository = repository
    }

    func execute(value: Void) -> AnyPublisher<[FriendEntity], Error> {
        return repository.fetchFriendsList()
    }
}

public struct CountryListFetchUseCase: FriendsBaseUseCase {
    typealias RequestValue = String
    typealias ResponseValue = AnyPublisher<[CountryEntity], Error>

    let repository: FriendsRepositoryInterface

    init(repository: FriendsRepositoryInterface) {
        self.repository = repository
    }

    func execute(value: String) -> AnyPublisher<[CountryEntity], Error> {
        return repository.fetchCountryList(countryCode: value)
    }
}

public struct CountryGetRegionUseCase: FriendsBaseUseCase {
    typealias RequestValue = String
    typealias ResponseValue = AnyPublisher<String, Error>

    let repository: FriendsRepositoryInterface

    init(repository: FriendsRepositoryInterface) {
        self.repository = repository
    }

    func execute(value: String) -> AnyPublisher<String, Error> {
        return repository.getRegion(countryCode: value)
    }
}
