//
//  FriendProfilePage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerRelationshipFriendsUI

struct FriendProfilePage: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var friendsViewModel: FriendsViewModel
    @EnvironmentObject var appState: AppState

    @State private var editFriendName: String
    @State private var friendEditAction: Bool = false

    private var friendInfo: FriendEntity

    init(friendsViewModel: FriendsViewModel, friendInfo: FriendEntity) {
        self.friendsViewModel = friendsViewModel
        self.friendInfo = friendInfo
        _editFriendName = State(initialValue: friendInfo.name)
    }

    init(friendsViewModel: FriendsViewModel, accountInfo: AccountEntity) {
        self.friendsViewModel = friendsViewModel
        if let id = Int64(accountInfo.signInId),
           let friend = friendsViewModel.friends.first(where: { $0.id == id }) {
            self.friendInfo = friend
        } else {
            self.friendInfo = .init()
        }
        _editFriendName = State(initialValue: accountInfo.username)
    }

    var body: some View {
        NavigationView {
            ZStack {
                appState.tm.theme.background.edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()

                    UserProfileCenterIconItem(model: FriendEntity(account: .init(signInId: "32", username: friendInfo.name)),
                                              buttonText: appState.tm.lang.localized("Message.DirectMessage"),
                                              renameEnabled: true,
                                              onRenameClick: self.renameButtonSelected,
                                              onButtonClick: self.directmessageButtonSelected)
                        .sheet(isPresented: self.$friendEditAction) {
                            // dismiss
                        } content: {
                            // friendsSetName: 친구가 설정한 이름은 코어 또는 서버에서 받아와야 하는 듯
                            EditFriendNamePage(friendsViewModel: friendsViewModel, friendInfo: friendInfo,
                                               editInput: self.friendInfo.name, friendsSetName: "BO")
                        }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(backgroundColor: UIColor(appState.tm.theme.background),
                                tintColor: UIColor(appState.tm.theme.labelColorPrimary))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(appState.tm.typo.body)
                    }
                }
            }
        }
    }

    private func renameButtonSelected() {
        friendEditAction.toggle()
    }

    private func directmessageButtonSelected() {
        print(#function)
    }
}

#if DEBUG
struct ViewFriendProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        FriendProfilePage(friendsViewModel: .init(), friendInfo: FriendEntity(account: .init(signInId: "0", username: "김개똥")))
    }
}
#endif
