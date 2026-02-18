//
//  ContactsDataSourceTests.swift
//  ChatModuleMessengerAppApple
//

 import XCTest
 import Combine
 @testable import ChatModuleMessengerAppApple

 class ContactsDataSourceTests: XCTestCase {

    var dataSource: ContactsDataSourceInterface?

    override func setUpWithError() throws {
        self.dataSource = ContactsDataSource()

        guard dataSource != nil else {
            XCTFail("DataSource is nil")
            return
        }
    }

    func testSyncContacts() throws {
        Task {
            let preToken = Data()
            let newToken = try await self.dataSource?.syncContacts(historyToken: preToken)
            XCTAssert(preToken.count == 0)
            XCTAssert(newToken?.count ?? 0 > 0)
        }
    }

 }
