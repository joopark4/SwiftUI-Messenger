//
//  ChatRoomAvatarSection.swift
//  ChatModuleMessengerChatRoomUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Chat Room Setting Avata Section
///
/// Chat prototype > Messenger 대화 > 대화방 설정 > Avata
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
public struct ChatRoomAvatarSection: View {
    @EnvironmentObject var tm: ThemeManager
    let roomInfo: RoomInfo
    var buttonEnabled: Bool

    /// Crete ChatRoomAvatarSection
    /// - Parameters:
    ///   - roomInfo: chat room info data
    ///   - buttonEnabled: visible camera
    public init(roomInfo: RoomInfo,
                buttonEnabled: Bool = false) {
        self.roomInfo = roomInfo
        self.buttonEnabled = buttonEnabled
    }

    public var body: some View {
        if buttonEnabled {
            AvatarGroupBig(icon: threePerson, buttonIcon: camera)
        } else {
            AvatarGroupBig(icon: onePerson, buttonIcon: EmptyView())
        }
    }

    private var threePerson: some View {
        Image(systemName: "person.3.fill")
                        .font(.system(size: 62))
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .background(tm.theme.chatmoduleColor00)
                        .mask(Circle())
    }

    private var onePerson: some View {
        Image(systemName: "person.fill")
                        .font(.system(size: 62))
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .background(tm.theme.chatmoduleColor00)
                        .mask(Circle())
    }

    private var camera: some View {
        Image(systemName: "camera.fill").font(.system(size: 13))
         .frame(width: 24, height: 24)
         .foregroundColor(.white)
         .background(Color.gray)
         .mask(Circle())
    }
}

#if DEBUG
struct ChatRoomAvatarSection_Previews: PreviewProvider {
    static let tm = ThemeManager(theme: Theme(types: .basic),
                          lang: Language(types: .english),
                          typo: Typography(types: .basic))

    static var previews: some View {
        VStack {
            ChatRoomAvatarSection(roomInfo: RoomInfo(roomId: 0,
                                                     isNotReceiveNotification: true,
                                                     unreadCount: 3,
                                                     lastMessage: "blahblahblah",
                                                     lastMessageDate: "2025. 02. 09",
                                                     memberCount: 4,
                                                     roomName: "Name1, Name2, Name3, Name4"))
                .environmentObject(tm)

            ChatRoomAvatarSection(roomInfo: RoomInfo(roomId: 0,
                                                     isNotReceiveNotification: true,
                                                     unreadCount: 3,
                                                     lastMessage: "blahblahblah",
                                                     lastMessageDate: "2025. 02. 09",
                                                     memberCount: 4,
                                                     roomName: "Name1, Name2, Name3, Name4"), buttonEnabled: true)
                .environmentObject(tm)
        }
    }
}
#endif
