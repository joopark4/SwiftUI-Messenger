//
//  RecommendedFriendsPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

struct RecommendedFriendsPage: View {
    @EnvironmentObject var tm: ThemeManager
    @Environment(\.presentationMode) var presentationMode

    @State private var showProfileItem: FriendEntity?

    let viewModel: FriendsViewModel
    let friends: [FriendEntity]

    init(viewModel: FriendsViewModel = .init(),
         friends: [FriendEntity] = []) {
        self.viewModel = viewModel
        self.friends = friends
    }

    var body: some View {
        NavigationView {
            Group {
                if friends.isEmpty {
                    Text(tm.lang.localized("Friends.Recommended.Empty"))
                        .font(tm.typo.body)
                        .foregroundColor(tm.theme.labelColorPrimary)
                } else {
                    List {
                        Section(header: RecommendedFriendsTitleSection(title: tm.lang.localized("Friends.Header.Recommended"))) {
                            ForEach(friends, id: \.account.signInId) { friend in
                                Button {
                                    showProfileItem = friend
                                } label: {
                                    RecommendedFriendsItemSection(friend: friend) { item in
                                        let value = FriendsAddUseCaseRequestValue(
                                            friendName: item.name,
                                            phoneNumber: "01012345678"
                                        )

                                        viewModel.addFriend(friendInfo: value) { result in
                                            debugLog(result)
                                        }
                                    }
                                }
                                .listRowSeparatorHidden()
                                .listRowInsets(EdgeInsets())
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationBarColor(backgroundColor: UIColor(tm.theme.systemBackground),
                                tintColor: UIColor(tm.theme.labelColorPrimary))
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text(tm.lang.localized("Friends.Header.Recommended")))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(tm.theme.labelColorPrimary)
                    }
                }
            }
        }
        .fullScreenCover(item: $showProfileItem) {
            FriendProfilePage(friendsViewModel: viewModel,
                              accountInfo: $0.account)
        }
    }
}

struct RecommendedFriendsPage_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedFriendsPage(friends: [
            FriendEntity(account: .init(signInId: "0", username: "Name0")),
            FriendEntity(account: .init(signInId: "1", username: "Name1")),
            FriendEntity(account: .init(signInId: "2", username: "Name2")),
            FriendEntity(account: .init(signInId: "3", username: "Name3")),
            FriendEntity(account: .init(signInId: "4", username: "Name4")),
            FriendEntity(account: .init(signInId: "5", username: "Name5"))
        ])
        .environmentObject(ThemeManager())
    }
}
