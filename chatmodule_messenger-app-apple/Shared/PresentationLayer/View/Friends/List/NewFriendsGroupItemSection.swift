//
//  NewFriendsGroupItemSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerRelationshipFriendsUI

/// New Friends Group Item Section
///
/// Friends prototype > Messenger 친구 목록
///
///
/// Usage:
///
///      NewFriendsGroupItemSection(model: FriendInfo(...),
///                                       isChecked: false,
///                                       onCheckChanged: { ... })
///
public struct NewFriendsGroupItemSection: View {
    @EnvironmentObject var tm: ThemeManager
    var leftIcon: UIImage?
    var iconTintColor: Color?
    var subTitle1: String?
    var subTitle2: String?
    @State var isChecked: Bool?
    var onCheckChanged: ((Bool) -> Void)?

    /// Create NewFriendsGroupItemSection
    ///
    /// - Parameters:
    ///   - model: user profile data (``FriendInfo``)
    ///   - isChecked: check box initial value
    ///   - onCheckChanged: check box changed closure
    public init(model: FriendInfo,
                isChecked: Bool? = nil,
                onCheckChanged: ((Bool) -> Void)? = nil) {
        self.leftIcon = nil // model.account.profileUrl
        self.subTitle1 = model.name
        self.subTitle2 = nil
        _isChecked = State(initialValue: isChecked)
        self.onCheckChanged = onCheckChanged
    }

    public var body: some View {
        ListItemHalfMobileLeftIconComponent(
            leftIconBox: Avatar(icon: Image.profileImage(self.leftIcon)
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .foregroundColor((iconTintColor == nil && leftIcon == nil) ?
                                                     tm.theme.chatmoduleColor00 : iconTintColor),
                                badge: EmptyView()),
            subTitle1: self.subTitle1,
            subTitle2: self.subTitle2,
            iconText: EmptyView(),
            rightIconBox: checkBox)
            .frame(height: 57)
            .listRowInsets(EdgeInsets())
    }

    @ViewBuilder
    private var checkBox: some View {
        if let isChecked = self.isChecked {
            Button {
                self.isChecked?.toggle()
                self.onCheckChanged?(isChecked)
            } label: {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(self.tm.theme.systemPurple)
            }
        } else {
            EmptyView()
        }

    }
}

#if DEBUG
struct NewFriendsGroupItemSection_Previews: PreviewProvider {
    static let model = FriendInfo(account: .init(signInId: "0", username: "ChatModule"))

    static var previews: some View {
        VStack {
            NewFriendsGroupItemSection(model: model)
        }
        .environmentObject(ThemeManager())
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.light)

        VStack {
            NewFriendsGroupItemSection(model: model)
        }
        .environmentObject(ThemeManager())
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
}
#endif
