//
//  UnifiedSearchResultFriendItemSection.swift
//  ChatModuleMessengerRelationshipFriendsUI
//

import SwiftUI
import ChatModuleMessengerUI

public struct UnifiedSearchResultFriendItemSection: View {
    @EnvironmentObject var tm: ThemeManager
    private let account: AccountInfo?
    
    public init(account: AccountInfo? = nil) {
        self.account = account
    }
    
    public var body: some View {
        Button {
            //action
        } label: {
            HStack {
                let image = Avatar(icon: Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .foregroundColor(tm.theme.chatmoduleColor00), badge: EmptyView())
                
                AvatarGroup(icon: image)
                    .frame(width: 32, height: 32)
                
                Text(account?.username ?? "" )
                    .font(tm.typo.headline)
                    .foregroundColor(tm.theme.labelColorPrimary)
                    .padding(.leading, 16)
                
                Spacer()
                
            }
            .padding(.leading, 16)
        }
    }
}

#if DEBUG
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        UnifiedSearchResultFriendItemSection(account: AccountInfo(signInId: "0", username: "chatmodule"))
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
