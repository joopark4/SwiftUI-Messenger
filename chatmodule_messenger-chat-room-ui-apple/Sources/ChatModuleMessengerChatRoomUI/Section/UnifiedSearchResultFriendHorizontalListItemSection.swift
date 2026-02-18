//
//  UnifiedSearchResultFriendHorizontalListItemSection.swift
//  ChatModuleMessengerChatRoomUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Unified SearchResult FriendItem Section
///
///
public struct UnifiedSearchResultFriendHorizontalListItemSection: View {
    @EnvironmentObject var tm: ThemeManager

    private let account: AccountInfo?
    private let isMe: Bool // account에서 isMe 로 사용해야하지만 현재는 UI 구성으로 임시로 사용
    
    public init(account: AccountInfo? = nil, isMe: Bool) {
        self.account = account
        self.isMe = isMe
    }
    
    public var body: some View {
        FowardingItemComponent(image: avatarImage,
                               iconBox: EmptyView(),
                               name: avatarName,
                               bottom: EmptyView())
            .frame(width: 60)
    }
    
    @ViewBuilder
    private var avatarImage: some View {
        let image = Avatar(icon: Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .foregroundColor(tm.theme.chatmoduleColor00), badge: EmptyView())
        
        AvatarGroup(icon: image)
            .frame(width: 48, height: 48)
    }

    @ViewBuilder
    private var avatarName: some View {
        HStack(spacing:0) {
            if isMe {
                ZStack {
                    Circle().foregroundColor(tm.theme.systemIndigo)

                    Text(tm.lang.localized("Chat.Drawer.IsMe"))
                        .font(.system(size: 8))
                        .foregroundColor(.white)

                }
                .frame(width: 11, height: 11)
                .padding(2.5)
            }
            
            Text(account?.username ?? "")
                .font(tm.typo.footnote)
                .foregroundColor(tm.theme.labelColorPrimary)
        }
        .frame(height: 16)
    }
}

#if DEBUG
struct UnifiedSearchResultFriendItemSection_Previews: PreviewProvider {
    static var previews: some View {
        UnifiedSearchResultFriendHorizontalListItemSection(isMe: true)
            .environmentObject(ThemeManager())
    }
}
#endif
