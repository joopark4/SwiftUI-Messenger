//
//  FriendsPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerRelationshipFriendsUI

/// FriendsPage
///
/// 친구 Page
///
struct FriendsPage: View {
    @EnvironmentObject var appState: AppState
    @StateObject var searchBar: SearchBar = SearchBar()
    @ObservedObject var viewModel: FriendsViewModel

    @State private var friendProfileItem: FriendEntity?
    @State private var addFriendAction: Bool = false
    @State private var addByContactAction: Bool = false
    @State private var inviteFriendAction: Bool = false
    @State private var recommendedFriendsAction: Bool = false
    @State private var unifiedSearchAction: Bool = false

    init(viewModel: FriendsViewModel) {
        self.viewModel = viewModel
        debugLog()
    }

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section { myProfile }

                    // 새로운 친구
                    NewFriendsGroupSection(
                        users: self.viewModel.friends
                            .filter { $0.id == 0 }, // TODO
                        searchText: searchBar.text,
                        isExpand: $appState.appSetting.expandNewFriends,
                        onClick: showFriendProfile
                    )

                    // 업데이트 한 친구
                    UpdatedFriendsGroupSection(
                        users: self.viewModel.friends,
                        searchText: searchBar.text,
                        isExpand: $appState.appSetting.expandUpdatedFriends,
                        onClick: showFriendProfile
                    )

                    // 즐겨찾기
                    FavoritesFriendsGroupSection(
                        users: self.viewModel.friends
                            .filter { $0.id == 1 }, // TODO
                        searchText: searchBar.text,
                        isExpand: $appState.appSetting.expandFavoriteFriends,
                        onClick: showFriendProfile
                    )

                    // 추천친구
                    RecommendedFriendsGroupSection(isExpand: $appState.appSetting.expandRecommendedFriends) {
                        recommendedFriendsAction.toggle()
                    }

                    // 친구
                    FriendsGroupSection(
                        users: self.viewModel.friends,
                        searchText: searchBar.text,
                        isExpand: $appState.appSetting.expandFriends,
                        onClick: showFriendProfile
                    )

                    if !self.viewModel.friends.isEmpty {
                        Section { inviteView }
                    }
                }
                .removeHeaderTopPadding()
                .listStyle(.plain)
                .add(searchBar)
            }
            .onAppear(perform: {
                self.viewModel.fetchFriendsList()
                UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self])
                    .tintColor = UIColor(appState.tm.theme.labelColorPrimary)
            })
            .navigationBarColorDefault()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // navigation title
                ToolbarItem(placement: .principal) {
                    Text(self.appState.tm.lang.localized("Friends"))
                        .font(.headline)
                }

                ToolbarItem(placement: .primaryAction) {
                    HStack(spacing: 4) {
                        Button {
                            unifiedSearchAction.toggle()
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 17))
                                .foregroundColor(appState.tm.theme.labelColorPrimary)
                        }
                        .fullScreenCover(isPresented: $unifiedSearchAction) {
                            UnifiedSearchPage(viewModel: AppDI.shared.unifiedSearchViewModel)
                        }

                        Button {
                            self.addFriendAction.toggle()
                        } label: {
                            Image(systemName: "person.badge.plus")
                                .font(.system(size: 17))
                                .foregroundColor(appState.tm.theme.labelColorPrimary)
                        }

                        Button { } label: {
                            Image(systemName: "music.note")
                                .font(.system(size: 17))
                                .foregroundColor(appState.tm.theme.labelColorPrimary)
                        }

                        Button { } label: {
                            Image(systemName: "gear")
                                .font(.system(size: 17))
                                .foregroundColor(appState.tm.theme.labelColorPrimary)
                        }
                    }
                }
            }
        }
        .fullScreenCover(item: $friendProfileItem) { friend in
            FriendProfilePage(friendsViewModel: viewModel,
                              friendInfo: friend)
        }
        .fullScreenCover(isPresented: $recommendedFriendsAction) {
            RecommendedFriendsPage(
                viewModel: self.viewModel,
                friends: self.viewModel.friends
            )
        }
        .sheet(isPresented: $addByContactAction) {
            FriendAddPage(friendViewModel: self.viewModel,
                          selectCountryViewModel: AppDI.shared.countryViewModel)
        }
        .actionSheet(isPresented: $addFriendAction) {
            ActionSheet(title: Text(""),
                        message: Text(appState.tm.lang.localized("Friends.Add.Title")),
                        buttons: [
                            .default(Text(appState.tm.lang.localized("Friends.Add.QRCode")),
                                     action: {  }),
                            .default(Text(appState.tm.lang.localized("Friends.Add.ByContact")),
                                     action: { addByContactAction.toggle() }),
                            .default(Text(appState.tm.lang.localized("Friends.Add.ByID")),
                                     action: {  }),
                            .default(Text(appState.tm.lang.localized("Friends.Add.Recommended")),
                                     action: { recommendedFriendsAction.toggle() }),
                            .cancel(Text(appState.tm.lang.localized("Common.Cancel")),
                                    action: {  })
                        ])
        }
    }

    private var searchResult: [FriendEntity] {
        return self.viewModel.friends.filter {
            searchBar.text.isEmpty ||
            $0.name.localizedStandardContains(searchBar.text)
        }
    }

    private var myProfile: some View {
        VStack {
            UserProfileRightIconItem(model: AccountEntity(signInId: "0", username: "My Profile"))
            Divider()
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparatorHidden()
    }

    private var inviteView: some View {
        NavigationLink(destination: FriendInvitePage(viewModel: self.viewModel)) {
            UserProfileLeftIconItem(
                leftIcon: UIImage(systemName: "envelope.circle.fill")?
                    .withRenderingMode(.alwaysTemplate),
                iconTintColor: self.appState.tm.theme.systemGray,
                subTitle1: self.appState.tm.lang.localized("Friends.Invite.CellTitle"))
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparatorHidden()
    }

    private func showFriendProfile(friend: FriendEntity?) {
        if let friend = friend {
            self.friendProfileItem = self.viewModel.friends.first(where: { $0.id == friend.id })
        } else {
            // 친구 초대
            self.addFriendAction.toggle()
        }
    }
}

struct FriendsPage_Previews: PreviewProvider {
    static var previews: some View {
        FriendsPage(viewModel: .init())
            .environmentObject(AppState())
            .environmentObject(ThemeManager())
    }
}
