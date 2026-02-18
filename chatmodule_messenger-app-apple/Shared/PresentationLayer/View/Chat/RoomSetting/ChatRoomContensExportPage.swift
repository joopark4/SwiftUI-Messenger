//
//  ChatRoomContensExportPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerChatRoomUI

struct ChatRoomContentsExportPage: View {
    @EnvironmentObject var tm: ThemeManager
    @Environment(\.presentationMode) var presentationMode

    private let viewModel: ChatRoomViewModel

    init(viewModel: ChatRoomViewModel = .init()) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 0) {
            exportOnlyText

            Divider()

            saveAll

            Spacer()
        }
        .navigationTitle(Text(tm.lang.localized("Chat.ChatRoomSetting.RoomContentsExport")))
        .navigationBarBackButtonHidden(true)
        .toolbar {

            ToolbarItem(placement: .cancellationAction) {
                backArrow
            }
        }
    }

    private var backArrow: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(self.tm.theme.labelColorSecondary)
        }
    }

    private var exportOnlyText: some View {
        Button {

        } label: {
            ChatSubTitleBarSection(subTitle1: tm.lang.localized("Chat.ChatRoomSetting.ContenExport.OnlyText"),
                                   subTitle2: tm.lang.localized("Chat.ChatRoomSetting.ContenExport.OnlyTextBody"))
        }
        .frame(height: 81)

    }

    private var saveAll: some View {
        Button {

        } label: {
                ChatSubTitleBarSection(subTitle1: tm.lang.localized("Chat.ChatRoomSetting.ContenExport.SaveAll"),
                                       subTitle2: tm.lang.localized("Chat.ChatRoomSetting.ContenExport.SaveAllBody"))
        }
        .padding(.top, 16)
    }
}

#if DEBUG
struct ChatRoomContentsExportPage_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomContentsExportPage()
            .environmentObject(ThemeManager())
    }
}
#endif
