//
//  ChatRoomNameSettingPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

struct ChatRoomNameSettingPage: View {
    @EnvironmentObject var tm: ThemeManager
    @Environment(\.presentationMode) var presentationMode

    private let inputLimit = 50
    @State var roomNameInput: String = ""

    private let roomName: String
    private let viewModel: ChatRoomViewModel
    init(viewModel: ChatRoomViewModel = .init()) {
        self.viewModel = viewModel
        self.roomName = viewModel.room.roomName ?? ""
    }

    var body: some View {
        VStack {
            roomSettingNameField

            Spacer()
        }
        .navigationTitle(Text(self.tm.lang.localized("Chat.ChatRoomSetting.RoomName")))
        .navigationBarBackButtonHidden(true)
        .toolbar {

            ToolbarItem(placement: .cancellationAction) {
                backArrow
            }

            ToolbarItem(placement: .primaryAction) {
                confirmButton
            }
        }
        .onAppear {
            self.roomNameInput = roomName
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

    private var confirmButton: some View {
        Button {
            viewModel.modifyRoomName(name: self.roomNameInput) {
                self.presentationMode.wrappedValue.dismiss()
            }
        } label: {
            Text(tm.lang.localized("Common.Ok"))
                .font(tm.typo.body)
                .foregroundColor(self.roomNameInput == roomName ? tm.theme.labelColorTertiary : tm.theme.labelColorPrimary)
        }
        .disabled(self.roomNameInput == roomName ? true : false)
    }

    private var roomSettingNameField: some View {
        FormField(inputText: $roomNameInput,
                  placeHoldText: roomName,
                  inputLimit: inputLimit)
        .padding(EdgeInsets(top: 35, leading: 16, bottom: 0, trailing: 16))
        .frame(height: 72)
    }

}

#if DEBUG
struct ChatRoomNameSettingPage_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomNameSettingPage()
            .environmentObject(ThemeManager())
    }
}
#endif
