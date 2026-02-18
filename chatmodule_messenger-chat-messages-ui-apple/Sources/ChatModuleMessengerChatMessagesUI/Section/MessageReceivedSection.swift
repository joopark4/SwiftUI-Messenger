//
//  MessageReceivedSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Message Received Section
///
/// 메시지 버블들 틀
///
/// Chat Room prototype > 수신자 메시지
///
///
public struct MessageReceivedSection: View {
    @EnvironmentObject var tm: ThemeManager
    
    @State private var counter: Int
    @State private var showReceiveTime: Bool

    private var messageInfo: MessageInfo
    private let onClick: ((MessageClickEvent) -> Void)?
    
    public init(messageInfo: MessageInfo,
                counter: Int,
                showReceiveTime: Bool,
                onClick: ((MessageClickEvent) -> Void)? = nil) {
        self.messageInfo = messageInfo
        self.counter = counter
        self.showReceiveTime = showReceiveTime
        self.onClick = onClick
    }
    
    // MessageInfo내용에 따라 아이콘 활성화 여부와 메세지 버블 선택해야함
    public var body: some View {
        HStack(alignment:.top, spacing: 0) {
            profile
            
            VStack(alignment: .leading, spacing: 8) {
                partnerName
             
                HStack(spacing: 0) {
                    contents
                    
                    trailingItems
                }
                
            }
        }
    }
    
    private var profile: some View {
        // Account에서 프로필 이미지 얻어와야함
        Avatar(icon: Image(systemName: "person.fill")
                .font(.system(size: 24))
                .foregroundColor(Color.white)
                .frame(width: 40, height: 40)
                .background(tm.theme.chatmoduleColor00),
               badge: EmptyView())
            .padding(.leading, 8)
    }
    
    private var partnerName: some View {
        // Account에서 프로필 이름 얻어와야함
        Text("Name 00001")
            .font(tm.typo.body)
            .foregroundColor(tm.theme.labelColorPrimary)
            .padding(.leading, 8)
    }
    
    private var trailingItems: some View {
        HStack(spacing: 0) {
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
                    Text("\(counter)")
                        .font(.callout)
                        .font(.system(size: 13))
                        .foregroundColor(.pink)
                        .frame(alignment: .trailing)

                    if showReceiveTime {
                        timeText
                    }
                }
                .padding(.bottom, 1)
            }
            
            Spacer()
        }
        .frame(width: 78)
        .padding(.leading, 4)
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
        #if DEBUG
            return Text("오전 09:00")
                .font(tm.typo.footnote)
                .foregroundColor(tm.theme.labelColorSecondary)
                .frame(alignment: .trailing)
        #else
            let df = DateFormatter()
            df.dateFormat = tm.lang.localized("ChatMessage.Bubble.TimeFormat")
            df.locale = .init(identifier: "ko_KR")
            return Text(df.string(from: Date(timeIntervalSince1970:
                                                TimeInterval(self.messageInfo.date))))
                .font(tm.typo.footnote)
                .font(.system(size: 12))
                .foregroundColor(tm.theme.labelColorSecondary)
                .frame(alignment: .trailing)
        #endif
        
    }
    private func selectedRefresh() {
        print(#function)
    }
}

#if DEBUG
struct MessageReceivedSection_Previews: PreviewProvider {
    static var previews: some View {
        MessageReceivedSection(messageInfo: MessageInfo(type: .TEXT,
                                                        payload: .init(payloadType: .TEXT(text: "ㄱㄴㄷㄻㅂ")),
                                                        flow: .RECEIVED_MESSAGE),
                               counter: 4,
                               showReceiveTime: true) { evn in
            
        }
        .background(Color.purple)
        .previewLayout(.sizeThatFits)
        .environmentObject(ThemeManager())
        
        MessageReceivedSection(messageInfo: MessageInfo(type: .TEXT,
                                                        payload: .init(payloadType: .TEXT(text: "ㄱㄴㄷㄻㅂㅅㅇㅈㅊㅋㅌㅍㅎ 기니디리미비시이지치키티피히가나다라바바사아자차카타파하ㄱㄴㄷㄻㅂㅅㅇㅈㅊㅋㅌㅍㅎ 기니디리미비시이지치키티피히가나다라바바사아자차카타파하ㄱㄴㄷㄻㅂㅅㅇㅈㅊㅋㅌㅍㅎ 기니디리미비시이지치키티피히가나다라바바사아자차카타파하ㄱㄴㄷㄻㅂㅅㅇㅈㅊㅋㅌㅍㅎ 기니디리미비시이지치키티피히가나다라바바사아자차카타파하...")),
                                                        flow: .RECEIVED_MESSAGE),
                               counter: 4,
                               showReceiveTime: true) { evn in
            
        }
        .background(Color.purple)
        .previewLayout(.sizeThatFits)
        .environmentObject(ThemeManager())
    }
}
#endif
