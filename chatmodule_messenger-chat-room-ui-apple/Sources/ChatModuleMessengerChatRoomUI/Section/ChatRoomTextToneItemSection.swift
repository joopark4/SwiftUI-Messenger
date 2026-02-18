//
//  ChatRoomTextToneItemSection.swift
//  ChatModuleMessengerChatRoomUI
//

import SwiftUI
import ChatModuleMessengerUI

public struct ChatRoomTextToneItemSection: View {
    @EnvironmentObject var tm: ThemeManager

    let textTone: RoomTextTone
    let defaultTone: Bool
    let checked: Bool

    public init(textTone: RoomTextTone,
                defaultTone: Bool = false,
                checked: Bool = false) {
        self.textTone = textTone
        self.defaultTone = defaultTone
        self.checked = checked
    }

    public var body: some View {
        ListItemDefaultHalf(subTitle1: textTone.fileName ?? "",
                            subTitle2: defaultTone ? tm.lang.localized("Chat.Setting.TextTone.Default") : nil,
                            iconText: EmptyView(),
                            iconBox: radioButton)
            .frame(height: 47)
            .listRowInsets(EdgeInsets())
    }

    private var radioButton: some View {
        Button {

        } label: {
            Image(systemName: checked ? "smallcircle.filled.circle" : "circle")
                .foregroundColor(checked ? tm.theme.systemPurple : tm.theme.labelColorTertiary)
        }
    }
}

#if DEBUG
struct ChatRoomTextToneItemSection_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomTextToneItemSection(textTone: .init(fileName: "챗모듈"),
                                    defaultTone: true,
                                    checked: true)
            .previewLayout(.sizeThatFits)
            .environmentObject(ThemeManager())
    }
}
#endif
