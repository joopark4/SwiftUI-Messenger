//
//  FriendsSelectionListSection.swift
//  ChatModuleMessengerChatRoomUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Friends Selection List Section
///
/// Chat Room prototype > Messenger 대화방 - 묶음 이미지 메시지 상세보기 - 전달 - 친구 - 전달 대상 선택
///
///
/// Usage:
///
///     FriendsSelectionListSection(accountInfos: [])
///
public struct FriendsSelectionListSection: View {
    @EnvironmentObject var tm: ThemeManager
    @State var accountInfos: [AccountInfo]

    /// Create FriendsSelectionListSection
    ///
    /// - Parameter AccountInfo: room info data
    public init(accountInfos: [AccountInfo]) {
        self.accountInfos = accountInfos
    }

    public var body: some View {
        List {
            ForEach(accountInfos, id: \.signInId) { accountInfo in
                FriendsSelectionListItemSection(model: accountInfo,
                                                isChecked: false)
                    .listRowInsets(EdgeInsets())
            }
        }
        .listStyle(.plain)
    }
}

#if DEBUG
struct FriendsSelectionListSection_Previews: PreviewProvider {
    static var previews: some View {
        FriendsSelectionListSection(accountInfos: [
            AccountInfo(signInId: "", username: "Name 01"),
            AccountInfo(signInId: "", username: "Name 02"),
            AccountInfo(signInId: "", username: "Name 03")
        ])
            .environmentObject(ThemeManager())
    }
}
#endif
