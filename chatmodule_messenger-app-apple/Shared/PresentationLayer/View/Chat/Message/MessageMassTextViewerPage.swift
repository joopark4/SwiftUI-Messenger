//
//  MessageMassTextViewerPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerChatMessagesUI

struct MessageMassTextViewerPage: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) var presentationMode
    let messageInfo: ChatMessageEntity
    var text: String = ""

    init(messageInfo: ChatMessageEntity) {
        self.messageInfo = messageInfo
        if case let .TEXT(text) = messageInfo.payload.payloadType {
            self.text = text
        }
    }
    var body: some View {
        ScrollView {
            Text(LocalizedStringKey(self.text))
                .contextMenu(ContextMenu(menuItems: {
                    Button("Copy", action: {
                        UIPasteboard.general.string = self.text
                    })
                }))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
        }
        .navigationTitle(appState.tm.lang.localized("ChatMessage.Bubble.ViewAll"))
        .navigationBarBackButtonHidden(true)
        .navigationBarColor(backgroundColor: UIColor(appState.tm.theme.systemBackground),
                            tintColor: UIColor(appState.tm.theme.labelColorPrimary))
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(appState.tm.theme.labelColorSecondary)
                }
            }

            ToolbarItem(placement: .primaryAction) {
                Button {

                } label: {
                    Image(systemName: "arrowshape.turn.up.right.fill")
                        .foregroundColor(appState.tm.theme.labelColorSecondary)
                }
            }
        }
    }
}

#if DEBUG
struct MessageMassTextViewerPage_Previews: PreviewProvider {
    static let previewMassTextMessageInfo = ChatMessageEntity(id: "",
                                                              type: .MASS_TEXT,
                                                              payload: .init(payloadType: .TEXT(text: "헬로 www.google.com")),
                                                              roomId: "",
                                                              toAccount: .init(signInId: "", username: ""),
                                                              fromAccount: .init(signInId: "", username: ""),
                                                              flow: .SENT_MESSAGE,
                                                              date: 0,
                                                              status: .SUCCESS,
                                                              isRead: false,
                                                              isDeleted: false)
    static var previews: some View {
        MessageMassTextViewerPage(messageInfo: previewMassTextMessageInfo)
            .environmentObject(AppState())
    }
}
#endif
