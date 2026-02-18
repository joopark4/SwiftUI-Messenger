//
//  MessageLinkPreviewSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Message Link Preview Section
///
/// costomize components > bubble contents > link
///
///
/// Usage:
///
///     MessageLinkPreviewSection(messageInfo: MessageInfo(...))
///
public struct MessageLinkPreviewSection: View {

    @EnvironmentObject var tm: ThemeManager
    let messageInfo: MessageInfo

    /// Create MessageLinkPreviewSection
    ///
    /// - Parameter messageInfo: message info data (``MessageInfo``)
    public init(messageInfo: MessageInfo) {
        self.messageInfo = messageInfo
    }

    public var body: some View {
        VStack(alignment: messageInfo.flow == .SENT_MESSAGE ? .trailing : .leading,
               spacing: 8) {
            MessageTextSection(messageInfo: messageInfo)

            VStack(spacing: 0) {
                Rectangle() // 이미지 영역
                    .foregroundColor(.gray)
                    .frame(height: 132)

                ListItemHalfMobile(subTitle1: "Title",
                                   subTitle2: "description",
                                   iconText: linkText,
                                   iconBox: EmptyView())
                    .padding(.vertical, 16)
                    .background(Color.white)
            }
            .cornerRadius(20)
            .padding(.horizontal, 8)
        }
        .frame(maxWidth: .infinity)
    }

    var linkText: some View {
        HStack(spacing: 4) {
            Image(systemName: "link")
                .foregroundColor(tm.theme.systemPurple)
                .font(.system(size: 14))
            Text("link.url.com")
                .font(.subheadline)
                .foregroundColor(tm.theme.labelColorSecondary)

        }
    }
}

struct MessageLinkPreviewSection_Previews: PreviewProvider {
    static var previews: some View {
        MessageLinkPreviewSection(messageInfo: MessageInfo(type: .TEXT,
                                                           payload: .init(payloadType: .TEXT(text: "www.google.com"))))
            .environmentObject(ThemeManager())
            .background(ThemeManager().theme.background)
            .previewLayout(.sizeThatFits)
    }
}
