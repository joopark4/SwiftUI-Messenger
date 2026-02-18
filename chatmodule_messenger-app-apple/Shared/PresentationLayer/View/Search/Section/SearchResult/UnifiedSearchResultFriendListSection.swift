//
//  UnifiedSearchResultFriendListSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerRelationshipFriendsUI

struct UnifiedSearchResultFriendListSection: View {
    @EnvironmentObject var tm: ThemeManager
    private let friends: [FriendEntity]

    init(friends: [FriendEntity]) {
        self.friends = friends
    }

    var body: some View {
            VStack(spacing: 10) {
                ForEach(friends) { friend in
                    let accountInfo = AccountInfo(signInId: String(friend.id), username: friend.name)
                    UnifiedSearchResultFriendItemSection(account: accountInfo)
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 16)
            .background(tm.theme.systemBackground)
            .cornerRadius(8)
            .padding(.horizontal, 8)
    }
}

#if DEBUG
struct UnifiedSearchResultFriendListSection_Previews: PreviewProvider {
    static var previews: some View {
        UnifiedSearchResultFriendListSection(friends: [FriendEntity()])
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
