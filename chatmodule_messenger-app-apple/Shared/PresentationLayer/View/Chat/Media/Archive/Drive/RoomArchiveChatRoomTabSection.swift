//
//  RoomArchiveChatRoomTabSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerChatRoomUI

struct RoomArchiveChatRoomTabSection: View {

    @EnvironmentObject var tm: ThemeManager

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(getAllItems(), id: \.self) { str in
                        Button {
                            // action
                        } label: {
                            RoomArchiveChatRoomItemSection(name: str, underBarEnable: str.compare("A") == .orderedSame ? true : false)
                        }
                    }
                }
                .padding([.leading, .trailing], 14)
            }

            Divider().padding(0)
        }
    }

    private func getDefaultItems() -> [String] {
        return [tm.lang.localized("Common.All"),
                tm.lang.localized("Common.Important")]
    }

    private func getAllItems() -> [String] {
        var items: [String] = getDefaultItems()
        items.append(contentsOf: ["A", "S", "D", "F", "Q", "W", "E"])
        return items
    }
}

struct RoomLinkArchiveChatRoomTabSection_Previews: PreviewProvider {
    static var previews: some View {
        RoomArchiveChatRoomTabSection()
    }
}
