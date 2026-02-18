//
//  MessageParticipantSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Message Participant Section
///
/// Chat Room prototype > Messenger 대화방 - 메시지
///
///
/// Usage:
///
///     MessageParticipantSection(messageInfo: MessageInfo(...)) {
///         // on click reinvite button
///     }
///
public struct MessageParticipantSection: View {
    @EnvironmentObject var tm: ThemeManager

    let messageInfo: MessageInfo
    var onClickReinvite: (() -> Void)?

    /// Create MessageParticipantSection
    /// - Parameters:
    ///   - messageInfo: message info data ``MessageInfo``
    ///   - onClickReinvite: on click reinvite button event
    public init(messageInfo: MessageInfo,
                onClickReinvite: (() -> Void)? = nil) {
        self.messageInfo = messageInfo
        self.onClickReinvite = onClickReinvite
    }

    public var body: some View {
        ChatInfoTextComponent {
            VStack {
                infoText
                reinviteButton
            }
        }
    }

    private var infoText: some View {
        var str = ""
        switch self.messageInfo.participantStatus {
        case .INVITED_CHATROOM:
            str = String(format: tm.lang.localized("ChatMessage.Info.Invited"),
                         messageInfo.fromAccount.username,
                         messageInfo.toAccount.username)

        case .LET_CHATROOM, .REINVITE_CHATROOM:
            str = String(format: tm.lang.localized("ChatMessage.Info.LetChatRoom"),
                         messageInfo.fromAccount.username)
        default:
            break
        }
        return Text(str).font(tm.typo.caption).foregroundColor(.white)
    }

    @ViewBuilder
    private var reinviteButton: some View {
        if self.messageInfo.participantStatus == .REINVITE_CHATROOM {
            Text(tm.lang.localized("ChatMessage.Info.Reinvite"))
                .font(tm.typo.caption)
                .foregroundColor(.white)
                .onTapGesture {
                    onClickReinvite?()
                }
        } else {
            EmptyView()
        }
    }
}

#if DEBUG
struct MessageParticipantSection_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MessageParticipantSection(messageInfo: MessageInfo(type: .INVITE,
                                                               toAccount: .init(signInId: "", username: "김가렌"),
                                                               fromAccount: .init(signInId: "", username: "박티모"),
                                                               participantStatus: .INVITED_CHATROOM))

            MessageParticipantSection(messageInfo: MessageInfo(type: .EXIT,
                                                               fromAccount: .init(signInId: "", username: "박티모"),
                                                               participantStatus: .REINVITE_CHATROOM))
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(ThemeManager())
    }
}
#endif
