//
//  FriendsSelectionHorizontalItemSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

/// Friends Selection Horizontal Item Section
///
/// Chat > 대화상대 선택 시 아바타 정보 섹션
///
///
public struct FriendsSelectionHorizontalItemSection: View {

    let account: AccountInfo

    public init(account: AccountInfo) {
        self.account = account
    }

    public var body: some View {
        if let profileUrl = account.profileUrl {
            PersonRemove(iconBox: UIImage(contentsOfFile: profileUrl), subTitle: account.username)
        } else {
            PersonRemove(iconBox: nil, subTitle: account.username)
        }
    }
}

struct FriendsSelectionHorizontalItemSection_Previews: PreviewProvider {
    static var previews: some View {
        FriendsSelectionHorizontalItemSection(account: AccountInfo(signInId: "MyID",
                                                                   phoneNumber: "01234567890",
                                                                   username: "MyName",
                                                                   birthday: 19730101,
                                                                   profileUrl: nil,
                                                                   description: nil,
                                                                   profileBackgroundUrl: nil))
        .environmentObject(ThemeManager())
        .previewLayout(.sizeThatFits)
    }
}
