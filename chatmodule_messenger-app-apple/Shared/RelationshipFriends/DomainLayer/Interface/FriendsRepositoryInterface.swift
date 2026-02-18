//
//  FriendsRepositoryInterface.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

public protocol FriendsRepositoryInterface {
    func addFriend(friendInfo: FriendsAddUseCaseRequestValue) -> AnyPublisher<FriendEntity, Error>
//    func deleteFriendService(id: Int) -> Bool
    func modifierFriend(friendInfo: FriendEntity) -> AnyPublisher<FriendEntity, Error>
//    func searchFriendService(naem: String) -> AnyPublisher<[FriendEntity], Error>
    func fetchFriendsList() -> AnyPublisher<[FriendEntity], Error>
    func fetchCountryList(countryCode: String) -> AnyPublisher<[CountryEntity], Error>
    func getRegion(countryCode: String) -> AnyPublisher<String, Error>
}
