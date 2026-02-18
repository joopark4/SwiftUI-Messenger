//
//  FriendsSelectionListRowSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

/// Friends Selection List Item Section
///
/// Chat prototype > Messenger 대화 - 대화상대 선택
///
///
/// Usage:
///
///      FriendsSelectionListRowSection(model: AccountInfo(signInId: "",
///                                                            username: "Name 01"),
///                                         isChecked: false,
///                                         onCheckChanged: { ... })
///
public struct FriendsSelectionListRowSection: View {
    @EnvironmentObject var tm: ThemeManager
    var leftIcon: UIImage?
    var iconTintColor: Color?
    var subTitle1: String?
    var subTitle2: String?
    var isChecked: Bool
    var onCheckChanged: ((Bool) -> Void)

    /// Create FriendsSelectionListRowSection with ``AccountInfo``
    ///
    /// - Parameters:
    ///   - model: account info data ``AccountInfo``
    ///   - isChecked: check box initial value
    ///   - onCheckChanged: check box changed closure
    public init(model: AccountInfo,
                isChecked: Bool = false,
                onCheckChanged: @escaping ((Bool) -> Void)) {
        self.leftIcon = nil // model.profileImage
        self.subTitle1 = model.username
        self.subTitle2 = nil
        self.isChecked = isChecked
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
        Button {
            self.onCheckChanged(!self.isChecked)
        } label: {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundColor(isChecked ? tm.theme.systemPurple : tm.theme.labelColorSecondary)
        }

    }
}

#if DEBUG
struct FriendsSelectionListRowSection_Previews: PreviewProvider {
    static var previews: some View {
        FriendsSelectionListRowSection(model: AccountInfo(signInId: "",
                                                              username: "Name 01"),
                                           isChecked: true,
                                           onCheckChanged: { _ in
        })
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
