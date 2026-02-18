//
//  UnifiedSearchResultFriendHorizontalListSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerChatRoomUI

struct UnifiedSearchResultFriendHorizontalListSection: View {
    @EnvironmentObject var tm: ThemeManager
    @Binding var unifiedSearchType: UnifiedSearchType
    private let friends: [FriendEntity]

    init(friends: [FriendEntity], unifiedSearchType: Binding<UnifiedSearchType>) {
        self.friends = friends
        _unifiedSearchType = unifiedSearchType
    }

    var body: some View {
        HStack(spacing: 13) {
            if friends.count < 6 {

                ForEach(friends) { friend in
                    Button(action: {

                    }, label: {
                        let accountInfo = AccountInfo(signInId: "\(friend.id)", username: friend.name)
                        UnifiedSearchResultFriendHorizontalListItemSection(account: accountInfo, isMe: false)
                    })
                    .frame(width: 60, height: 73)
                }
            } else {
                ForEach(0..<4) { i in

                    Button(action: {

                    }, label: {
                        let accountInfo = AccountInfo(signInId: "\(friends[i].id)", username: friends[i].name)
                        UnifiedSearchResultFriendHorizontalListItemSection(account: accountInfo, isMe: false)
                    })
                    .frame(width: 60, height: 73)
                }

                Button(action: {
                    unifiedSearchType = .FRIEND
                }, label: {
                    moreButton
                })
            }
        }
    }

    private var moreButton: some View {
        FowardingItemComponent(image: moreAvata,
                               iconBox: EmptyView(),
                               name: mooreTitle,
                               bottom: EmptyView())
    }

    @ViewBuilder
    private var moreAvata: some View {
        let image = ZStack {
            Circle()
            .foregroundColor(tm.theme.fillColorTertiary)

            Text("+24")
                .font(tm.typo.subheadline)
                .foregroundColor(tm.theme.labelColorPrimary)
        }

        AvatarGroup(icon: image)
            .frame(width: 48, height: 48)
    }

    @ViewBuilder
    private var mooreTitle: some View {
        Text(tm.lang.localized("ChatRoom.MediaView.Showmore"))
            .font(tm.typo.footnote)
            .foregroundColor(tm.theme.labelColorPrimary)
            .frame(height: 16)
    }
}

#if DEBUG
struct UnifiedSearchResultFriendHorizontalListSection_Previews: PreviewProvider {
    static var previews: some View {
        UnifiedSearchResultFriendHorizontalListSection(friends: [FriendEntity()], unifiedSearchType: .constant(.FRIEND))
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
