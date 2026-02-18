//
//  FriendsUseCaseTests.swift
//  ChatModuleMessengerAppApple
//

import XCTest
import Combine
@testable import ChatModuleMessengerAppApple

struct FakeFriendsRepository: FriendsRepositoryInterface {
    func addFriend(friendInfo: FriendsAddUseCaseRequestValue) -> AnyPublisher<FriendEntity, Error> {

        let addData = FriendEntity(id: 0, name: friendInfo.friendName)
        return Just(addData)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func fetchFriendsList() -> AnyPublisher<[FriendEntity], Error> {
        return [
            FriendEntity(id: 0, name: "ChatModule0"),
            FriendEntity(id: 1, name: "ChatModule1"),
            FriendEntity(id: 2, name: "ChatModule2"),
            FriendEntity(id: 3, name: "ChatModule3")
        ]
            .publisher
            .collect()
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

class FriendsUseCaseTests: XCTestCase {

    private let repository = FakeFriendsRepository()
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testFetchFriendUsecase() throws {
        let usecase = FriendsListFetchUseCase(repository: self.repository)
        usecase.execute(value: ())
            .sink { receiveCompletion in
                switch receiveCompletion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { friends in
                XCTAssertGreaterThan(friends.count, 0)
                for friend in friends {
                    XCTAssertNotNil(friend.id)
                }
            }
            .store(in: &bag)
    }

    func testAddFriendUsecase() throws {
        let usecase = FriendsAddUseCase(repository: self.repository)
        usecase.execute(value: FriendsAddUseCaseRequestValue(friendName: "ChatModule", phoneNumber: "+8201098764321"))
            .sink { receiveCompletion in
                switch receiveCompletion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { friend in
                XCTAssertNotNil(friend)
                XCTAssertEqual(friend.id, 0)
                XCTAssertEqual(friend.name, "ChatModule")
            }
            .store(in: &bag)
    }
}
