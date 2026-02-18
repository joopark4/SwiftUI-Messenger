//
//  UpdatedFriendsGroupSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerRelationshipFriendsUI

/// Updated Friends Group Section
///
/// Friends prototype > Messenger 친구 목록
///
///
/// Usage:
///
///     List {
///         UpdatedFriendsGroupSection(users: [
///             FriendInfo(...)
///         ], isExpand: .constant(true))
///     }
///
struct UpdatedFriendsGroupSection: View {
    @EnvironmentObject var tm: ThemeManager

    @Binding var isExpand: Bool
    let searchText: String
    let users: [FriendInfo]
    var onClick: ((FriendInfo) -> Void)?

    /// Create UpdatedFriendsGroupSection
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
        Section(header: UpdatedFriendsGroupTitleSection(
            title: tm.lang.localized("Friends.Header.Updated") + " \(users.count)",
            isExpand: $isExpand
        )) {
            if isExpand {
                UpdatedFriendsHorizontalListSection(users: searchResult) { user in
                    self.onClick?(user)
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparatorHidden()
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

struct UpdatedFriendsGroupSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            UpdatedFriendsGroupSection(users: [
                FriendInfo(account: .init(signInId: "0", username: "가나다")),
                FriendInfo(account: .init(signInId: "1", username: "라마바")),
                FriendInfo(account: .init(signInId: "2", username: "사아자"))
            ], isExpand: .constant(true))
        }
        .listStyle(.plain)
        .environmentObject(ThemeManager())
        .previewLayout(.sizeThatFits)
    }
}
