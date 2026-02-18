//
//  FriendsViewModel.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

protocol FriendsViewModelOutput {
    var friends: [FriendEntity] { get }
}

protocol FriendsViewModelInput {
    func fetchFriendsList()
    func addFriend(friendInfo: FriendsAddUseCaseRequestValue, completion: @escaping (Result<FriendEntity, Error>) -> Void)
}

public final class FriendsViewModel: ObservableObject, FriendsViewModelInput, FriendsViewModelOutput {

    @Published var friends = [FriendEntity]()

    private let friendsListFetchUseCase: FriendsListFetchUseCase?
    private let friendsAddUseCase: FriendsAddUseCase?
    private let friendsModifierUseCase: FriendsModifierUseCase?

    private var bag = Set<AnyCancellable>()

    public init(friendsListFetchUseCase: FriendsListFetchUseCase? = nil,
                friendsAddUseCase: FriendsAddUseCase? = nil,
                friendsModifierUseCase: FriendsModifierUseCase? = nil) {
        self.friendsListFetchUseCase = friendsListFetchUseCase
        self.friendsAddUseCase = friendsAddUseCase
        self.friendsModifierUseCase = friendsModifierUseCase
    }

    func fetchFriendsList() {

        self.friendsListFetchUseCase?.execute(value: ())
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.errorHandle(comment: "🤬failure : \(#function)", error: error)
                case .finished:
                    self.errorHandle(comment: "finished : \(#function)")
                }
            } receiveValue: { data in
                self.friends = data
            }
            .store(in: &bag)
    }

    func editFriendName(friendInfo: FriendEntity, completion: @escaping (FriendEntity?) -> Void) {
        self.friendsModifierUseCase?.execute(value: friendInfo)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.errorHandle(comment: "🤬failure : \(#function)", error: error)
                    completion(nil)
                case .finished:
                    self.errorHandle(comment: "finished : \(#function)")
                }
            } receiveValue: { friend in
                if let index = self.friends.firstIndex(where: {$0.id == friend.id}) {
                    self.friends[index].name = friend.name
                }

                completion(friend)
            }
            .store(in: &bag)
    }

    func addFriend(friendInfo: FriendsAddUseCaseRequestValue, completion: @escaping (Result<FriendEntity, Error>) -> Void) {

        self.friendsAddUseCase?.execute(value: friendInfo)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.errorHandle(comment: "🤬failure : \(#function)", error: error)
                    completion(.failure(error))
                case .finished:
                    self.errorHandle(comment: "finished : \(#function)")
                }
            } receiveValue: { friend in
                self.friends.removeAll { $0.id == friend.id }
                self.friends.append(friend)
                completion(.success(friend))
            }
            .store(in: &bag)
    }

    private func errorHandle(comment: String, error: Error? = nil) {

        guard let err = error else {
            print("\(comment)")
            return
        }

        print("\(comment) --- \(err)")
    }
}
