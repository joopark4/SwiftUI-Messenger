//
//  FriendsGroupSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerRelationshipFriendsUI

/// Friends Group Section
///
/// Friends prototype > Messenger 친구 목록
///
///
/// Usage:
///
///     List {
///         FriendsGroupSection(users: [FriendInfo](),
///                             isExpand: .constant(true))
///     }
///
struct FriendsGroupSection: View {
    @EnvironmentObject var tm: ThemeManager

    @Binding var isExpand: Bool
    let searchText: String
    let users: [FriendInfo]
    var onClick: ((FriendInfo?) -> Void)?

    /// Create FriendsGroupSection
    ///
    /// - Parameters:
    ///   - users: user list (``FriendInfo``)
    ///   - searchText: search text
    ///   - isExpand: expand state
    ///   - onClick: onClick event
    init(users: [FriendInfo] = [],
         searchText: String = "",
         isExpand: Binding<Bool> = .constant(true),
         onClick: ((FriendInfo?) -> Void)? = nil) {
        self.users = users
        self.searchText = searchText
        _isExpand = isExpand
        self.onClick = onClick
    }

    var body: some View {
        Section(header: FriendsGroupTitleSection(title: headerTitle,
                                                 isExpand: $isExpand)) {
            if users.isEmpty {
                inviteView
            } else if isExpand {
                ForEach(searchResult) { user in
                    Button(action: {
                        self.onClick?(user)
                    }, label: {
                        FriendsGroupItemSection(model: user)
                    })
                    .listRowInsets(EdgeInsets())
                    .listRowSeparatorHidden()
                }
            }
        }
    }

    private var inviteView: some View {
        Button {
            onClick?(nil)
        } label: {
            UserProfileLeftIconItem(
                leftIcon: UIImage(systemName: "circle.fill")?
                    .withRenderingMode(.alwaysTemplate),
                iconTintColor: tm.theme.chatmoduleColor00,
                subTitle1: tm.lang.localized("Friends.Empty.Subtitle1"),
                subTitle2: tm.lang.localized("Friends.Empty.Subtitle2")
            )
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparatorHidden()
    }

    var headerTitle: String {
        return tm.lang.localized("Friends.Header.Friends") + " \(users.count)"
    }

    var searchResult: [FriendInfo] {
        return self.users.filter {
            searchText.isEmpty ||
            $0.name.localizedStandardContains(searchText)
        }
    }

}

struct FriendsGroupSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            FriendsGroupSection(users: [
                FriendInfo(account: .init(signInId: "0", username: "가나다")),
                FriendInfo(account: .init(signInId: "0", username: "라마바")),
                FriendInfo(account: .init(signInId: "0", username: "사아자"))
            ], isExpand: .constant(true))
        }
        .listStyle(.plain)
        .environmentObject(ThemeManager())
        .previewLayout(.sizeThatFits)
    }
}
