//
//  FriendsSelectionPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

struct FriendsSelectionPage: View {
    enum Mode {
        /// 대화방 생성
        case createRoom
        /// 프로필 전송
        case sendProfile
        /// 대화상대 초대
        case inviteRoom
    }

    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) var presentationMode

    @State private var searchInput: String = ""

    @ObservedObject private var friendsSelectionViewModel: FriendsSelectionViewModel
    private let mode: Mode
    private var completion: (([FriendEntity]) -> Void)?

    init(mode: Mode = .createRoom,
         friendsSelectionViewModel: FriendsSelectionViewModel = .init(),
         completion: (([FriendEntity]) -> Void)? = nil) {
        self.mode = mode
        self.friendsSelectionViewModel = friendsSelectionViewModel
        self.completion = completion
    }

    var body: some View {
        NavigationView {
            VStack {
                FriendsSelectionHorizontalCollectionSection(
                    users: selectedFriends
                ) { id in
                    if id == self.friendsSelectionViewModel.me.friend.id {
                        self.friendsSelectionViewModel.me.check.toggle()
                    } else if let index = self.friendsSelectionViewModel.friends
                        .firstIndex(where: { $0.friend.id == id }) {
                        self.friendsSelectionViewModel.friends[index].check.toggle()
                    }
                }

                textfiledView

                List {

                    if mode == .sendProfile {
                        FriendsSelectionListGroupSection(
                            title: appState.tm.lang.localized("Friends.Selection.MyProfile"),
                            users: [friendsSelectionViewModel.me]
                        ) { _ in friendsSelectionViewModel.me.check.toggle() }
                    }

                    FriendsSelectionListGroupSection(
                        title: appState.tm.lang.localized("Friends.Selection.Favorite"),
                        users: friendsSelectionViewModel.friends.filter({$0.friend.id == 0})
                    ) { id in
                        if let idx = friendsSelectionViewModel.friends
                            .firstIndex(where: { $0.friend.id == id }) {
                            friendsSelectionViewModel.friends[idx].check.toggle()
                        }
                    }

                    FriendsSelectionListGroupSection(
                        title: appState.tm.lang.localized("Friends.Selection.Friends"),
                        users: friendsSelectionViewModel.friends
                    ) { id in
                        if let idx = friendsSelectionViewModel.friends
                            .firstIndex(where: { $0.friend.id == id }) {
                            friendsSelectionViewModel.friends[idx].check.toggle()
                        }
                    }
                }
                .onAppear {
                    self.friendsSelectionViewModel.fetchFriendsList()
                }
                .listStyle(.plain)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(navTitle)
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

                ToolbarItem(placement: .confirmationAction) {
                    confirmButton
                        .disabled(selectedFriends.isEmpty)
                }
            }
        }
    }

    private var navTitle: String {
        switch mode {
        case .createRoom:
            return appState.tm.lang.localized("Friends.Selection.CreateRoom.Title")
        case .sendProfile:
            return appState.tm.lang.localized("Friends.Selection.SendProfile.Title")
        case .inviteRoom:
            return appState.tm.lang.localized("Friends.Selection.InviteRoom.Title")
        }
    }

    private var selectedFriends: [InvitationFriendEntity] {
        var selected = self.friendsSelectionViewModel.friends.filter { $0.check == true }
        if self.friendsSelectionViewModel.me.check {
            selected.insert(self.friendsSelectionViewModel.me, at: 0)
        }
        return selected
    }

    private var selectedFriendListView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(selectedFriends, id: \.friend.id) { invitationFriend in
                    Button {
                        if self.friendsSelectionViewModel.me.friend.id == invitationFriend.friend.id {
                            self.friendsSelectionViewModel.me.check.toggle()
                        } else if let index = self.friendsSelectionViewModel.friends
                            .firstIndex(where: { $0.friend.id == invitationFriend.friend.id }) {
                            self.friendsSelectionViewModel.friends[index].check.toggle()
                        }
                    } label: {
                        FriendsSelectionHorizontalItemSection(
                            account: AccountEntity(signInId: String(invitationFriend.friend.id),
                                                 username: invitationFriend.friend.name)
                        )
                    }
                    .padding(.leading, 8)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
        }
    }

    @ViewBuilder
    private var confirmButton: some View {
        switch mode {
        case .createRoom:
            NavigationLink(destination: {
                GroupChatRoomSettingPage(viewModel: AppDI.shared.chatRoomListViewModel)
            }, label: {
                confirmLabel
            })
        case .sendProfile, .inviteRoom:
            Button {
                completion?(selectedFriends.compactMap { $0.friend })
                presentationMode.wrappedValue.dismiss()
            } label: {
                confirmLabel
            }
        }
    }

    private var confirmLabel: some View {
        HStack {
            if selectedFriends.count > 0 {
                Text("\(selectedFriends.count) ")
                    .font(appState.tm.typo.body)
                    .foregroundColor(appState.tm.theme.systemPurple)
            }

            Text(appState.tm.lang.localized("Common.Ok"))
                .font(appState.tm.typo.body)
        }
    }

    // Todo.. formfild 컴포넌트로 변경해야함
    private var textfiledView: some View {
        ZStack(alignment: .trailing) {
            appState.tm.theme.fillColorTertiary

            TextField(appState.tm.lang.localized("Chat.Invitation.Search.Placehold"),
                               text: self.$searchInput)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 2, trailing: 41))

            Button {
                searchInput = ""
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 17))
                    .foregroundColor(.gray)
            }.padding(.trailing, 16)
        }
        .frame(minWidth: 342, maxWidth: .infinity, minHeight: 44, maxHeight: 44)
        .cornerRadius(8)
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 17))
    }
}

struct FriendsSelectionPage_Previews: PreviewProvider {
    static var previews: some View {
        FriendsSelectionPage()
            .environmentObject(AppState())
            .environmentObject(ThemeManager())
    }
}
