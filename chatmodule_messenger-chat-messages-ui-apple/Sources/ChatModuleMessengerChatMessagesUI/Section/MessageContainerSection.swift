//
//  MessageContainerSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI

public enum MessageClickEvent {
    case SHARE, RETRY, CANCEL, VIEW_ALL, REINVITE
}

/// Message Container Section
///
/// Chat Room prototype > 메세지 버블 컨테이너
///
///
public struct MessageContainerSection: View {

    private let messageInfo: MessageInfo
    private let onClick: ((MessageClickEvent) -> Void)?

    public init(messageInfo: MessageInfo,
                onClick: ((MessageClickEvent) -> Void)? = nil) {
        self.messageInfo = messageInfo
        self.onClick = onClick
    }

    public var body: some View {
        switch self.messageInfo.type {

        case .PREVIOUS_DATE:
            MessageDateSection(messageInfo: messageInfo)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 4, leading: 9, bottom: 4, trailing: 9))
        case .INVITE, .EXIT:
            MessageParticipantSection(messageInfo: messageInfo) {
                self.onClick?(.REINVITE)
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 4, leading: 9, bottom: 4, trailing: 9))
        default:
            if messageInfo.flow == .SENT_MESSAGE {
                MessageSentSection(messageInfo: messageInfo,
                                   counter: 4,
                                   showSendTime: true,
                                   onClick: onClick)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 4, leading: 9, bottom: 4, trailing: 9))
            } else {
                MessageReceivedSection(messageInfo:
                                    messageInfo, counter: 1,
                                    showReceiveTime: true,
                                    onClick: onClick)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 4, leading: 9, bottom: 4, trailing: 9))
            }
        }
    }
}

struct MessageContainerSection_Previews: PreviewProvider {
    static var previews: some View {
        MessageContainerSection(messageInfo: MessageInfo()) { evn in

        }
    }
}
