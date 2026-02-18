//
//  EditFriendNamePage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import Combine
import ChatModuleMessengerUI
import ChatModuleMessengerRelationshipFriendsUI

struct EditFriendNamePage: View {
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject var appState: AppState
    @ObservedObject var friendsViewModel: FriendsViewModel

    @State private var editInput: String
    @State private var editSuccess: Bool = false
    @State private var confirmButtonDisabled = true

    private var friendInfo: FriendEntity
    private let inputLimit: Int = 20
    private let friendsSetName: String

    init(friendsViewModel: FriendsViewModel, friendInfo: FriendEntity, editInput: String, friendsSetName: String) {
        self.friendsViewModel = friendsViewModel
        self.friendInfo = friendInfo
        _editInput = State(initialValue: friendInfo.name)
        self.friendsSetName = friendsSetName // 친구가 설정한 이름
    }

    var body: some View {
        NavigationView {
            VStack {
                inputFriendName

                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(appState.tm.lang.localized("Name"))
            .navigationBarColor(backgroundColor: UIColor(appState.tm.theme.systemBackground),
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

                ToolbarItem(placement: .primaryAction) {
                    Button {
                        var friend = friendInfo
                        friend.name = editInput
                        friendsViewModel.editFriendName(friendInfo: friend, completion: { friend in
                            if friend != nil {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        })
                    } label: {
                        Text(appState.tm.lang.localized("Common.Ok"))
                            .font(appState.tm.typo.body)
                    }
                    .disabled(friendInfo.name == editInput)
                }
            }
        }
    }
}

extension EditFriendNamePage {
    private var inputFriendName: some View {
        VStack {
            SubTitleBar(title: appState.tm.lang.localized("Friends.FriendName"))
            FormField(inputText: $editInput,
                      placeHoldText: appState.tm.lang.localized("Friends.FriendName"),
                      inputLimit: inputLimit,
                      caption: String(format: appState.tm.lang.localized("Friends.SetName"), self.friendsSetName),
                      counterHidden: false,
                      disableEditing: $editSuccess)
                .padding(.leading, 17)
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
}

#if DEBUG
struct EditFriendName_Previews: PreviewProvider {
    static var previews: some View {
        EditFriendNamePage(friendsViewModel: .init(), friendInfo: FriendEntity(account: .init(signInId: "0", username: "김개똥")), editInput: "디오", friendsSetName: "체인지폼")
    }
}
#endif
