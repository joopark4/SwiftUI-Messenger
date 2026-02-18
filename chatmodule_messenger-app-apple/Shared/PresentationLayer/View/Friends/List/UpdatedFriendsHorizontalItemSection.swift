//
//  UpdatedFriendsHorizontalItemSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerRelationshipFriendsUI

/// UpdatedFriendsHorizontalItemSection
///
/// Friends prototype > Messenger 친구 목록
///
///
public struct UpdatedFriendsHorizontalItemSection: View {

    let friend: FriendInfo

    /// Create UpdatedFriendsHorizontalItemSection
    ///
    /// - Parameter account: account information (``FriendInfo``)
    public init(account: FriendInfo) {
        self.friend = account
    }

    public var body: some View {
        if let profileUrl = friend.account.profileUrl {
            PersonRemoveComponent(
                iconBox: UIImage(contentsOfFile: profileUrl),
                subTitle: friend.name,
                badgeView: Circle()
                    .foregroundColor(.pink)
                    .frame(width: 8, height: 8)
            )
        } else {
            PersonRemoveComponent(
                iconBox: nil,
                subTitle: friend.name,
                badgeView: Circle()
                    .foregroundColor(.pink)
                    .frame(width: 8, height: 8)
            )
        }
    }
}

struct UpdatedFriendsHorizontalItemSection_Previews: PreviewProvider {
    static var previews: some View {
        UpdatedFriendsHorizontalItemSection(account: FriendInfo(account: .init(signInId: "MyID",
                                                                               username: "홍길동")))
        .environmentObject(ThemeManager())
        .previewLayout(.sizeThatFits)
    }
}
