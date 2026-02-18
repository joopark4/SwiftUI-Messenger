//
//  MessageMassTextSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Message Mass Text Section
///
/// costomize components > bubble contents > long word
///
///
/// Usage:
///
///     MessageMassTextSection(messageInfo: MessageInfo(...))
///
public struct MessageMassTextSection: View {
    @EnvironmentObject var tm: ThemeManager

    let messageInfo: MessageInfo
    let text: String
    var onClickViewAll: (() -> Void)?
    
    /// Create MessageMassTextSection
    /// - Parameter messageInfo: message info data (``MessageInfo``)
    public init(messageInfo: MessageInfo, onClickViewAll: (() -> Void)? = nil) {
        self.messageInfo = messageInfo
        self.onClickViewAll = onClickViewAll
        switch messageInfo.payload.payloadType {
        case .TEXT(let text):
            self.text = text
        default:
            self.text = ""
        }
    }

    public var body: some View {
        ZStack(alignment: messageInfo.flow == .SENT_MESSAGE ? .bottomTrailing : .topLeading) {
            if messageInfo.flow == .SENT_MESSAGE {
                Image("bubble tail right", bundle: .module)
                    .foregroundColor(tm.theme.bubbleBgMine01)
            } else {
                Image("bubble tail left", bundle: .module)
                    .foregroundColor(Color.white)
            }
            
            VStack {
                Text(LocalizedStringKey(text.prefix(500) + "..."))
                    .font(tm.typo.callout)
                    .foregroundColor(Color.black)
                    .padding(16)

                HStack {
                    ListItemDefaultHalf(subTitle2: tm.lang.localized("ChatMessage.Bubble.ViewAll"),
                                        subTitle2Color: Color(UIColor.darkGray),
                                        iconText: EmptyView(),
                                        iconBox: Image(systemName: "chevron.right")
                                            .foregroundColor(Color(UIColor.darkGray)))
                }
                .frame(height: 38)
                .onTapGesture {
                    onClickViewAll?()
                }
            }
            .background(messageInfo.flow == .SENT_MESSAGE ? tm.theme.bubbleBgMine01 : Color.white)
            .cornerRadius(20, corners: .bottomLeft)
            .cornerRadius(20, corners: .topRight)
            .cornerRadius(messageInfo.flow == .SENT_MESSAGE ? 20 : 0, corners: .topLeft)
            .cornerRadius(messageInfo.flow == .SENT_MESSAGE ? 0 : 20, corners: .bottomRight)
            .padding(messageInfo.flow == .SENT_MESSAGE ? .trailing : .leading, 8)
        }
        .frame(maxWidth: .infinity)

    }
}

#if DEBUG
struct MessageMassTextSection_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MessageMassTextSection(messageInfo: MessageInfo(type: .MASS_TEXT,
                                                            payload: .init(payloadType: .TEXT(text: "google.com 블라블라")),
                                                            flow: .SENT_MESSAGE))
        }
        .environmentObject(ThemeManager())
        .previewLayout(.sizeThatFits)
    }
}
#endif
