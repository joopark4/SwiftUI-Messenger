//
//  ContactsUserCaseTests.swift
//  ChatModuleMessengerAppApple
//

import XCTest
import Combine
@testable import ChatModuleMessengerAppApple

struct FakeContactsRepository: ContactsRepositoryInterface {
    func syncContacts(historyToken: Data) -> AnyPublisher<Data, Error> {
        let newHistoryToken = Data("newHistoryToken".utf8)
        return Just(newHistoryToken)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

}

class ContactsUserCaseTests: XCTestCase {

    private let repository = FakeContactsRepository()
    private var bag = Set<AnyCancellable>()

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testSyncContact() throws {
        let usecase = ContactsListFetchUseCase(repository: self.repository)
        usecase.execute(value: Data())
            .sink { receiveCompletion in
                switch receiveCompletion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { newToken in
                XCTAssert(newToken.count > 0)
            }
            .store(in: &bag)
    }

}
