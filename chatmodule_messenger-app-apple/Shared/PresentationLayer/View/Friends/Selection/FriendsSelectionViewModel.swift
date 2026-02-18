//
//  FriendsSelectionViewModel.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

// 대화상대 선택에서만 쓸 임시 Entity
public struct InvitationFriendEntity {
    public var friend: FriendEntity
    public var check: Bool

    init(friend: FriendEntity, check: Bool) {
        self.friend = friend
        self.check = check
    }
}

public final class FriendsSelectionViewModel: ObservableObject {

    @Published var me = InvitationFriendEntity(friend: FriendEntity(account: .init(signInId: "\(Int64.max)",
                                                                                   username: "My Profile")),
                                               check: false)
    @Published var friends = [InvitationFriendEntity]()

    private let friendsListFetchUseCase: FriendsListFetchUseCase?

    private var bag = Set<AnyCancellable>()

    public init(friendsListFetchUseCase: FriendsListFetchUseCase? = nil) {
        self.friendsListFetchUseCase = friendsListFetchUseCase
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
                self.friends = data.map { InvitationFriendEntity(friend: $0, check: false) }
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
