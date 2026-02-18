//
//  MessageTextSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Message Text Section
///
/// costomize components > bubble contents > short word
///
///
/// Usage:
///
///     MessageTextSection(messageInfo: MessageInfo(...))
///     
public struct MessageTextSection: View {
    @EnvironmentObject var tm: ThemeManager

    let messageInfo: MessageInfo
    let text: String
    
    
    /// Create MessageTextSection
    /// - Parameter messageInfo: message info data (``MessageInfo``)
    public init(messageInfo: MessageInfo) {
        self.messageInfo = messageInfo
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
                Text(LocalizedStringKey(text))
                    .font(tm.typo.callout)
                    .foregroundColor(Color.black)
                    .padding(16)
            }
            .background(messageInfo.flow == .SENT_MESSAGE ? tm.theme.bubbleBgMine01 : Color.white)
            .cornerRadius(20, corners: .bottomLeft)
            .cornerRadius(20, corners: .topRight)
            .cornerRadius(messageInfo.flow == .SENT_MESSAGE ? 20 : 0, corners: .topLeft)
            .cornerRadius(messageInfo.flow == .SENT_MESSAGE ? 0 : 20, corners: .bottomRight)
            .padding(messageInfo.flow == .SENT_MESSAGE ? .trailing : .leading, 8)
        }

    }
}

#if DEBUG
struct MessageTextSection_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MessageTextSection(messageInfo: MessageInfo(type: .TEXT,
                                                        payload: .init(payloadType: .TEXT(text: "헬로 www.google.comsdfoidsjfoweifjoewifjoweifjieowwoeifjoewfijeowifjooewijfoewifjoweifjowiejfoiewjf")),
                                                        flow: .RECEIVED_MESSAGE))
        }
        .background(Color.purple)
        .environmentObject(ThemeManager())
        .previewLayout(.sizeThatFits)
        
        MessageTextSection(messageInfo: MessageInfo(type: .TEXT,
                                                    payload: .init(payloadType: .TEXT(text: "헬로")),
                                                    flow: .RECEIVED_MESSAGE))
            .background(Color.purple)
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
