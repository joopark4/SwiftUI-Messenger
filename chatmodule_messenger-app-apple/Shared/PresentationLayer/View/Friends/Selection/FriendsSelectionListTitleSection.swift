//
//  FriendsSelectionListTitleSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

/// Friends Selection List Title Section
///
/// Usage:
///
///     FriendsSelectionListTitleSection(title: "내 프로필")
///
struct FriendsSelectionListTitleSection: View {
    @EnvironmentObject var tm: ThemeManager

    let title: String

    init(title: String) {
        self.title = title
    }

    var body: some View {
        VStack(spacing: 0) {
            Divider()
            SubTitleBar(title: title)
                .padding(.vertical, 8)
        }
        .listRowInsets(EdgeInsets())
    }
}

struct FriendsSelectionListTitleSection_Previews: PreviewProvider {
    static var previews: some View {
        FriendsSelectionListTitleSection(title: "내 프로필")
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
