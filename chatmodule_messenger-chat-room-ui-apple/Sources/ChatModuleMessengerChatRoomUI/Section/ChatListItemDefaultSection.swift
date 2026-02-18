//
//  ChatListItemDefaultSection.swift
//  ChatModuleMessengerChatRoomUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Chat Room Setting Avata Section
///
/// Chat prototype > Messenger 대화 > 대화방 설정 > chat setting1
///
///
/// Usage:
///
///     ChatRoomAvatarSection(roomInfo: RoomInfo(roomId: 0,
///                           isNotReceiveNotification: true,
///                           unreadCount: 3,
///                           lastMessage: "blahblahblah",
///                           lastMessageDate: "2025. 02. 09",
///                           memberCount: 4,
///                           roomName: "Name1, Name2, Name3, Name4"), buttonEnabled: true)
///
public struct ChatListItemDefaultSection: View {
    @EnvironmentObject var tm: ThemeManager
    let subTitle1: String
    let subTitle2: String?

    public init(subTitle1: String, subTitle2: String? = nil) {
        self.subTitle1 = subTitle1
        self.subTitle2 = subTitle2
    }

    public var body: some View {
        ListItemDefaultHalf(subTitle1: subTitle1,
                            iconText: Text(subTitle2 ?? "")
                                .font(tm.typo.subheadline)
                                .foregroundColor(tm.theme.labelColorSecondary),
                            iconBox: EmptyView())
    }
}

#if DEBUG
struct ChatListItemDefaultSection_Previews: PreviewProvider {
    static var previews: some View {
        ChatListItemDefaultSection(subTitle1: "대화방", subTitle2: "대화")
            .environmentObject(ThemeManager())
    }
}
#endif
