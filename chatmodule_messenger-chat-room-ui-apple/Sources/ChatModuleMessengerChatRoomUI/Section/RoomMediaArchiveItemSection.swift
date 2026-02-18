//
//  RoomMediaArchiveItemSection.swift
//  ChatModuleMessengerChatRoomUI
//

import SwiftUI
import ChatModuleMessengerUI


/// Room MediaA rchive Item Section
///
/// Chat Room prototype > 사진, 동영상 관리 섹션
///
///
/// Usage:
///
///            RoomMediaArchiveItemSection(count: 7, dataSize: 35.5, onManagementClick: self.click)
///
public struct RoomMediaArchiveItemSection: View {

    @EnvironmentObject var tm: ThemeManager

    private let pageType: RoomArchivePageType
    private var mode: DriveMode
    private var count: Int
    private var dataSize: Float
    private let onManagementClick: (() -> Void)?
    @State private var manageButton: Bool = false

    public init(pageType: RoomArchivePageType = .LOCAL,
                mode: DriveMode = .All,
                count: Int,
                dataSize: Float,
                onManagementClick: (() -> Void)? = nil) {
        self.pageType = pageType
        self.mode = mode
        self.count = count
        self.dataSize = dataSize
        self.onManagementClick = onManagementClick
    }

    public var body: some View {

        if pageType == .LOCAL {
            SubTitleBar(title: String(format: tm.lang.localized("Chat.Contents.CountAndSize"), count, dataSize, "MB")) {
                Button(action: {
                    manageButton.toggle()
                }, label: {
                    Text(tm.lang.localized("Common.Management"))
                        .foregroundColor(.purple)
                        .font(tm.typo.subheadline)
                        .font(.system(size: 14))
                })
                    .alert(isPresented: $manageButton) {
                        Alert(title: Text(tm.lang.localized("ChatRoom.Media.PhotoMovie.Management.WarningTitle")),
                              message: Text(tm.lang.localized("ChatRoom.Media.PhotoMovie.Management.Warning")),
                              primaryButton: .default(Text(tm.lang.localized("Common.Cancel"))),
                              secondaryButton: .destructive(Text(tm.lang.localized("ChatRoom.Media.Content.All.Delete")), action: {
                            onManagementClick?()
                        }))
                    }
            }
        } else {
            switch mode {
            case .All:
                EmptyView()
            case .Important:
                SubTitleBar(title:"\(count)\(tm.lang.localized("Piece"))")
            case .User:
                SubTitleBar(title: String(format: tm.lang.localized("Chat.Contents.CountAndSize"), count, dataSize, "MB"))
            }
        }
    }
}

struct RoomMediaArchiveItemSection_Previews: PreviewProvider {
    static var previews: some View {
        RoomMediaArchiveItemSection(pageType: .LOCAL, mode: .All, count: 7, dataSize: 35.5, onManagementClick: nil)
    }
}
