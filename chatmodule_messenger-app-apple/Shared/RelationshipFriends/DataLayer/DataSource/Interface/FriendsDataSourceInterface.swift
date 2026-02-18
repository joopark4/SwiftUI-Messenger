//
//  FriendsDataSourceInterface.swift
//  ChatModuleMessengerAppApple
//

import Foundation

public protocol FriendsDataSourceInterface {
    func addFriend(friendInfo: FriendsAddUseCaseRequestValue) async throws -> FriendEntity
//    func addFriendService(friendInfo: FriendEntity) -> AnyPublisher<FriendEntity, Error>
//    func deleteFriendService(id: Int) -> Bool
    func modifierFriend(friendInfo: FriendEntity) async throws -> FriendEntity
//    func searchFriendService(naem: String) -> AnyPublisher<[Friend], Error>
    func fetchFriendsList() async throws -> [FriendEntity]
}
