//
//  NewFriendsGroupSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerRelationshipFriendsUI

/// New Friends Group Section
///
/// Friends prototype > Messenger 친구 목록
///
///
/// Usage:
///
///     List {
///         NewFriendsGroupSection(users: [FriendInfo](),
///                                isExpand: .constant(true))
///     }
///
struct NewFriendsGroupSection: View {
    @EnvironmentObject var tm: ThemeManager

    @Binding var isExpand: Bool
    let searchText: String
    let users: [FriendInfo]
    var onClick: ((FriendInfo) -> Void)?

    /// Create NewFriendsGroupSection
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
        Section(header: NewFriendsGroupTitleSection(title: tm.lang.localized("Friends.Header.NewFriends"),
                                                    isExpand: $isExpand)) {
            if isExpand {
                ForEach(searchResult) { user in
                    Button(action: {
                        self.onClick?(user)
                    }, label: {
                        NewFriendsGroupItemSection(model: user)
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

struct NewFriendsGroupSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            NewFriendsGroupSection(users: [
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
