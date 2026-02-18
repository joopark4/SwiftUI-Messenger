//
//  RoomFileArchiveBottomBarSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerChatRoomUI

enum FileBottomBarType {
    case DRIVE, EDIT
}

struct RoomFileArchiveBottomBarSection: View {

    @EnvironmentObject var tm: ThemeManager

    @State var type: FileBottomBarType
    @State var deleteButton: Bool = false
    @State var contentsType: RoomArchiveContentsType

    init(type: FileBottomBarType = .DRIVE, contentsType: RoomArchiveContentsType = .FILE) {
        self.type = type
        self.contentsType = contentsType
    }

    var body: some View {
        ZStack {
            tm.theme.systemBackgroundSecondary
                .edgesIgnoringSafeArea(.bottom)
                .frame(height: 44)

            HStack {
                if type == .EDIT {
                    Button {
                        // 전달하기 화면 띄우기
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(tm.theme.labelColorPrimary)
                            .font(.system(size: 24, weight: .regular))
                            .frame(width: 28, height: 28)
                    }
                    .padding(.leading, 24)

                    Spacer()

                    Button {
                        deleteButton.toggle()
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(tm.theme.labelColorPrimary)
                            .font(.system(size: 24, weight: .regular))
                            .frame(width: 28, height: 28)
                    }
                    .padding(.trailing, 24)
                    .alert(isPresented: $deleteButton) {
                       Alert(title: Text(""),
                             message: Text(getDeleteMessage()),
                              primaryButton: .cancel(),
                             secondaryButton: .destructive(Text(tm.lang.localized("Common.Delete")),
                                                           action: {
                           self.deleteSelectedContents()
                       }))
                    }
                } else {
                    Button {
                        // 톡서랍으로 이동
                    } label: {
                        Label(tm.lang.localized("GoToTalkDrive"), systemImage: "tray.full.fill")
                            .font(.callout)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(tm.theme.labelColorPrimary)
                    }
                }
            }
        }
    }

    private func getDeleteMessage() -> String {
        switch self.contentsType {
        case .FILE:
            return tm.lang.localized("ChatRoom.File.SelectedDelete")
        case .LINK:
            return tm.lang.localized("ChatRoom.Link.SelectedDelete")
        case .ALBUM:
            return tm.lang.localized("ChatRoom.Album.SelectedDelete")
        }
    }

    private func deleteSelectedContents() {
        Log.debug(#function)
    }
}

struct RoomFileArchiveBottomBarSection_Previews: PreviewProvider {
    static var previews: some View {
        RoomFileArchiveBottomBarSection()
    }
}
