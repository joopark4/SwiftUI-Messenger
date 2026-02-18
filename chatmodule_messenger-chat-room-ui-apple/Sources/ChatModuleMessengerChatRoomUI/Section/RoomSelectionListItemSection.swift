//
//  RoomSelectionListItemSection.swift
//  ChatModuleMessengerChatRoomUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Room Selection List Item Section
///
/// Chat Room prototype > Messenger 대화방 - 묶음 이미지 메시지 상세보기 - 전달 - 친구 - 전달 대상 선택
///
///
/// Usage:
///
///     RoomSelectionListItemSection(roomInfo: RoomInfo(roomId: 0,
///                                  isNotReceiveNotification: true,
///                                  lastMessage: "blahblahblah",
///                                  memberCount: 4,
///                                  roomName: "Name1, Name2, Name3, Name4"))
///
public struct RoomSelectionListItemSection: View {
    @EnvironmentObject var tm: ThemeManager
    let roomInfo: RoomInfo
    @State var isChecked: Bool?
    let onCheckChanged: ((Bool) -> Void)?

    /// Create RoomSelectionListItemSection
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
                             notification: roomNotification)
            .listRowInsets(EdgeInsets())
    }

    @ViewBuilder
    private var checkBox: some View {
        if let isChecked = self.isChecked {
            Button {
                self.isChecked?.toggle()
                self.onCheckChanged?(isChecked)
            } label: {
                Image(systemName: isChecked ? "smallcircle.filled.circle" : "circle")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(isChecked ? tm.theme.systemPurple : tm.theme.labelColorSecondary)
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
struct RoomSelectionListItemSection_Previews: PreviewProvider {
    static var previews: some View {
        RoomSelectionListItemSection(roomInfo: RoomInfo(roomId: 0,
                                                  isNotReceiveNotification: true,
                                                  lastMessage: "blahblahblah",
                                                  memberCount: 4,
                                                  roomName: "Name1, Name2, Name3, Name4"),
                                     isChecked: true)
            .previewLayout(.sizeThatFits)
            .environmentObject(ThemeManager())
    }
}
#endif
