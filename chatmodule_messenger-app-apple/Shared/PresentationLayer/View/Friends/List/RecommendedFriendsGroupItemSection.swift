//
//  RecommendedFriendsGroupItemSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerRelationshipFriendsUI

/// Recommended Friends Group Item Section
///
/// Friends prototype > Messenger 친구 목록
///
///
/// Usage:
///
///      RecommendedFriendsGroupItemSection(model: FriendInfo(...),
///                                         isChecked: false,
///                                         onCheckChanged: { ... })
///
public struct RecommendedFriendsGroupItemSection: View {
    @EnvironmentObject var tm: ThemeManager
    var count: Int
    var subTitle2: String?

    /// Create RecommendedFriendsGroupItemSection
    ///
    /// - Parameters:
    ///   - count: count of recommended friends
    public init(count: Int = 0) {
        self.count = count
    }

    public var body: some View {
        ListItemHalfMobileLeftIconComponent(
            leftIconBox: recommendedAvatar,
            subTitle1: tm.lang.localized("Friends.Recommended.Title"),
            subTitle2: tm.lang.localized("Friends.Recommended.SubTitle") + " \(count)",
            iconText: EmptyView(),
            rightIconBox: Image(systemName: "chevron.right")
                .font(.system(size: 15))
                .foregroundColor(tm.theme.labelColorPrimary))
        .frame(height: 57)
        .listRowInsets(EdgeInsets())
    }

    var recommendedAvatar: some View {
        Circle()
            .overlay(
                Image(systemName: "person.crop.circle.badge.questionmark")
                    .font(.system(size: 20))
                    .foregroundColor(.white)

            )
            .foregroundColor(tm.theme.systemPurple)
            .frame(width: 32, height: 32)
    }
}

#if DEBUG
struct RecommendedFriendsGroupItemSection_Previews: PreviewProvider {
    static let model = FriendInfo(account: .init(signInId: "0", username: "ChatModule"))

    static var previews: some View {
        VStack {
            RecommendedFriendsGroupItemSection(count: 99)
        }
        .environmentObject(ThemeManager())
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.light)

        VStack {
            RecommendedFriendsGroupItemSection(count: 99)
        }
        .environmentObject(ThemeManager())
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
}
#endif
