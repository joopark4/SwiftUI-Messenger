//
//  SearchSendFriendItemSection.swift
//  ChatModuleMessengerRelationshipFriendsUI
//

import SwiftUI
import ChatModuleMessengerUI


/// Search Send Friend Item Section
///
/// 대화(Chat), 대화방 서랍, 톡서랍
///
///
public struct SearchSendFriendItemSection: View {

    @EnvironmentObject var tm: ThemeManager

    private let title: String

    public init(title: String) {
        self.title = title
    }

    public var body: some View {
        ListItemHalfMobileLeftIconComponent(leftIconBox: avartaIcon,
                                            subTitle1: title,
                                            iconText: EmptyView(),
                                            rightIconBox: EmptyView())
    }

    private var avartaIcon: some View {
        Avatar(icon: Image(systemName: "book.fill")
            .resizable()
            .frame(width: 32, height: 32),
               badge: EmptyView())
    }
}

struct SearchSendFriendItemSection_Previews: PreviewProvider {
    static var previews: some View {
        SearchSendFriendItemSection(title: "AMND")
    }
}
