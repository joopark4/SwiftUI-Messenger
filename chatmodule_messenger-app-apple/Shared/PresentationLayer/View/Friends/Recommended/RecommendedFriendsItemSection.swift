//
//  RecommendedFriendsItemSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerRelationshipFriendsUI

struct RecommendedFriendsItemSection: View {
    @EnvironmentObject var tm: ThemeManager

    let friend: FriendInfo
    var onClick: ((FriendInfo) -> Void)?

    init(friend: FriendInfo,
         onClick: ((FriendInfo) -> Void)? = nil) {
        self.friend = friend
        self.onClick = onClick
    }

    var body: some View {
        ListItemHalfMobileLeftIconComponent(
            leftIconBox: Avatar(icon: Image.profileImage(nil)
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(tm.theme.chatmoduleColor00),
                                badge: EmptyView()),
            subTitle1: friend.name,
            iconText: EmptyView(),
            rightIconBox: addButton)
        .frame(height: 52)
        .listRowInsets(EdgeInsets())
    }

    var addButton: some View {
        Button {
            onClick?(friend)
        } label: {
            Image(systemName: "person.fill.badge.plus")
                .font(.system(size: 16))
                .foregroundColor(tm.theme.labelColorPrimary)
        }
        .frame(width: 62, height: 42)
        .background(tm.theme.systemGray4)
        .cornerRadius(8)
    }
}

struct RecommendedFriendsItemSection_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedFriendsItemSection(friend: FriendInfo(account: .init(signInId: "", username: "Name")))
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
