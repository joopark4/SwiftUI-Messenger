//
//  MessageInputSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Message Input Section
///
/// Chat Room prototype > Messenger 대화방 - 메시지
///
///
/// Usage:
///
///     MessageInputSection(text: $text, bottomSectionType: .constant(.NONE))
///
/// or
///
///     MessageInputSection(text: .constant("채팅이 불가능한 대화방입니다."),
///                         bottomSectionType: .constant(.NONE),
///                         isDisabled: true)
///
public struct MessageInputSection: View {
    @EnvironmentObject var tm: ThemeManager
    @Binding var bottomSectionType: ChatRoomBottomSectionType
    @Binding var text: String
    @Binding var textFieldHeight: CGFloat
    var sendBtnClick: ((String) -> Void)?
    let isDisabled: Bool

    /// Create message input section
    ///
    /// - Parameter text: input text
    public init(text: Binding<String>,
                bottomSectionType: Binding<ChatRoomBottomSectionType>,
                textFieldHeight: Binding<CGFloat>,
                isDisabled: Bool = false, sendBtnClick: ((String) -> Void)? = nil) {
        _text = text
        _bottomSectionType = bottomSectionType
        _textFieldHeight = textFieldHeight
        self.isDisabled = isDisabled
        self.sendBtnClick = sendBtnClick
    }

    public var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Button {
                clickServiceButton()
            } label: {
                Image(systemName: self.getServiceImageName())
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(isDisabled ?
                                     tm.theme.labelColorTertiary :
                                        tm.theme.labelColorSecondary)
            }
            .frame(width: 28, height: 28)
            .padding(.horizontal, 8)
            .padding(.vertical, 14)
            .disabled(isDisabled)

            MultiLineTextField(text: $text,
                               height: $textFieldHeight,
                               isDisabled: isDisabled)
                .frame(height: textFieldHeight)
                .padding(.horizontal, 8)
                .padding(.vertical, 9.5)
                .disabled(isDisabled)

            if !isDisabled {
                Button {
                    clickEmoticonButton()
                } label: {
                    Image(systemName: getEmoticonImageName())
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(tm.theme.labelColorSecondary)
                }
                .frame(width: 28, height: 28)
                //            .padding(.horizontal, 8)
                .padding(.vertical, 14)

                Button {
                    sendBtnClick?(text)
                } label: {
                    Image(systemName: "paperplane.circle.fill")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(tm.theme.systemPurple)
                }
                .frame(width: 28, height: 28)
                .padding(.horizontal, 8)
                .padding(.vertical, 14)
            }
        }
        .background(tm.theme.systemBackground)
    }

    private func getServiceImageName() -> String {
        switch self.bottomSectionType {
        case .NONE:
            return "plus.square"
        case .SERVICE:
            return "xmark.square.fill"
        default:
            return "plus.square"
        }
    }

    private func clickServiceButton() {
        switch self.bottomSectionType {
        case .SERVICE:
            self.bottomSectionType = .NONE
        default:
            self.bottomSectionType = .SERVICE
        }
    }

    private func getEmoticonImageName() -> String {
        switch self.bottomSectionType {
//        case .NONE:
//            return "plus.square"
//        case .SERVICE:
//            return "xmark.square.fill"
        default:
            return "smiley"
        }
    }

    private func clickEmoticonButton() {
        switch self.bottomSectionType {
        case .EMOTICON:
            self.bottomSectionType = .NONE
        default:
            self.bottomSectionType = .EMOTICON
        }
    }
}

#if DEBUG
struct MessageInputSection_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MessageInputSection(text: .constant("some text"),
                                bottomSectionType: .constant(.NONE), textFieldHeight: .constant(MultiLineTextFieldSize.MIN_HEIGHT.rawValue))

            MessageInputSection(text: .constant("채팅이 불가능한 대화방입니다."),
                                bottomSectionType: .constant(.NONE), textFieldHeight: .constant(MultiLineTextFieldSize.MIN_HEIGHT.rawValue),
                                isDisabled: true)
        }
        .environmentObject(ThemeManager())
        .previewLayout(.sizeThatFits)
        .background(Color.gray)
    }
}
#endif
