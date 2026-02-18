//
//  RoomArchiveEmptyItemSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerChatRoomUI

/// Room Archive Empty Item Section
///
/// 대화(Chat), 대화방 서랍, 톡서랍
///
///
/// - Author: trowa

public struct RoomArchiveEmptyItemSection: View {

    @EnvironmentObject var tm: ThemeManager

    let contentsType: RoomArchiveContentsType

    public init(contentsType: RoomArchiveContentsType = .FILE) {
        self.contentsType = contentsType
    }

    public var body: some View {
        ListItemHalfMobileCenterIcon(topIconBox: Image(systemName: "info.circle")
            .resizable()
            .frame(width: 36, height: 36)
            .foregroundColor(.purple),
                                     subTitle1: Text(self.getSubTitle1Message())
            .font(.headline)
            .font(.system(size: 17, weight: .semibold))
            .foregroundColor(tm.theme.labelColorPrimary),
                                     iconText: Text(getSubTitle2Message())
            .font(.subheadline)
            .font(.system(size: 15, weight: .medium))
            .multilineTextAlignment(.center)
            .foregroundColor(tm.theme.labelColorSecondary),
                                     bottomIconBox: EmptyView())
    }

    private func getSubTitle1Message() -> String {
        switch contentsType {
        case .FILE:
            return tm.lang.localized("ChatRoom.File.No.Contents")
        case .LINK:
            return tm.lang.localized("ChatRoom.Link.No.Contents")
        case .ALBUM:
            return tm.lang.localized("ChatRoom.Album.No.Contents")
        }
    }

    private func getSubTitle2Message() -> String {
        switch contentsType {
        case .FILE:
            return tm.lang.localized("ChatRoom.File.No.Infomation")
        case .LINK:
            return tm.lang.localized("ChatRoom.Link.No.Infomation")
        case .ALBUM:
            return tm.lang.localized("ChatRoom.Album.No.Infomation")
        }
    }
}

struct RoomFileArchiveEmptyItemSection_Previews: PreviewProvider {
    static var previews: some View {
        RoomArchiveEmptyItemSection(contentsType: .FILE)
    }
}
