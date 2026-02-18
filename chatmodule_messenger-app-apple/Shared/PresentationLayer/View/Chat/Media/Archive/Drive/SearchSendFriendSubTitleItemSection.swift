//
//  SearchSendFriendSubTitleItemSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

/// Search Send Friend Sub Title Item Section
///
/// 대화(Chat), 대화방 서랍, 톡서랍
///
///
/// - Author: trowa
public struct SearchSendFriendSubTitleItemSection: View {

    @EnvironmentObject var tm: ThemeManager

    public var body: some View {
        SubTitleBar(title: getTitle())
    }

    private func getTitle() -> String {
        return tm.lang.localized("Search.Send.User")
    }
}

struct SearchSendFriendSubTitleItemSection_Previews: PreviewProvider {
    static var previews: some View {
        SearchSendFriendSubTitleItemSection()
    }
}
