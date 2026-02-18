//
//  ChatRoomWallpaperSelectionPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerChatRoomUI

enum WallpaperType: Int {
    case color, image
}

struct ChatRoomWallpaperSelectionPage: View {

    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) var presentationMode

    private let wallpaperType: WallpaperType
    @State var checked: Bool = false

    private var symbols = ["keyboard",
                           "hifispeaker.fill",
                           "printer.fill",
                           "tv.fill",
                           "desktopcomputer",
                           "headphones",
                           "tv.music.note",
                           "mic",
                           "plus.bubble",
                           "video"]

    private var colors: [Color] = [.yellow, .blue, .green]

    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    init(wallpaperType: WallpaperType) {
        self.wallpaperType = wallpaperType
    }

    var body: some View {
            ScrollView {
                LazyVGrid(columns: gridItemLayout, spacing: 3) {
                    ForEach((0...30), id: \.self) {
                        if wallpaperType == .color {
                            ChatWallpaperImageItemSection(color: colors[$0 % colors.count],
                                                          checked: checked,
                                                          onCheckChanged: onCheckedWallpaper(check:))
                                .frame(width: 123, height: 131)
                        } else {
                            ChatWallpaperImageItemSection(image: UIImage(systemName: symbols[$0 % symbols.count]),
                                                          checked: checked,
                                                          onCheckChanged: onCheckedWallpaper(check:))
                                .frame(width: 123, height: 131)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationTitle(getNavigationTitle())
            .navigationBarColor(backgroundColor: UIColor(appState.tm.theme.systemBackground),
                                tintColor: UIColor(appState.tm.theme.labelColorPrimary))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(appState.tm.theme.labelColorSecondary)
                    }

                }
            }
    }

    private func onCheckedWallpaper(check: Bool) {
        print(check)
    }

    private func getNavigationTitle() -> String {
        switch wallpaperType {
        case .color:
            return appState.tm.lang.localized("Wallpaper.BackgroundColor")
        case .image:
            return appState.tm.lang.localized("Wallpaper.BackgroundIllust")
        }
    }
}

struct ChatRoomWallpaperSelectionPage_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ChatRoomWallpaperSelectionPage(wallpaperType: .color)
            ChatRoomWallpaperSelectionPage(wallpaperType: .image)
        }
    }
}
