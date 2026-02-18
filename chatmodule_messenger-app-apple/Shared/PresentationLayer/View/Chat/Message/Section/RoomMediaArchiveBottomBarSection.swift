//
//  RoomMediaArchiveBottomBarSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

enum ContentManageType {
    case DOWNLOAD, SHARE, TRASH
}

struct RoomMediaArchiveBottomBarSection: View {

    @EnvironmentObject var tm: ThemeManager

    private let iconW: CGFloat = 28
    private let iconFontSize: CGFloat = 24
    private let onClick: ((_ type: ContentManageType) -> Void)?

    private var fileLimit: Bool = false

    @State private var download: Bool = false
    @State private var trash: Bool = false
//    @State private var share: Bool = false

    init(onClick:((_ type: ContentManageType) -> Void)? = nil) {
        self.onClick = onClick
    }

    var body: some View {
        HStack {
            Button {
                // 20MB넘는 파일일 경우 띄우도록 변경 필요
                if fileLimit {
                    download.toggle()
                } else {
                    onClick?(.DOWNLOAD)
                }
            } label: {
                Image(systemName: "square.and.arrow.down")
                    .font(.system(size: iconFontSize))
            }
            .foregroundColor(tm.theme.labelColorPrimary)
            .frame(width: iconW, height: iconW)
            .padding(.leading, 24)
            .alert(isPresented: $download) {
                Alert(title: Text(""),
                          message: Text(tm.lang.localized("ChatRoom.Media.DownloadSize.Warning")),
                          primaryButton: .default(Text(tm.lang.localized("Common.Cancel"))),
                          secondaryButton: .default(Text(tm.lang.localized("Common.Ok")), action: {
                    onClick?(.DOWNLOAD)
                }))
            }

            Spacer()

            Button {
                onClick?(.SHARE)
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: iconFontSize))
            }
            .foregroundColor(tm.theme.labelColorPrimary)
            .frame(width: iconW, height: iconW)

            Spacer()

            Button {
                trash.toggle()
            } label: {
                Image(systemName: "trash")
                    .font(.system(size: iconFontSize))
            }
            .foregroundColor(tm.theme.labelColorPrimary)
            .frame(width: iconW, height: iconW)
            .padding(.trailing, 24)
            .alert(isPresented: $trash) {
                Alert(title: Text(""),
                      message: Text(tm.lang.localized("ChatRoom.MediaView.DeleteInfo")),
                      primaryButton: .default(Text(tm.lang.localized("Common.Cancel"))),
                      secondaryButton: .destructive(Text(tm.lang.localized("ChatRoom.MediaView.Delete")), action: {
                    onClick?(.TRASH)
                }))
            }
        }
        .frame(height: 44)
    }
}

struct RoomMediaArchiveBottomBarSection_Previews: PreviewProvider {
    static var previews: some View {
        RoomMediaArchiveBottomBarSection()
    }
}
