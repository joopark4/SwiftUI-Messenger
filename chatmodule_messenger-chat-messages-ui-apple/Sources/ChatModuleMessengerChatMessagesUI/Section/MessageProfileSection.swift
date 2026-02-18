//
//  MessageProfileSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Message Profile Section
///
/// Chat prototype > Messenger 대화 - 프로필 보내기
///
///
/// Usage:
///
///      MessageProfileSection(accountInfo: AccountInfo(signInId: "", username: "Name"))
///
struct MessageProfileSection: View {
    @EnvironmentObject var tm: ThemeManager

    let accountInfo: AccountInfo

    /// Create MessageProfileSection
    ///
    /// - Parameter accountInfo: account info (``accountInfo``)
    init(accountInfo: AccountInfo) {
        self.accountInfo = accountInfo
    }

    var body: some View {
        ListItem6Component(
            iConBox: Avatar(
                icon: Image.profileImage(nil)
                    .resizable()
                    .frame(width: 48, height: 48)
                    .foregroundColor(tm.theme.chatmoduleColor00),
                badge: EmptyView()),
            title: Text(accountInfo.username)
                .font(tm.typo.headline)
                .foregroundColor(tm.theme.labelColorPrimary),
            iconText: EmptyView(),
            buttonList: buttons
        )
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }

    var buttons: some View {
        HStack(spacing: 8) {
            Text("친구 추가")
                .font(tm.typo.footnote)
                .frame(maxWidth: .infinity, minHeight: 28)
                .foregroundColor(tm.theme.labelColorPrimary)
                .background(tm.theme.befamilyBackground02Light)
                .cornerRadius(4)

            Text("프로필 보기")
                .font(tm.typo.footnote)
                .frame(maxWidth: .infinity, minHeight: 28)
                .foregroundColor(tm.theme.labelColorPrimary)
                .background(tm.theme.befamilyBackground02Light)
                .cornerRadius(4)
        }
        .padding(.top)
    }
}

struct MessageProfileSection_Previews: PreviewProvider {
    static var previews: some View {
        MessageProfileSection(accountInfo: AccountInfo(signInId: "", username: "Name"))
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
