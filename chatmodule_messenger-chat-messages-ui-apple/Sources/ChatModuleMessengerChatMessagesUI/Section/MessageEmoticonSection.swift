//
//  MessageEmoticonSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Message Emoticon Section
///
/// costomize components > bubble contents > emoticon
///
///
/// Usage:
///
///     MessageEmoticonSection(messageInfo: MessageInfo(...))
///
struct MessageEmoticonSection: View {
    @EnvironmentObject var tm: ThemeManager

    let messageInfo: MessageInfo
    let itemId: String

    /// Create MessageEmoticonSection
    /// - Parameter messageInfo: message info data (``MessageInfo``)
    public init(messageInfo: MessageInfo) {
        self.messageInfo = messageInfo
        switch messageInfo.payload.payloadType {
        case .EMOTICON(let itemId):
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
                    .frame(width: 150, height: 150)
            } else {
                // default image 필요
                RoundedRectangle(cornerRadius: 20)
                    .background(tm.theme.systemGray)
                    .opacity(0.5)
                    .frame(width: 150, height: 150)
            }
        }
        .padding(messageInfo.flow == .SENT_MESSAGE ? .trailing : .leading, 8)
    }
}

#if DEBUG
struct MessageEmoticonSection_Previews: PreviewProvider {
    static var previews: some View {
        MessageEmoticonSection(messageInfo: MessageInfo(type: .EMOTICON,
                                                        payload: .init(payloadType: .TEXT(text: ""))))
    }
}
#endif
