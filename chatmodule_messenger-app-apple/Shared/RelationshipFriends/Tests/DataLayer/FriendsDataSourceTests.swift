//
//  FriendsDataSourceTests.swift
//  ChatModuleMessengerAppApple
//

import XCTest
import Combine
@testable import ChatModuleMessengerAppApple

class FriendsDataSourceTests: XCTestCase {

    var dataSource: FriendsDataSourceInterface?

    override func setUpWithError() throws {
        self.dataSource = FriendsMockDataSource()

        guard dataSource != nil else {
            XCTFail("DataSource is nil")
            return
        }
    }

    func testAddFriend() throws {
        Task {
            let friend = try await self.dataSource?.addFriend(friendInfo:
                                                                FriendsAddUseCaseRequestValue(friendName: "ChatModule",
                                                                                              phoneNumber: "+8201098764321"))
            XCTAssertNotNil(friend)
            XCTAssertNotNil(friend?.id)
            XCTAssertEqual(friend?.name, "ChatModule")
        }
    }

    func testFetchFriendsList() throws {
        Task {
            let friends = try await self.dataSource?.fetchFriendsList()
            XCTAssertNotNil(friends)
            friends?.forEach { friend in
                XCTAssertNotNil(friend)
                XCTAssertNotNil(friend.id)
                XCTAssertNotNil(friend.name)
            }
        }
    }
}
