//
//  FriendsMockDataSource.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

public final actor FriendsMockDataSource {
    var mockDatas = [FriendEntity]([FriendEntity(account: .init(signInId: "0", username: "김개똥")),
                                    FriendEntity(account: .init(signInId: "1", username: "미코딩")),
                                    FriendEntity(account: .init(signInId: "2", username: "코로나")),
                                    FriendEntity(account: .init(signInId: "3", username: "김신")),
                                    FriendEntity(account: .init(signInId: "4", username: "미노리")),
                                    FriendEntity(account: .init(signInId: "5", username: "비오")),
                                    FriendEntity(account: .init(signInId: "6", username: "유상무"))])

    public init() {
    }
}

extension FriendsMockDataSource: FriendsDataSourceInterface {

    public func addFriend(friendInfo: FriendsAddUseCaseRequestValue) async throws -> FriendEntity {
        guard friendInfo != nil else { throw FriendError.unknown }

        let addData = FriendEntity(account: .init(signInId: "\(mockDatas.count)", username: friendInfo.friendName))

        self.mockDatas.append(addData)
        return addData
    }

//    func deleteFriendService(id: Int) -> Bool {
//        <#code#>
//    }
//
    public func modifierFriend(friendInfo: FriendEntity) async throws -> FriendEntity {
        guard friendInfo != nil else { throw FriendError.unknown }

        if let index = self.mockDatas.firstIndex(where: { $0.id == friendInfo.id }) {
            self.mockDatas[index].name = friendInfo.name
        }

        return friendInfo
    }
//
//    func searchFriendService(naem: String) -> AnyPublisher<[FriendEntity], Error> {
//        <#code#>
//    }

    public func fetchFriendsList() async throws -> [FriendEntity] {
        guard true else {
            try await Task.sleep(nanoseconds: 5 * 1_000_000_000)
            throw FriendError.unknown
        }
        return self.mockDatas
    }

}
