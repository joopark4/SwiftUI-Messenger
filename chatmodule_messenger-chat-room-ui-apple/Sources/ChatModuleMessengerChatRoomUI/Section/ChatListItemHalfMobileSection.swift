//
//  ChatListItemHalfMobileSection.swift
//  ChatModuleMessengerChatRoomUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Chat ListItem HalfMobil eSection
///
/// Chat prototype > 대화방 설정 > setting2
///
///
/// Usage :
///
///     let button = Button(action: {
///
///      }, label: {
///          Text("색상")
///              .foregroundColor(Color.white)
///      })
///      .frame(width: 56, height: 36)
///      .background(Color.purple)
///      .cornerRadius(4)
///
///      ChatListItemHalfMobileSection(subTitle1: "현재 대화방 배경화면", buttonBox: button)
///          .environmentObject(ThemeManager())
///
public struct ChatListItemHalfMobileSection<ButtonBox: View>: View {

    let subTitle1: String
    let buttonBox: ButtonBox

    /// Create ChatListItemHalfMobileSection
    /// - Parameters:
    ///   - subTitle1: Subtitle1 text
    ///   - buttonBox: Button
    public init(subTitle1: String, buttonBox: ButtonBox) {
        self.subTitle1 = subTitle1
        self.buttonBox = buttonBox
    }

    public var body: some View {
        ListItemHalfMobile(subTitle1: subTitle1, iconText: EmptyView(), iconBox: buttonBox)
    }
}

#if DEBUG
struct ChatListItemHalfMobileSection_Previews: PreviewProvider {

    static var previews: some View {

        let button = Button(action: {

        }, label: {
            Text("색상")
                .foregroundColor(Color.white)
        })
        .frame(width: 56, height: 36)
        .background(Color.purple)
        .cornerRadius(4)

        ChatListItemHalfMobileSection(subTitle1: "현재 대화방 배경화면", buttonBox: button)
            .environmentObject(ThemeManager())
    }
}
#endif
