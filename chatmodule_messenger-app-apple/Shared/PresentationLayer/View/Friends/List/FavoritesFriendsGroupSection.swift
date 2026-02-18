//
//  FavoritesFriendsGroupSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerRelationshipFriendsUI

/// Favorites Friends Group Section
///
/// Friends prototype > Messenger 친구 목록
///
///
/// Usage:
///
///     List {
///         FavoritesFriendsGroupSection(users: [FriendInfo](),
///                                      isExpand: .constant(true))
///     }
///
struct FavoritesFriendsGroupSection: View {
    @EnvironmentObject var tm: ThemeManager

    @Binding var isExpand: Bool
    let searchText: String
    let users: [FriendInfo]
    var onClick: ((FriendInfo) -> Void)?

    /// Create FavoritesFriendsGroupSection
    ///
    /// - Parameters:
    ///   - users: user list (``FriendInfo``)
    ///   - searchText: search text
    ///   - isExpand: expand state
    ///   - onClick: onClick event
    init(users: [FriendInfo] = [],
         searchText: String = "",
         isExpand: Binding<Bool> = .constant(true),
         onClick: ((FriendInfo) -> Void)? = nil) {
        self.users = users
        self.searchText = searchText
        _isExpand = isExpand
        self.onClick = onClick
    }

    var body: some View {
        Section(header: FavoritesFriendsGroupTitleSection(title: tm.lang.localized("Friends.Header.Favorites"),
                                                          isExpand: $isExpand)) {
            if isExpand {
                ForEach(searchResult) { user in
                    Button(action: {
                        self.onClick?(user)
                    }, label: {
                        FavoritesFriendsGroupItemSection(model: user)
                    })
                    .listRowInsets(EdgeInsets())
                    .listRowSeparatorHidden()
                }
            }
        }
    }

    var searchResult: [FriendInfo] {
        return self.users.filter {
            searchText.isEmpty ||
            $0.name.localizedStandardContains(searchText)
        }
    }

}

struct FavoritesFriendsGroupSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            FavoritesFriendsGroupSection(users: [
                FriendInfo(account: .init(signInId: "0", username: "가나다")),
                FriendInfo(account: .init(signInId: "0", username: "라마바")),
                FriendInfo(account: .init(signInId: "0", username: "사아자"))
            ], isExpand: .constant(true))
        }
        .listStyle(.plain)
        .environmentObject(ThemeManager())
        .previewLayout(.sizeThatFits)
    }
}
