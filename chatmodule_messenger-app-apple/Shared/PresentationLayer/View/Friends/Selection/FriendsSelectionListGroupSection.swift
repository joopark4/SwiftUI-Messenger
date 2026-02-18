//
//  FriendsSelectionListGroupSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerRelationshipFriendsUI

/// Friends Selection List Group Section
///
/// Friends prototype > Messenger 친구 목록
///
///
/// Usage:
///
///     List {
///         FriendsSelectionListGroupSection(users: [
///             InvitationFriendEntity(friend: FriendEntity(...),
///                                    check: false)
///         ], isExpand: .constant(true))
///     }
///
struct FriendsSelectionListGroupSection: View {
    @EnvironmentObject var tm: ThemeManager

    let title: String
    var users: [InvitationFriendEntity]
    var onClick: ((Int64) -> Void)?

    /// Create FriendsSelectionListGroupSection
    ///
    /// - Parameters:
    ///   - title: title text
    ///   - users: user list (``InvitationFriendEntity``)
    ///   - onClick: click event closure
    init(title: String = "",
         users: [InvitationFriendEntity] = [],
         onClick: ((Int64) -> Void)? = nil) {
        self.title = title
        self.users = users
        self.onClick = onClick
    }

    var body: some View {
        Section(header: FriendsSelectionListTitleSection(title: title)) {
            ForEach(users, id: \.friend.id) { user in
                Button(action: {

                }, label: {
                    FriendsSelectionListRowSection(model: AccountInfo(signInId: String(user.friend.id), username: user.friend.name),
                                                isChecked: user.check) { _ in
                        onClick?(user.friend.id)
                    }
                })
                .listRowInsets(EdgeInsets())
                .listRowSeparatorHidden()
            }
        }
    }

}

struct FriendsSelectionListGroupSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            FriendsSelectionListGroupSection(title: "내 프로필",
                                        users: [
                                            InvitationFriendEntity(friend: FriendEntity(account: .init(signInId: "\(Int64.max)",
                                                                                                       username: "My Profile")),
                                                                   check: false)
                                        ])
        }
        .listStyle(.plain)
        .environmentObject(ThemeManager())
    }
}
