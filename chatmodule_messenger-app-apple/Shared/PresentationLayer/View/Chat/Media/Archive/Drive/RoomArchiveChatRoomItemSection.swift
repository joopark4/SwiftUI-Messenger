//
//  RoomArchiveChatRoomItemSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

public enum AvatarImageType {
    case All, Important, User, Me, None
}

/// Room Archive Chat Room Item Section
///
/// 대화(Chat), 대화방 서랍, 톡서랍
///
///
/// Usage:
///
///        RoomArchiveChatRoomItemSection(name: "Name", underBarEnable: true, avatarType: .Me)
///
///
/// - Author: trowa
public struct RoomArchiveChatRoomItemSection: View {

    @EnvironmentObject var tm: ThemeManager

    let name: String
    let avatarType: AvatarImageType
    var underBarEnable: Bool

    public init(name: String, underBarEnable: Bool = false, avatarType: AvatarImageType = .User) {
        self.name = name
        self.underBarEnable = underBarEnable
        self.avatarType = avatarType
    }

    public var body: some View {
        FowardingItemComponent(image: topImage,
                               iconBox: EmptyView(),
                               name: nameText,
                               bottom: bottomBar)
    }

    @ViewBuilder
    private var topImage: some View {
        // 기본 아이템, 나, 그외 아이템에 대한 분기 처리 필요
        switch avatarType {
        case .All:
            ZStack {
                Circle().stroke(tm.theme.systemBackgroundSecondary, lineWidth: 2)

                AvatarGroup(icon: Image(systemName: "square.grid.2x2")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .font(.system(size: 26, weight: .regular))
                    .foregroundColor(tm.theme.labelColorSecondary))
            }
            .frame(width: 48, height: 48)

        case .Important:
            ZStack {
                Circle().stroke(tm.theme.systemBackgroundSecondary, lineWidth: 2)

                AvatarGroup(icon: Image(systemName: "bookmark")
                    .resizable()
                    .frame(width: 20, height: 30)
                    .font(.system(size: 26, weight: .regular))
                    .foregroundColor(tm.theme.labelColorSecondary))
            }
            .frame(width: 48, height: 48)

        case .User, .Me:
            AvatarGroup(icon: Image.profileImage()
                .resizable()
                .foregroundColor(tm.theme.chatmoduleColor00)
                .frame(width: 48, height: 48))

        case .None:
            AvatarGroup(icon: Image.profileImage()
                .resizable()
                .foregroundColor(tm.theme.chatmoduleColor00)
                .frame(width: 48, height: 48))
        }
    }

    @ViewBuilder
    private var nameText: some View {
        if avatarType == .Me {
            HStack(spacing: 0) {
                ZStack {
                    Circle().foregroundColor(Color.blue)
                        .frame(width: 12, height: 12)

                    Text(tm.lang.localized("Chat.Drawer.IsMe"))
                        .font(.system(size: 8))
                        .foregroundColor(.white)
                        .background(Color.blue)
                }
                .padding(.trailing, 2)

                Text(name)
                    .font(.footnote)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(tm.theme.labelColorPrimary)
            }
            .frame(height: 16)

        } else {
            switch avatarType {
            case .All:
                Text(tm.lang.localized("Common.All"))
                    .font(.footnote)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(tm.theme.labelColorPrimary)
                    .frame(height: 16)
            case .Important:
                Text(tm.lang.localized("Common.Important"))
                    .font(.footnote)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(tm.theme.labelColorPrimary)
                    .frame(height: 16)
            default:
                Text(name)
                    .font(.footnote)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(tm.theme.labelColorPrimary)
                    .frame(height: 16)
            }

        }
    }

    @ViewBuilder
    private var bottomBar: some View {
        if underBarEnable {
            tm.theme.labelColorPrimary
                .frame(width: 60, height: 2)
        } else {
            tm.theme.labelColorPrimary
                .opacity(0)
                .frame(width: 60, height: 2)
        }
    }
}

struct RoomLinkArchiveChatRoomItemSection_Previews: PreviewProvider {
    static var previews: some View {
        RoomArchiveChatRoomItemSection(name: "ERQDF")
        RoomArchiveChatRoomItemSection(name: "Name", underBarEnable: true, avatarType: .Me)
    }
}
