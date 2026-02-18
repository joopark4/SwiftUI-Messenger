//
//  FriendEntityTests.swift
//  ChatModuleMessengerAppApple
//

import XCTest
@testable import ChatModuleMessengerAppApple

class FriendEntityTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testFriendEntity() throws {
        let friend = FriendEntity()
        XCTAssertNotNil(friend)
        XCTAssertNotNil(friend.id)
    }
}
