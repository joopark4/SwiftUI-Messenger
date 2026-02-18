//
//  RoomSelectionHorizontalListSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerChatRoomUI

struct RoomSelectionHorizontalListSection: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 4) {
                ForEach(0..<8) { _ in
                    RoomSelectionHorizontalListItemSection(roomInfo: nil)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct RoomSelectionHorizontalListSection_Previews: PreviewProvider {
    static var previews: some View {
        RoomSelectionHorizontalListSection()
    }
}
