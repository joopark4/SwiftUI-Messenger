//
//  UpdatedFriendsHorizontalListSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerRelationshipFriendsUI

/// Updated Friends Horizontal List Section
struct UpdatedFriendsHorizontalListSection: View {
    @EnvironmentObject var tm: ThemeManager

    var users: [FriendInfo]
    var onClick: ((FriendInfo) -> Void)?

    /// Create UpdatedFriendsHorizontalListSection
    ///
    /// - Parameters:
    ///   - users: user list (``FriendInfo``)
    ///   - onClick: click event closure
    init(users: [FriendInfo] = [],
         onClick: ((FriendInfo) -> Void)? = nil) {
        self.users = users
        self.onClick = onClick
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(users, id: \.account.signInId) { user in
                    Button {
                        onClick?(user)
                    } label: {
                        UpdatedFriendsHorizontalItemSection(account: user)
                    }
                }
            }
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        }
    }
}

struct UpdatedFriendsHorizontalListSection_Previews: PreviewProvider {
    static var previews: some View {
        UpdatedFriendsHorizontalListSection(users: [
            FriendInfo(account: .init(signInId: "0", username: "Name01")),
            FriendInfo(account: .init(signInId: "1", username: "Name02")),
            FriendInfo(account: .init(signInId: "2", username: "Name03")),
            FriendInfo(account: .init(signInId: "3", username: "Name04"))
        ])
        .environmentObject(ThemeManager())
        .previewLayout(.sizeThatFits)
    }
}
