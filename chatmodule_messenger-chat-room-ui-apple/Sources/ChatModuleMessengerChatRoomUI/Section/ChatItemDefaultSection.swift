//
//  ChatItemDefaultSection.swift
//  ChatModuleMessengerChatRoomUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Chat Item Default Section
///
/// Chat prototype > 대화방 서랍
///
///
/// Usage :
///
///     ChatItemDefaultSection(subTitle1: "대화 게시판",
///                            trailingIcon: UIImage(systemName: "chevron.right"))
///
/// or
///
///     ChatItemDefaultSection(subTitle2: "대화 상대")
///
/// or
///
///     ChatItemDefaultSection(leadingIcon: UIImage(systemName: "photo"),
///                            subTitle2: "사진, 동영상",
///                            trailingIcon: UIImage(systemName: "chevron.right"))
///
/// or
///
///     ChatItemDefaultSection(model: AccountInfo(signInId: "",
///                                               username: "Nayana"),
///                            isMe: true)
///
public struct ChatItemDefaultSection: View {
    @EnvironmentObject var tm: ThemeManager

    var accountModel: AccountInfo?
    var leadingIcon: Image?
    var leadingIconTint: Color?
    var leadingIconBackground: Color?
    var subTitle1: String?
    var subTitle2: String?
    var trailingIcon: Image?
    var isMe: Bool = false

    /// Create ChatItemDefaultSection
    ///
    /// - Parameters:
    ///   - leadingIcon: leading icon image
    ///   - leadingIconTint: leading icon tint Color
    ///   - leadingIconBackground : leading icon background color
    ///   - subTitle1: sub title1 text
    ///   - subTitle2: sub title2 text
    ///   - trailingIcon: trailing icon image
    public init(leadingIcon: Image? = nil,
                leadingIconTint: Color? = nil,
                leadingIconBackground: Color? = nil,
                subTitle1: String? = nil,
                subTitle2: String? = nil,
                trailingIcon: Image? = nil) {

        self.leadingIcon = leadingIcon
        self.leadingIconTint = leadingIconTint
        self.leadingIconBackground = leadingIconBackground
        self.subTitle1 = subTitle1
        self.subTitle2 = subTitle2
        self.trailingIcon = trailingIcon

    }

    
    /// Create ChatItemDefaultSection with account info
    ///
    /// - Parameters:
    ///   - model: account info data (``AccountInfo``)
    ///   - isMe: is me
    public init(model: AccountInfo,
                isMe: Bool = false) {
        self.accountModel = model
        self.subTitle1 = model.username
        self.isMe = isMe
        
    }
    
    public var body: some View {
        ListItemDefaultHalfLeftIconComponent(leftIconBox: leftIcon,
                                             subTitle1: subTitle1View,
                                             subTitle2: subTitle2View,
                                             iconText: meBadge,
                                             rightIconBox: rightIcon)
            .listRowInsets(EdgeInsets())
    }
    
    @ViewBuilder
    private var subTitle1View: some View {
        if let subTitle1 = subTitle1 {
            Text(subTitle1)
                .font(tm.typo.headline)
                .foregroundColor(tm.theme.labelColorPrimary)
                .padding(.trailing, 16)
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var subTitle2View: some View {
        if let subTitle2 = subTitle2 {
            Text(subTitle2)
                .font(tm.typo.subheadline)
                .foregroundColor(tm.theme.labelColorPrimary)
                .padding(.trailing, 16)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    private var leftIcon: some View {
        if let accountModel = accountModel {
            Avatar(icon: Image.profileImage(nil) // accountModel.profileUrl
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundColor((leadingIconTint == nil && accountModel.profileUrl == nil) ?
                                     tm.theme.chatmoduleColor00 : leadingIconTint),
                   badge: EmptyView())
        } else if let leadingIcon = leadingIcon {
            
            if let leadingIconBackground = leadingIconBackground {
                ZStack {
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundColor(leadingIconBackground)
                    
                    
                    leadingIcon
                        .frame(width: 12, height: 12)
                        .foregroundColor(leadingIconTint)
                }
                .frame(width: 32, height: 32)
            } else {
                leadingIcon
                    .frame(width: 22, height: 22)
                    .font(.system(size: 17))
                    .foregroundColor(leadingIconTint)
            }
            
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    private var rightIcon: some View {
        if let trailingIcon = trailingIcon {
            trailingIcon
                .font(.system(size: 15))
                .frame(height: 18)
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var meBadge: some View {
        if isMe {
            HStack(spacing: 4) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(tm.theme.systemPurple)
                    .imageScale(.small)
                
                Text(tm.lang.localized("Chat.Drawer.IsMe"))
                    .font(tm.typo.subheadline)
                    .foregroundColor(tm.theme.systemPurple)
            }
        } else {
            EmptyView()
        }
    }
}

#if DEBUG
struct ChatItemDefaultSection_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ChatItemDefaultSection(subTitle1: "대화 게시판",
                                   trailingIcon: Image(systemName: "chevron.right"))
            Divider()

            ChatItemDefaultSection(subTitle2: "대화 상대")

            Divider()

            ChatItemDefaultSection(leadingIcon: Image(systemName: "photo"),
                                   subTitle2: "사진, 동영상",
                                   trailingIcon: Image(systemName: "chevron.right"))
            
            Divider()
            
            ChatItemDefaultSection(model: AccountInfo(signInId: "",
                                                      username: "Nayana"),
                                   isMe: true)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(ThemeManager())
    }
}
#endif
