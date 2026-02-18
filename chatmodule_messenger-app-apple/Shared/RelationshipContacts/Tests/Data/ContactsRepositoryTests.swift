//
//  ContactsRepositoryTests.swift
//  ChatModuleMessengerAppApple
//

import XCTest
import Combine
@testable import ChatModuleMessengerAppApple

struct FakeContactsDataSource: ContactsDataSourceInterface {
    func syncContacts(historyToken: Data) async throws -> Data {
        let newToken = "newHistoryToken"
        return Data(newToken.utf8)
    }
}

class ContactsRepositoryTests: XCTestCase {

    var repository: ContactsRepositoryInterface?
    private var bag = Set<AnyCancellable>()

    override func setUpWithError() throws {
        repository = ContactsRepository(dataSource: FakeContactsDataSource())

        guard repository != nil else {
            XCTFail("Repository is nil")
            return
        }
    }

    func testSyncContacts() throws {
        self.repository?.syncContacts(historyToken: Data())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    XCTFail(err.localizedDescription)
                    break
                }
            }, receiveValue: { token in
                XCTAssert(token.count > 0)
            })
            .store(in: &bag)
    }

}
