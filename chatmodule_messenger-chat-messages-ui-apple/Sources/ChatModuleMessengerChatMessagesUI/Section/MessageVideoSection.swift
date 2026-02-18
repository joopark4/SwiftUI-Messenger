//
//  MessageVideoSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Message Video Section
///
/// costomize components > bubble contents > video
///
///
/// Usage:
///
///     MessageVideoSection(messageInfo: MessageInfo(...))
///
public struct MessageVideoSection: View {
    @EnvironmentObject var tm: ThemeManager
    let messageInfo: MessageInfo
    
    /// Create MessageVideoSection
    /// - Parameter messageInfo: message info data (``MessageInfo``)
    public init(messageInfo: MessageInfo) {
        self.messageInfo = messageInfo
    }
    
    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image("video image", bundle: .module)
                .cornerRadius(20)
            
            if messageInfo.flow == .SENT_MESSAGE {
                // 재생
                MessageMediaProgressBarSection(icon: "play.fill", title: "0:25", onClick: {

                })
                .padding([.bottom, .trailing], 8)
            } else {
                MessageMediaProgressBarSection(icon: "video.fill", title: "50.214 MB", onClick: {
    
                })
                .padding([.bottom, .trailing], 8)
            }
            
//            // 동영상 전송
//            MessageMediaProgressBarSection(icon: "play.fill", progress: 0.75, title: "223.00/225KB", onClick: {
//
//            })
//            .padding([.bottom, .trailing], 16)
            
//            // 받은 동영상 메시지 기본
//            MessageMediaProgressBarSection(icon: "video.fill", title: "50.214 MB", onClick: {
//
//            })
//            .padding([.bottom, .trailing], 16)
            
            // 동영상 다운로드
//            MessageMediaProgressBarSection(icon: "xmark", progress: 0.75, title: "4.321/5.211 MB", onClick: {
//
//            })
//            .padding([.bottom, .trailing], 16)
        }
        .foregroundColor(Color.white)
        .padding(messageInfo.flow == .SENT_MESSAGE ? .trailing : .leading, 8)
    }
}

#if DEBUG
struct MessageVideoSection_Previews: PreviewProvider {
    static var previews: some View {
        MessageVideoSection(messageInfo: MessageInfo(type:.VIDEO))
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
