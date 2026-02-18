//
//  FriendsSelectionListItemSection.swift
//  ChatModuleMessengerChatRoomUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Friends Selection List Item Section
///
/// Chat Room prototype > Messenger 대화방 - 묶음 이미지 메시지 상세보기 - 전달 - 친구 - 전달 대상 선택
///
///
/// Usage:
///
///      FriendsSelectionListItemSection(model: AccountInfo(signInId: "",
///                                                            username: "Name 01"),
///                                      isChecked: false,
///                                      onCheckChanged: { ... })
///
public struct FriendsSelectionListItemSection: View {
    @EnvironmentObject var tm: ThemeManager
    var leftIcon: UIImage?
    var iconTintColor: Color?
    var subTitle1: String?
    var subTitle2: String?
    @State var isChecked: Bool?
    var onCheckChanged: ((Bool) -> Void)?

    /// Create FriendsSelectionListItemSection
    ///
    /// - Parameters:
    ///   - model: account info data ``AccountInfo``
    ///   - isChecked: check box initial value
    ///   - onCheckChanged: check box changed closure
    public init(model: AccountInfo,
                isChecked: Bool? = nil,
                onCheckChanged: ((Bool) -> Void)? = nil) {
        self.leftIcon = nil // model.profileImage
        self.subTitle1 = model.username
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
                    .foregroundColor(isChecked ? tm.theme.systemPurple : tm.theme.labelColorSecondary)
            }
        } else {
            EmptyView()
        }

    }
}

#if DEBUG
struct FriendsSelectionListItemSection_Previews: PreviewProvider {
    static var previews: some View {
        FriendsSelectionListItemSection(model: AccountInfo(signInId: "",
                                                           username: "Name 01"),
                                        isChecked: true,
                                        onCheckChanged: nil)
            .environmentObject(ThemeManager())
    }
}
#endif
