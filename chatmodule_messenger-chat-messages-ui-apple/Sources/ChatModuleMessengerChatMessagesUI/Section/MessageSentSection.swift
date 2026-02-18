//
//  MessageSentSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Message Sent Section
///
/// 메시지 버블들 틀
///
/// Chat Room prototype > 발신자 메시지
///
///
public struct MessageSentSection: View {

    @EnvironmentObject var tm: ThemeManager

    @State private var counter: Int
    @State private var showSendTime: Bool

    private var messageInfo: MessageInfo
    private let onClick: ((MessageClickEvent) -> Void)?

    public init(messageInfo: MessageInfo,
                counter: Int,
                showSendTime: Bool,
                onClick: ((MessageClickEvent) -> Void)? = nil) {
        self.messageInfo = messageInfo
        self.counter = counter
        self.showSendTime = showSendTime
        self.onClick = onClick
    }

    // MessageInfo내용에 따라 아이콘 활성화 여부와 메세지 버블 선택해야함
    public var body: some View {
        HStack(spacing:0) {
            Spacer(minLength: 0)
            
            leadingItems

            contents
        }
    }

    private var leadingItems: some View {
        HStack(spacing: 0) {
            Spacer()
            
            VStack {
                Spacer()

                ZStack {
                    Circle()
                        .frame(width: 28, height: 28, alignment: .center)
                        .foregroundColor(tm.theme.systemGray)
                    
                    Image(systemName: "arrowshape.turn.up.right.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 13))
                }
                .onTapGesture {
                    self.onClick?(.SHARE)
                }

                Spacer()

                VStack(alignment: .trailing) {
                    MessageButtonSetSection(onClick: onClick)
                        .frame(alignment: .trailing)

                    Text("\(counter)")
                        .font(.callout)
                        .font(.system(size: 13))
                        .foregroundColor(.pink)
                        .frame(alignment: .trailing)

                    if showSendTime {
                        timeText
                    }
                }
                .padding(.bottom, 1)
            }
        }
        .frame(width: 110)
        .padding(.trailing, 4)
    }

    @ViewBuilder
    private var contents: some View {
        switch messageInfo.type {
        case .TEXT:
            MessageTextSection(messageInfo: messageInfo)
        case .MASS_TEXT:
            MessageMassTextSection(messageInfo: messageInfo) {
                self.onClick?(.VIEW_ALL)
            }
        case .IMAGE:
            MessageImageSection(messageInfo: messageInfo)
        case .EMOTICON:
            MessageEmoticonSection(messageInfo: messageInfo)
        case .VIDEO:
            MessageVideoSection(messageInfo: messageInfo)
        case .SMILEME:
            MessageSmileMeSection(messageInfo: messageInfo)
        case .FILE:
            MessageFileSection(messageInfo: messageInfo)
        default:
            EmptyView()
        }
    }
    
    private var timeText: some View {
        let df = DateFormatter()
        df.dateFormat = tm.lang.localized("ChatMessage.Bubble.TimeFormat")
        df.locale = .init(identifier: "ko_KR")
        return Text(df.string(from: Date(timeIntervalSince1970:
                                            TimeInterval(self.messageInfo.date))))
            .font(tm.typo.footnote)
            .foregroundColor(tm.theme.labelColorSecondary)
            .frame(alignment: .trailing)
    }
    private func selectedRefresh() {
        print(#function)
    }
}

#if DEBUG
struct MessageTypeSection_Previews: PreviewProvider {
    static var previews: some View {
        MessageSentSection(messageInfo: MessageInfo(type:.FILE,
                                                    flow: .SENT_MESSAGE),
                           counter: 4,
                           showSendTime: true) { evn in
            
        }
        .environmentObject(ThemeManager())
    }
}
#endif
