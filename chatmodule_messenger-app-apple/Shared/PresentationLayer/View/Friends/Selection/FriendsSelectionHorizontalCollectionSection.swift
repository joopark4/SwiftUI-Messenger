//
//  FriendsSelectionHorizontalCollectionSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

/// Friends Selection Horizontal Collection Section
struct FriendsSelectionHorizontalCollectionSection: View {
    @EnvironmentObject var tm: ThemeManager

    var users: [InvitationFriendEntity]
    var onClick: ((Int64) -> Void)?

    /// Create FriendsSelectionHorizontalCollectionSection
    ///
    /// - Parameters:
    ///   - users: user list (``InvitationFriendEntity``)
    ///   - onClick: click event closure
    init(users: [InvitationFriendEntity] = [],
         onClick: ((Int64) -> Void)? = nil) {
        self.users = users
        self.onClick = onClick
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(users, id: \.friend.id) { user in
                    Button {
                        onClick?(user.friend.id)
                    } label: {
                        FriendsSelectionHorizontalItemSection(
                            account: AccountInfo(signInId: String(user.friend.id),
                                                 username: user.friend.name)
                        )
                    }
                    .padding(.leading, 8)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
        }
    }
}

struct FriendsSelectionHorizontalCollectionSection_Previews: PreviewProvider {
    static var previews: some View {
        FriendsSelectionHorizontalCollectionSection(users: [
            InvitationFriendEntity(friend: FriendEntity(account: .init(signInId: "\(Int64.max)",
                                                                       username: "My Profile")),
                                   check: false)
        ])
        .environmentObject(ThemeManager())
    }
}
