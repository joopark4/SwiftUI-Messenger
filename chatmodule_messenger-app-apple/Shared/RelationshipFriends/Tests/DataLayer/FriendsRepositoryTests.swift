//
//  FriendsRepositoryTests.swift
//  ChatModuleMessengerAppApple
//

import XCTest
import Combine
@testable import ChatModuleMessengerAppApple

struct FakeFriendsDataSource: FriendsDataSourceInterface {
    func addFriend(friendInfo: FriendsAddUseCaseRequestValue) async throws -> FriendEntity {
        let addData = FriendEntity(id: 123, name: friendInfo.friendName, profileImagePath: friendInfo.profileImagePath)
        return addData
    }

    func fetchFriendsList() async throws -> [FriendEntity] {
        return [FriendEntity(id: 0, name: "ChatModule")]
    }
}

class FriendsRepositoryTests: XCTestCase {

    var repository: FriendsRepositoryInterface?
    private var bag = Set<AnyCancellable>()

    override func setUpWithError() throws {
        repository = FriendsRepository(dataSource: FakeFriendsDataSource())

        guard repository != nil else {
            XCTFail("Repository is nil")
            return
        }
    }

    func testAddFriend() throws {
        self.repository?.addFriend(friendInfo: FriendsAddUseCaseRequestValue(friendName: "ChatModule", profileImagePath: nil))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    XCTFail(err.localizedDescription)
                    break
                }
            }, receiveValue: { friend in
                XCTAssertNotNil(friend)
                XCTAssertNotNil(friend.id)
                XCTAssertEqual(friend.name, "ChatModule")
            })
            .store(in: &bag)
    }

    func testFetchFriendsList() throws {
        self.repository?.fetchFriendsList()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    XCTFail(err.localizedDescription)
                    break
                }
            }, receiveValue: { friends in
                XCTAssertGreaterThan(friends.count, 0)
                for friend in friends {
                    XCTAssertNotNil(friend.id)
                    XCTAssertNotNil(friend.name)
                }
            })
            .store(in: &bag)
    }
}
