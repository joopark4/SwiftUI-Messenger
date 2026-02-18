//
//  MessageDateSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Message Date Section
///
/// Chat Room prototype > Messenger 대화방 - 메시지
///
///
/// Usage:
///
///     MessageDateSection(messageInfo: MessageInfo(...))
///
public struct MessageDateSection: View {
    @EnvironmentObject var tm: ThemeManager

    let messageInfo: MessageInfo

    /// Create MessageDateSection
    /// - Parameters:
    ///   - messageInfo: message info data ``MessageInfo``
    public init(messageInfo: MessageInfo) {
        self.messageInfo = messageInfo
    }

    public var body: some View {
        ChatInfoTextComponent {
            dateText
        }
    }

    private var dateText: some View {
        let date = Date(timeIntervalSince1970: TimeInterval(messageInfo.date))
        let df = DateFormatter()
        df.dateFormat = tm.lang.localized("ChatMessage.Info.DateFormat")
        df.locale = .init(identifier: "ko_KR")
        let str = df.string(from: date)
        return Text(str).font(tm.typo.caption).foregroundColor(.white)
    }
}

#if DEBUG
struct MessageDateSection_Previews: PreviewProvider {
    static var previews: some View {
        MessageDateSection(messageInfo: MessageInfo(type: .TEXT,
                                                    date: Int(Date().timeIntervalSince1970)))
        .previewLayout(.sizeThatFits)
        .environmentObject(ThemeManager())
    }
}
#endif
