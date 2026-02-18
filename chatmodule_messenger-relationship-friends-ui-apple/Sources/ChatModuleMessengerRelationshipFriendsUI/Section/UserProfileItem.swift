//
//  UserProfileItem.swift
//  ChatModuleMessengerRelationshipFriendsUI
//

import SwiftUI
import ChatModuleMessengerUI

/// User Profile Left Icon Item
///
/// Friends prototype > Messenger 친구 목록
///
///
/// Usage:
///
///      UserProfileLeftIconItem(model: FriendInfo(...),
///                              isChecked: false,
///                              onCheckChanged: { ... })
///
/// or
///
///      UserProfileLeftIconItem(leftIcon: nil,
///                              subTitle1: "친구 목록이 비어 있습니다.",
///                              subTitle2: "\"+\" 버튼을 사용하여 새 친구 추가")
///
public struct UserProfileLeftIconItem: View {
    @EnvironmentObject var tm: ThemeManager
    var leftIcon: UIImage?
    var iconTintColor: Color?
    var subTitle1: String?
    var subTitle2: String?
    @State var isChecked: Bool?
    var onCheckChanged: ((Bool) -> Void)?

    /// Create UserProfileLeftIconItem with ``FriendInfo``
    ///
    /// - Parameters:
    ///   - model: user profile data
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

    /// Create UserProfileLeftIconItem
    ///
    /// - Parameters:
    ///   - leftIcon: left icon image
    ///   - iconTintColor: icon tint color
    ///   - subTitle1: sub title1 text
    ///   - subTitle2: sub title2 text
    public init(leftIcon: UIImage? = nil,
                iconTintColor: Color? = nil,
                subTitle1: String? = nil,
                subTitle2: String? = nil) {
        self.leftIcon = leftIcon
        self.iconTintColor = iconTintColor
        self.subTitle1 = subTitle1
        self.subTitle2 = subTitle2
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

/// User Profile Right Icon Item
///
/// Friends prototype > Messenger 친구 목록
///
///
/// Usage:
///
///      UserProfileRightIconItem(model: AccountInfo(...))
///
public struct UserProfileRightIconItem: View {
    @EnvironmentObject var tm: ThemeManager
    let model: AccountInfo

    /// Create UserProfileRightIconItem
    ///
    /// - Parameters:
    ///   - model: user profile data (``AccountInfo``)
    public init(model: AccountInfo) {
        self.model = model
    }

    public var body: some View {
        ListItemMobile(
            subTitle1: self.model.username,
            rightIconBox: Avatar(icon: Image.profileImage(/*model.account.profileUrl*/)
                                    .resizable()
                                    .foregroundColor(tm.theme.chatmoduleColor00)
                                    .frame(width: 48, height: 48),
                                 badge: EmptyView())
            .frame(height: 73)
            .listRowInsets(EdgeInsets()))
    }
}

/// User Profile Center Icon Item
///
/// Friends prototype > Messenger 친구 프로필, Messenger 친구 목록 - 연락처로 추가
///
///
/// Usage:
///
///      UserProfileCenterIconItem(model: FriendInfo(...),
///                                buttonText: "button text",
///                                renameEnabled: true,
///                                onRenameClick: self.func1,
///                                onButtonClick: self.func2)
///                                .sheet(isPresented: self.$presention) {
///                                        // dismiss
///                                } content: {
///                                        EditFriendNamePage(editInput: "Input", friendsSetName: "BO")
///                                }
///
public struct UserProfileCenterIconItem: View {

    @EnvironmentObject var tm: ThemeManager

    let model: FriendInfo
    let subTitle: String?
    let iconText: String?
    let inlineContent: UIImage?
    let buttonText: String?
    let renameEnabled: Bool

    var onRenameClick: (() -> Void)?
    var onButtonClick: (() -> Void)?

    /// Create UserProfileLeftIconItem
    ///
    /// - Parameters:
    ///   - model: friend data (``FriendInfo``)
    ///   - subtitle: ListItemHalfMobileCenterIcon.subTitle2 Text
    ///   - iconText: ListItemHalfMobileCenterIcon.iconText Text
    ///   - inlineContent: ListItemHalfMobileCenterIcon.iconText Image
    ///   - buttonText: ListItemHalfMobileCenterIcon.bottomIconBox Text
    ///   - renameEnabled: ListItemHalfMobileCenterIcon.subTitle1 Enable
    ///   - onRenameClick: ListItemHalfMobileCenterIcon.subTitle1 Click Event
    ///   - onButtonClick: ListItemHalfMobileCenterIcon.bottomIconBox Click Event
    public init(model: FriendInfo,
                subTitle: String? = nil,
                iconText: String? = nil,
                inlineContent: UIImage? = nil,
                buttonText: String? = nil,
                renameEnabled: Bool = false,
                onRenameClick: (() -> Void)? = nil,
                onButtonClick: (() -> Void)? = nil) {
        self.model = model
        self.subTitle = subTitle
        self.iconText = iconText
        self.inlineContent = inlineContent
        self.buttonText = buttonText
        self.renameEnabled = renameEnabled
        self.onRenameClick = onRenameClick
        self.onButtonClick = onButtonClick
    }

    public var body: some View {
        ListItemHalfMobileCenterIcon(
            topIconBox: Avatar(icon: Image.profileImage(/*model.account.profileUrl*/)
                                .resizable()
                                .foregroundColor(tm.theme.chatmoduleColor00)
                                .frame(width: 96, height: 96),
                               badge: EmptyView()),
            subTitle1: subTitleView,
            subTitle2: subTitle,
            iconText: iconTextView,
            bottomIconBox: bottomButtonView
        )
    }

    @ViewBuilder
    private var iconTextView: some View {
        if let iconText = iconText, let contentText = inlineContent {
            HStack {
                Image.profileImage(contentText)
                    .resizable()
                    .frame(width: 14, height: 14)
                    .foregroundColor(tm.theme.systemPurple)
                Text(iconText)
                    .font(.subheadline)
                    .foregroundColor(tm.theme.labelColorSecondary)
            }
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    private var bottomButtonView: some View {
        if let buttonText = buttonText {
            Button(action: {
                onButtonClick?()
            }, label: {
                Text(buttonText)
                    .font(.headline)
                    .foregroundColor(tm.theme.systemBackground)

            })
            .frame(width: 94, height: 42)
            .background(tm.theme.systemPurple)
            .cornerRadius(8)
        } else {
            EmptyView()
        }
    }

    private var subTitleView: some View {
        Button(action: {
            onRenameClick?()
        }, label: {
            Text(model.name)
                .font(.headline)
                .foregroundColor(tm.theme.labelColorPrimary)

            if renameEnabled {
                Image(systemName: "pencil")
                    .foregroundColor(tm.theme.labelColorSecondary)
            }
        })
        .disabled(!renameEnabled)
    }
}

#if DEBUG
struct UserProfileItem_Previews: PreviewProvider {
    static let account = AccountInfo(signInId: "0", username: "ChatModule")
    static let friend = FriendInfo(account: account)

    static var previews: some View {
        VStack {
            UserProfileLeftIconItem(leftIcon: nil,
                                    subTitle1: "친구 목록이 비어 있습니다.",
                                    subTitle2: "\"+\" 버튼을 사용하여 새 친구 추가")
            UserProfileLeftIconItem(model: friend)
            UserProfileRightIconItem(model: account)
        }
        .environmentObject(ThemeManager())
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.light)

        VStack {
            UserProfileLeftIconItem(leftIcon: nil,
                                    subTitle1: "친구 목록이 비어 있습니다.",
                                    subTitle2: "\"+\" 버튼을 사용하여 새 친구 추가")
            UserProfileLeftIconItem(model: friend)
            UserProfileRightIconItem(model: account)
        }
        .environmentObject(ThemeManager())
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
}
#endif
