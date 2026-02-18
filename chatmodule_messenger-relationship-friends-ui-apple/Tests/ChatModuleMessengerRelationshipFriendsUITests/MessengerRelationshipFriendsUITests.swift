//
//  MessengerRelationshipFriendsUITests.swift
//  ChatModuleMessengerRelationshipFriendsUI
//

import XCTest
@testable import ChatModuleMessengerRelationshipFriendsUI

final class ChatModuleMessengerRelationshipFriendsUITests: XCTestCase {
    func testUserProfileModel() throws {
        let model = UserProfileModel(id: 123, name: "test", profileImage: nil)
        XCTAssertNotNil(model)
        XCTAssertEqual(model.id, 123)
        XCTAssertEqual(model.name, "test")
    }
}
