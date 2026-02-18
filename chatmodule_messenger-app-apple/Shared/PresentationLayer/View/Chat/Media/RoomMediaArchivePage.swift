//
//  RoomMediaArchivePage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerChatRoomUI

struct RoomMediaArchivePage: View {

    @EnvironmentObject var tm: ThemeManager
    @Environment(\.presentationMode) var presentationMode

    private let iconW: CGFloat = 28
    private let iconFontSize: CGFloat = 24

    private let contentsType: RoomArchiveContentsType = .ALBUM
    private let pageType: RoomArchivePageType = .LOCAL

    @State private var checkButtonDissable: Bool = true // 체크버튼 활성화
    @State private var selectCount = 6

    @State var forwardingModalAction: Bool = false
    @State var forwardingFullAction: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if pageType == .LOCAL {
                        ScrollView {
                            RoomMediaArchiveItemSection(pageType: .LOCAL,
                                                        mode: .All,
                                                        count: 0,
                                                        dataSize: 0,
                                                        onManagementClick: self.onManagementClick)
                                .padding(.bottom, 4)

                            ForEach(0..<5) {_ in
                                RoomMediaArchiveListSection(archiveDate: "2025-02-24",
                                                            checkedButtonDisable: $checkButtonDissable,
                                                            onPreviewClick: self.onPreviewClick)
                            }
                        }

                        if checkButtonDissable {
                            Spacer()
                            RoomFileArchiveBottomBarSection(type: .DRIVE, contentsType: contentsType)
                        }
                    } else {
                        ScrollView {
                            RoomMediaArchiveItemSection(pageType: .DRIVE,
                                                        mode: .All,
                                                        count: 0,
                                                        dataSize: 0,
                                                        onManagementClick: self.onManagementClick)
                                .padding(.bottom, 4)

                            ForEach(0..<5) {_ in
                                RoomMediaArchiveListSection(archiveDate: "2025-02-24",
                                                            checkedButtonDisable: $checkButtonDissable,
                                                            onPreviewClick: self.onPreviewClick)
                            }
                        }
                    }

                    if !checkButtonDissable {
                        RoomMediaArchiveBottomBarSection(onClick: onContentManage(type:))
                            .padding(.bottom, 34)
                    }
                }

                if forwardingModalAction {
                    forwardingView
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(tm.lang.localized("Chat.Drawer.Album"))
            .navigationBarColor(backgroundColor: UIColor(tm.theme.systemBackground),
                                tintColor: UIColor(tm.theme.labelColorPrimary))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(tm.typo.body)
                            .font(.system(size: 17))
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        checkButtonDissable.toggle()
                    } label: {
                        if checkButtonDissable {
                            Image(systemName: "checkmark")
                        } else {
                            HStack {
                                Text("\(selectCount) ")
                                    .foregroundColor(.purple)
                                Text(tm.lang.localized("Common.Deselect"))
                            }
                        }
                    }
                    .font(tm.typo.body)
                    .font(.system(size: 17))
                }
            }
            .fullScreenCover(isPresented: $forwardingFullAction) {
                ContentForwardingSelectionPage()
            }
        }
    }

    private var forwardingView: some View {
        VStack {
            Spacer()

            ContentForwardingSelectionBottomSection(forwardingModalAction: $forwardingModalAction,
                                                    forwardingFullAction: $forwardingFullAction)
        }
        .background(tm.theme.separatorColor)
    }
}

extension RoomMediaArchivePage {
    private func onManagementClick() {
        print(#function)
    }

    private func onPreviewClick() {
        print(#function)
    }

    private func onContentManage(type: ContentManageType) {
        switch type {
        case .DOWNLOAD:
            print("\(#function) : download")

        case .SHARE:
            forwardingModalAction = true

        case .TRASH:
            print("\(#function) : trash")
        }
    }
}

#if DEBUG
struct RoomMediaArchivePage_Previews: PreviewProvider {
    static var previews: some View {
        RoomMediaArchivePage()
    }
}
#endif
