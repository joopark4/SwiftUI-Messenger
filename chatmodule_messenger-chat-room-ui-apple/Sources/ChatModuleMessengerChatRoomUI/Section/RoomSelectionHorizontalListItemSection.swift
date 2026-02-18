//
//  RoomSelectionHorizontalListItemSection.swift
//  ChatModuleMessengerChatRoomUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Room Selection Horizontal List Item Section
///
public struct RoomSelectionHorizontalListItemSection: View {

    @EnvironmentObject var tm: ThemeManager

    private let roomInfo: RoomInfo?

    // 테스트 코드
    private var img: UIImage = UIImage(systemName: "pin.circle.fill")!
    @State private var checked: Bool = true
    @State private var me: Bool = true
    @State private var hiddenBottomImage: Bool = true
    @State private var hiddenBottomView: Bool = true

    private let name: String = "ChatModule~~!!@@@!@###"
    private let bottomImage: UIImage = UIImage(systemName: "pin.fill")!
    private let bottomCount: Int = 7
    ////////

    public init(roomInfo: RoomInfo? = nil) {
        self.roomInfo = roomInfo
    }

    public var body: some View {
        Button {
            //action
        } label: {
            avatar
        }
        .frame(width: 60)
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
    }

    private var avatar: some View {
        Button {
            //action
        } label: {
            FowardingItemComponent(image: avatarImage,
                                   iconBox: avatarIcon,
                                   name: avatarName,
                                   bottom: avatarBottom)
        }

    }

    private var avatarImage: some View {
        ZStack(alignment: .bottomTrailing) {
            AvatarGroup(icon: Image.profileImage(img)
                            .resizable())
                .frame(width: 48, height: 48)

            avatarIcon
        }
    }

    @ViewBuilder
    private var avatarIcon: some View {
        if checked {
            ZStack {
                Circle()
                    .strokeBorder(Color.white.opacity(1), lineWidth: 1.0)
                    .background(Circle().foregroundColor(tm.theme.chatmoduleColor00))


                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .font(.system(size: 15))
            }
            .frame(width: 18, height: 18)
        } else {
            EmptyView()
        }
    }

    private var avatarName: some View {
        HStack(spacing:0) {
            if me {
                ZStack {
                    Circle().foregroundColor(Color.blue)
                        .frame(width: 12, height: 12)

                    Text(tm.lang.localized("Chat.Drawer.IsMe"))
                        .font(.system(size: 8))
                        .foregroundColor(.white)
                        .background(Color.blue)

                }
                .padding(.trailing, 2)
            }

            Text(name).font(tm.typo.footnote)
                .font(.system(size: 12))
                .foregroundColor(tm.theme.labelColorPrimary)
                .padding(0)
        }
        .frame(height: 16)
    }

    @ViewBuilder
    private var avatarBottom: some View {
        if hiddenBottomView {
            HStack(spacing: 0) {
                if hiddenBottomImage {
                    Image(uiImage: bottomImage)
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 11, height: 10)
                        .foregroundColor(tm.theme.labelColorTertiary)
                }

                Text("\(bottomCount)")
                    .font(.caption)
                    .font(.system(size: 11))
                    .foregroundColor(tm.theme.labelColorTertiary)
                    .frame(width: 11, height: 10)
            }
        } else {
            EmptyView()
        }
    }

}

struct RoomSelectionHorizontalListItemSection_Previews: PreviewProvider {
    static var previews: some View {
        RoomSelectionHorizontalListItemSection()
    }
}
