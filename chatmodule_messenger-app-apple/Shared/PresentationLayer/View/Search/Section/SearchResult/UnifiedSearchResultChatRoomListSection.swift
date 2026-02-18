//
//  UnifiedSearchResultChatRoomListSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerChatRoomUI

struct UnifiedSearchResultChatRoomListSection: View {
    @EnvironmentObject var tm: ThemeManager
    @Binding var unifiedSearchType: UnifiedSearchType
    private let rooms: [ChatRoomEntity]
    private let allRooms: Bool

    init(rooms: [ChatRoomEntity], allRooms: Bool, unifiedSearchType: Binding<UnifiedSearchType>) {
        self.rooms = rooms
        self.allRooms = allRooms
        _unifiedSearchType = unifiedSearchType
    }

    var body: some View {
        VStack(spacing: 0) {

            VStack(spacing: 0) {
                ForEach(0..<3) { i in
                    Button(action: {}, label: {
                        UnifiedSearchResultChatRoomItemSection(roomInfo: rooms[i])
                    })
                    .frame(height: 60)
                    .padding(.top, 10)
                }
            }
            .padding(.bottom, 16)

            if rooms.count > 3 && !allRooms {
                moreButton
            }
        }
        .background(tm.theme.systemBackground)
    }

    private var moreButton: some View {
        Button(action: {
            unifiedSearchType = .CHAT
        }, label: {
            HStack {
                Spacer()

                Text("더보기")
                    .font(tm.typo.headline)
                    .foregroundColor(tm.theme.labelColorPrimary)

                Spacer()
            }
        })
        .frame(height: 42)
        .background(tm.theme.fillColorPrimary)
    }
}

#if DEBUG
struct UnifiedSearchResultChatRoomListSection_Previews: PreviewProvider {
    static var previews: some View {
        UnifiedSearchResultChatRoomListSection(rooms: [ChatRoomEntity(roomId: 1)], allRooms: false, unifiedSearchType: .constant(.FRIEND))
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
