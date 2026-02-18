//
//  MessageSmileMeSection.swift
//  ChatModuleMessengerChatMessagesUI
//

/// Message SmileMe Section
///
/// Messenger 대화방 > 이모티콘 메시지 입력 > 스마일미
///
///
/// Usage:
///
///     MessageSmileMeSection(messageInfo: MessageInfo(...))
///
import SwiftUI
import ChatModuleMessengerUI
import SDWebImageSwiftUI

public struct MessageSmileMeSection: View {
    
    @EnvironmentObject var tm: ThemeManager
    let messageInfo: MessageInfo
    
    /// Create MessageSmileMeSection
    /// - Parameter messageInfo: message info data (``MessageInfo``)
    public init(messageInfo: MessageInfo) {
        self.messageInfo = messageInfo
    }
    
    public var body: some View {
        ZStack {
            AnimatedImage(url: URL(string: "https://mathiasbynens.be/demo/animated-webp-supported.webp"))
                .customLoopCount(nil)
                .resizable()
                .placeholder { Color.gray }
                .indicator(SDWebImageActivityIndicator.medium)
                .scaledToFit()
        }
        .frame(width: 120, height: 120)
        .cornerRadius(14)
        .padding(messageInfo.flow == .SENT_MESSAGE ? .trailing : .leading, 8)
    }
}

#if DEBUG
struct MessageSmileMeSection_Previews: PreviewProvider {
    static var previews: some View {
        
        MessageSmileMeSection( messageInfo: MessageInfo(type: .SMILEME,
                                                         flow: .SENT_MESSAGE))
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
        
        MessageSmileMeSection( messageInfo: MessageInfo(type: .SMILEME,
                                                         flow: .RECEIVED_MESSAGE))
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
