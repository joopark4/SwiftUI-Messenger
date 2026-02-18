//
//  UnifiedSearchResultChatRoomSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

struct UnifiedSearchResultChatRoomSection: View {
    @EnvironmentObject var tm: ThemeManager
    @Binding var unifiedSearchType: UnifiedSearchType
    private let rooms: [ChatRoomEntity]

    init(rooms: [ChatRoomEntity], unifiedSearchType: Binding<UnifiedSearchType>) {
        self.rooms = rooms
        _unifiedSearchType = unifiedSearchType
    }

    var body: some View {
        VStack(spacing: 0) {

            SearchTitleBarSection(title: tm.lang.localized("Search.Result.ChatRoom"))
                .frame(height: 37)

            UnifiedSearchResultChatRoomListSection(rooms: rooms, allRooms: false, unifiedSearchType: $unifiedSearchType)
        }
        .background(tm.theme.systemBackground)
        .cornerRadius(8)
        .padding(.horizontal, 8)
    }
}

#if DEBUG
struct UnifiedSearchResultChatRoomSection_Previews: PreviewProvider {
    static var previews: some View {
        UnifiedSearchResultChatRoomSection(rooms: [ChatRoomEntity(roomId: 1)], unifiedSearchType: .constant(.CHAT))
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
