//
//  ChatRoomFriendRemoveSection.swift
//  ChatModuleMessengerChatRoomUI
//

import SwiftUI
import ChatModuleMessengerUI


/// ChatRoom Friend RemoveSection
///
/// Chat > 대화상대 선택 시 아바타 정보 섹션
///
///
public struct ChatRoomFriendRemoveSection: View {

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

struct ChatRoomFriendRemoveSection_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomFriendRemoveSection(account: AccountInfo(signInId: "MyID",
                                                         phoneNumber: "01234567890",
                                                         username: "MyName",
                                                         birthday: 19730101,
                                                         profileUrl: nil,
                                                         description: nil,
                                                         profileBackgroundUrl: nil))
    }
}
