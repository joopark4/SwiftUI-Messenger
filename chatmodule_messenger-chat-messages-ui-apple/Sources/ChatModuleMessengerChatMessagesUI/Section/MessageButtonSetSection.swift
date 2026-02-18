//
//  MessageButtonSetSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Message Button SetSection
///
/// 메세지 전송 실패 시 재전송, 취소 버튼
///
/// Customize components > bubble box > button set
///
///
public struct MessageButtonSetSection: View {
    @EnvironmentObject var tm: ThemeManager

    private let onClick: ((MessageClickEvent) -> Void)?

    public init(onClick: ((MessageClickEvent) -> Void)? = nil) {
        self.onClick = onClick
    }

    public var body: some View {
        
        ZStack {
            tm.theme.labelColorTertiary
                .cornerRadius(4)
            
            HStack(spacing:0) {
                ZStack {
                    tm.theme.systemBackgroundSecondary
                        .cornerRadius(4, corners: .topLeft)
                        .cornerRadius(4, corners: .bottomLeft)

                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(tm.theme.labelColorPrimary)
                        .font(.system(size: 13))

                }
                .padding(1.5)
                .onTapGesture {
                    self.onClick?(.RETRY)
                }

                ZStack {
                    tm.theme.systemBackgroundSecondary
                        .cornerRadius(4, corners: .topRight)
                        .cornerRadius(4, corners: .bottomRight)

                    Image(systemName: "xmark")
                        .foregroundColor(tm.theme.systemRed)
                        .font(.system(size: 13))
                }
                .padding(1.5)
                .onTapGesture {
                    self.onClick?(.CANCEL)
                }
            }
        }
        
        .frame(width: 60, height: 28, alignment: .leading)
    }
}

#if DEBUG
struct MessageButtonSetSection_Previews: PreviewProvider {
    static var previews: some View {
        MessageButtonSetSection()
            .previewLayout(.sizeThatFits)
            .environmentObject(ThemeManager())
    }
}
#endif
