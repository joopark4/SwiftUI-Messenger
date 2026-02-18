//
//  ChatRoomInfoItemSection.swift
//  ChatModuleMessengerChatRoomUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Chat Room Info Item Section
///
/// Chat prototype > Messenger 대화 목록
///
///
/// Usage:
///
///     ChatRoomInfoItemSection(roomInfo: RoomInfo(roomId: 0,
///                             isNotReceiveNotification: true,
///                             unreadCount: 3,
///                             lastMessage: "blahblahblah",
///                             lastMessageDate: "2025. 02. 09",
///                             memberCount: 4,
///                             roomName: "Name1, Name2, Name3, Name4"))
///
public struct ChatRoomInfoItemSection: View {
    @EnvironmentObject var tm: ThemeManager
    let roomInfo: RoomInfo
    @State var isChecked: Bool?
    let onCheckChanged: ((Bool) -> Void)?

    /// Create ChatRoomInfoItemSection
    ///
    /// - Parameters:
    ///   - roomInfo: chat room info data
    ///   - isChecked: checkbox initial value
    ///   - onCheckChanged: check box changed closure
    public init(roomInfo: RoomInfo,
                isChecked: Bool? = nil,
                onCheckChanged: ((Bool) -> Void)? = nil) {
        self.roomInfo = roomInfo
        _isChecked = State(initialValue: isChecked)
        self.onCheckChanged = onCheckChanged
    }

    public var body: some View {
        ChatTwoLineComponent(checkBox: checkBox,
                             avatarGroup: Avatar(icon: Image(systemName: "person.circle.fill")
                                                    .resizable()
                                                    .frame(width: 48, height: 48)
                                                    .foregroundColor(tm.theme.chatmoduleColor00),
                                                badge: EmptyView()),
                             subTitle1: roomInfo.roomName ?? "",
                             subTitle2: roomInfo.lastMessage,
                             amountPerson: roomInfo.memberCount,
                             favorite: roomFavorite,
                             notification: roomNotification,
                             dayText: roomInfo.lastMessageDate,
                             badge: roomInfo.unreadCount)
            .listRowInsets(EdgeInsets())
    }

    @ViewBuilder
    private var checkBox: some View {
        if let isChecked = self.isChecked {
            Button {
                self.isChecked?.toggle()
                self.onCheckChanged?(isChecked)
            } label: {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(self.tm.theme.systemPurple)
            }
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    private var roomFavorite: some View {
        if self.roomInfo.isFavorite {
            Image(systemName: "pin.fill")
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var roomNotification: some View {
        if self.roomInfo.isNotReceiveNotification {
            Image(systemName: "bell.slash.fill")
        } else {
            EmptyView()
        }
    }
}

#if DEBUG
struct ChatRoomInfoItemSection_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomInfoItemSection(roomInfo: RoomInfo(roomId: 0,
                                                  isNotReceiveNotification: true,
                                                  unreadCount: 3,
                                                  lastMessage: "blahblahblah",
                                                  lastMessageDate: "2025. 02. 09",
                                                  memberCount: 4,
                                                  roomName: "Name1, Name2, Name3, Name4"))
            .environmentObject(ThemeManager())
    }
}
#endif
