//
//  RoomSelectionListSection.swift
//  ChatModuleMessengerChatRoomUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Room Selection List Section
///
/// Chat Room prototype > Messenger 대화방 - 묶음 이미지 메시지 상세보기 - 전달 - 친구 - 전달 대상 선택
///
///
/// Usage:
///
///     RoomSelectionListSection(roomInfos: [])
///
public struct RoomSelectionListSection: View {
    @EnvironmentObject var tm: ThemeManager
    @State var roomInfos: [RoomInfo]
    
    /// Create RoomSelectionListSection
    ///
    /// - Parameter roomInfos: room info data
    public init(roomInfos: [RoomInfo]) {
        self.roomInfos = roomInfos
    }

    public var body: some View {
        List {
            ForEach(roomInfos, id: \.roomId) { roomInfo in
                RoomSelectionListItemSection(roomInfo: roomInfo, isChecked: false)
                    .listRowInsets(EdgeInsets())
            }
        }
        .listStyle(.plain)
    }
}

#if DEBUG
struct RoomSelectionListSection_Previews: PreviewProvider {
    static var previews: some View {
        RoomSelectionListSection(roomInfos: [
            RoomInfo(roomId: 0, lastMessage: "lastMessage 1", roomName: "Room 1"),
            RoomInfo(roomId: 1,
                     isNotReceiveNotification: true,
                     lastMessage: "lastMessage 2 lastMessage 2 lastMessage 2 lastMessage 2 lastMessage 2",
                     roomName: "Room 2"),
            RoomInfo(roomId: 2,
                     lastMessage: "lastMessage 3",
                     memberCount: 99,
                     roomName: "Room 3")
        ])
            .environmentObject(ThemeManager())
    }
}
#endif
