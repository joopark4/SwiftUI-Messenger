//
//  MessageEmojiSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Message Emoji Section
///
/// costomize components > bubble contents > emoji
///
///
/// Usage:
///
///     MessageEmojiSection(messageInfo: MessageInfo(...))
///
struct MessageEmojiSection: View {
    @EnvironmentObject var tm: ThemeManager

    let messageInfo: MessageInfo
    let itemId: String

    /// Create MessageEmojiSection
    /// - Parameter messageInfo: message info data (``MessageInfo``)
    public init(messageInfo: MessageInfo) {
        self.messageInfo = messageInfo
        switch messageInfo.payload.payloadType {
        case .EMOTICON(itemId: let itemId):
            self.itemId = itemId
        default:
            self.itemId = ""
        }
    }
    
    public var body: some View {
        ZStack {
            if let image = UIImage(contentsOfFile: itemId) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            } else {
                // default image 필요
                RoundedRectangle(cornerRadius: 20)
                    .background(tm.theme.systemGray)
                    .opacity(0.5)
                    .frame(width: 100, height: 100)
            }
        }
        .padding(messageInfo.flow == .SENT_MESSAGE ? .trailing : .leading, 8)
    }
}

#if DEBUG
struct MessageEmojiSection_Previews: PreviewProvider {
    static var previews: some View {
        MessageEmojiSection(messageInfo: MessageInfo(type: .EMOTICON,
                                                     payload: .init(payloadType: .TEXT(text: ""))))
    }
}
#endif
