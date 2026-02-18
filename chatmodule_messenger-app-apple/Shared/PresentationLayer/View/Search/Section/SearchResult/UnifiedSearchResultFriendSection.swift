//
//  UnifiedSearchResultFriendSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

struct UnifiedSearchResultFriendSection: View {
    @EnvironmentObject var tm: ThemeManager
    @Binding var unifiedSearchType: UnifiedSearchType
    private let friends: [FriendEntity]

    init(friends: [FriendEntity], unifiedSearchType: Binding<UnifiedSearchType>) {
        self.friends = friends
        _unifiedSearchType = unifiedSearchType
    }

    var body: some View {
        VStack(spacing: 0) {

            SearchTitleBarSection(title: tm.lang.localized("Search.Result.Friend"))
            .frame(height: 37)

            UnifiedSearchResultFriendHorizontalListSection(friends: self.friends, unifiedSearchType: $unifiedSearchType)
                .padding(.top, 9)
                .padding(.bottom, 19)
        }
        .background(tm.theme.systemBackground)
        .cornerRadius(8)
        .padding(.horizontal, 8)
    }
}

#if DEBUG
struct UnifiedSearchResultFriendSection_Previews: PreviewProvider {
    static var previews: some View {
        UnifiedSearchResultFriendSection(friends: [FriendEntity(account: .init(signInId: "1", username: "chatmodule"))], unifiedSearchType: .constant(.FRIEND))
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
