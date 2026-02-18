//
//  MessageNoticeSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Message Notice Section
///
/// costomize components > bubble contents > notice
///
///
/// Usage:
///
///     MessageNoticeSection(messageInfo: MessageInfo(...))
///
public struct MessageNoticeSection: View {

    @EnvironmentObject var tm: ThemeManager
    let messageInfo: MessageInfo

    /// Create MessageNoticeSection
    ///
    /// - Parameter messageInfo: message info data (``MessageInfo``)
    public init(messageInfo: MessageInfo) {
        self.messageInfo = messageInfo
    }

    public var body: some View {

        VStack(alignment: .leading, spacing: 0) {
            Rectangle() // 이미지 영역
                .foregroundColor(.gray)
                .frame(height: 110)

            ListItemHalfMobileCenterIcon(topIconBox: EmptyView(),
                                         subTitle1: Text("Title")
                                            .font(.headline)
                                            .foregroundColor(tm.theme.labelColorPrimary),
                                         subTitle2: "description",
                                         iconText: linkText,
                                         bottomIconBox: bottomBox,
                                         alignment: .leading)
                .padding(16)

        }
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal, 8)
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

    var bottomBox: some View {
        VStack {
            Text("Button1")
                .font(tm.typo.footnote)
                .frame(maxWidth: .infinity, minHeight: 28)
                .background(tm.theme.befamilyBackground02Light)
            Text("Button2")
                .font(tm.typo.footnote)
                .frame(maxWidth: .infinity, minHeight: 28)
                .background(tm.theme.befamilyBackground02Light)
        }
    }
}

struct MessageNoticeSection_Previews: PreviewProvider {
    static var previews: some View {
        MessageNoticeSection(messageInfo: MessageInfo())
            .environmentObject(ThemeManager())
            .background(ThemeManager().theme.background)
            .previewLayout(.sizeThatFits)
    }
}
