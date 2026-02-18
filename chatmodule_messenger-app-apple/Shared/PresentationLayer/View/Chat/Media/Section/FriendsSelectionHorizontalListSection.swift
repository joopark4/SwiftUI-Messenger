//
//  FriendsSelectionHorizontalListSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerChatRoomUI

struct FriendsSelectionHorizontalListSection: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 4) {
                ForEach(0..<8) { _ in
                    FriendsSelectionHorizontalListItemSection(account: nil)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct FriendsSelectionHorizontalListSection_Previews: PreviewProvider {
    static var previews: some View {
        FriendsSelectionHorizontalListSection()
    }
}
