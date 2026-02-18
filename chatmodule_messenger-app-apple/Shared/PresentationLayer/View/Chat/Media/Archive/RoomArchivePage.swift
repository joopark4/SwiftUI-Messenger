//
//  RoomArchivePage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerChatRoomUI

struct RoomArchivePage: View {

    @EnvironmentObject var tm: ThemeManager
    @Environment(\.presentationMode) var presentationMode

    private let filesSetCount: Int = 5
    private let contentsType: RoomArchiveContentsType = .LINK
    private let pageType: RoomArchivePageType = .DRIVE

    @State var selectedModeToggle: Bool = false
    @State var selectedDriveSearch: Bool = false
    @State var selectedCount: Int = 2

    var body: some View {
        NavigationView {
            ZStack {
                if pageType == .LOCAL {
                    localList
                } else {
                    driveList
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(self.getContentsTypeTitle())
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(tm.typo.body)
                            .font(.system(size: 17))
                            .foregroundColor(tm.theme.labelColorPrimary)
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    if pageType == .LOCAL {
                        selectedModeStatus
                    } else {
                        HStack {
                            if !selectedModeToggle {
                                Button {
                                    selectedDriveSearch.toggle()
                                } label: {
                                    Image(systemName: "magnifyingglass")
                                        .resizable()
                                        .font(.body)
                                        .font(.system(size: 17, weight: .regular))
                                        .foregroundColor(tm.theme.labelColorPrimary)
                                }
                            }

                            selectedModeStatus
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $selectedDriveSearch) {
                DriveSearchPage()
            }
        }
    }

    private func getContentsTypeTitle() -> String {
        switch self.contentsType {
        case .FILE:
            return tm.lang.localized("Chat.Drawer.File")
        case .LINK:
            return tm.lang.localized("Chat.Drawer.Link")
        case .ALBUM:
            return tm.lang.localized("Chat.Drawer.Album")
        }
    }

    private var selectedModeStatus: some View {
        VStack {
            Button {
                selectedModeToggle.toggle()
            } label: {
                if !selectedModeToggle {
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 19, height: 22)
                        .foregroundColor(filesSetCount == 0 ? tm.theme.labelColorTertiary : tm.theme.labelColorPrimary)
                } else {
                    if selectedCount > 0 {
                        Text("\(selectedCount) ")
                            .foregroundColor(tm.theme.chatmoduleColor00)
                        Text(tm.lang.localized("Deselect"))
                            .foregroundColor(tm.theme.labelColorPrimary)
                    } else {
                        Text(tm.lang.localized("Common.Cancel"))
                            .foregroundColor(tm.theme.labelColorPrimary)
                    }
                }
            }
            .font(.body)
            .font(.system(size: 17, weight: .regular))
        }
    }
}

extension RoomArchivePage {

    private var localList: some View {
        VStack {
            if filesSetCount == 0 {
                Spacer()
                RoomArchiveEmptyItemSection(contentsType: contentsType, pageType: pageType)
            } else {
                ScrollView {
                    if contentsType == .FILE {
                        RoomFileArchiveInfoItemSection(count: 7, size: "753MB")
                    }

                    ForEach(0..<filesSetCount) { i in
                        RoomArchiveListSection(contentsType: contentsType,
                                               hiddenCheckButton: false,
                                               date: "2025-02-0\(i)")
                    }
                }
            }

            Spacer()
            RoomFileArchiveBottomBarSection(type: .DRIVE, contentsType: contentsType)
        }
    }

    private var driveList: some View {
        VStack {
            if filesSetCount == 0 {
                Spacer()
                RoomArchiveEmptyItemSection(contentsType: contentsType, pageType: pageType)
                Spacer()
            } else {
                ScrollView {
                    RoomArchiveChatRoomTabSection()

                    if contentsType == .FILE {
                        RoomFileArchiveInfoItemSection(count: 7, size: "753MB")
                    }

                    ForEach(0..<filesSetCount) { i in
                        RoomArchiveListSection(contentsType: contentsType,
                                               hiddenCheckButton: false,
                                               date: "2025-02-0\(i)")
                    }
                }
            }

            if selectedModeToggle {
                Spacer()
                RoomFileArchiveBottomBarSection(type: .EDIT, contentsType: contentsType)
            }
        }
    }
}

struct RoomArchivePage_Previews: PreviewProvider {
    static var previews: some View {
        RoomArchivePage()
    }
}
