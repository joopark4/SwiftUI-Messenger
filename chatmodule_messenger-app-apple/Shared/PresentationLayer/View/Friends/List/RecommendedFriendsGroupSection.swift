//
//  RecommendedFriendsGroupSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerRelationshipFriendsUI

/// Recommended Friends Group Section
///
/// Friends prototype > Messenger 친구 목록
///
///
/// Usage:
///
///     List {
///         RecommendedFriendsGroupSection(users: [
///             FriendInfo(id: 0, name: "가나다"),
///             FriendInfo(id: 0, name: "라마바"),
///             FriendInfo(id: 0, name: "사아자")
///         ], isExpand: .constant(true))
///     }
///
struct RecommendedFriendsGroupSection: View {
    @EnvironmentObject var tm: ThemeManager

    @Binding var isExpand: Bool
    let users: [FriendInfo]
    var onClick: (() -> Void)?

    /// Create RecommendedFriendsGroupSection
    /// 
    /// - Parameters:
    ///   - users: user list (``FriendInfo``)
    ///   - searchText: search text
    ///   - isExpand: expand state
    ///   - onClick: on click event
    init(users: [FriendInfo] = [],
         isExpand: Binding<Bool> = .constant(true),
         onClick: (() -> Void)? = nil) {
        self.users = users
        _isExpand = isExpand
        self.onClick = onClick
    }

    var body: some View {
        Section(header: RecommendedFriendsGroupTitleSection(title: tm.lang.localized("Friends.Header.Recommended"),
                                                            isExpand: $isExpand)) {
            if isExpand {
                Button(action: {
                    onClick?()
                }, label: {
                    RecommendedFriendsGroupItemSection(count: self.users.count)
                })
                .listRowInsets(EdgeInsets())
                .listRowSeparatorHidden()
            }
        }
    }

}

struct RecommendedFriendsGroupSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            RecommendedFriendsGroupSection(users: [
                FriendInfo(account: .init(signInId: "0", username: "가나다")),
                FriendInfo(account: .init(signInId: "0", username: "라마바")),
                FriendInfo(account: .init(signInId: "0", username: "사아자"))
            ], isExpand: .constant(true))
        }
        .listStyle(.plain)
        .environmentObject(ThemeManager())
    }
}
