//
//  GroupChatRoomSettingPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerChatRoomUI
import Photos

struct GroupChatRoomSettingPage: View {
    @EnvironmentObject var tm: ThemeManager
    @Environment(\.presentationMode) var presentationMode

    private let inputLimit = 50
    @State var roomNameInput: String = ""
    @State var profileOptionAction: Bool = false
    @State var profileImagePickerAction: Bool = false
    @State var profileImage: UIImage?

    @State private var sourceType: UIImagePickerController.SourceType = .camera

    private var placeholder = "ChatModule 04, ChatModule 05, ChatModule 06"
    private let viewModel: ChatRoomListViewModel

    init(viewModel: ChatRoomListViewModel = .init()) {
        self.viewModel = viewModel
    }

    var body: some View {
            VStack {
                roomSttingIconButton

                roomSettingNameField

                roomSettingInfo

                Spacer()
            }
            .navigationTitle(Text(self.tm.lang.localized("Chat.SelectChat.MultiRoomInfoEdit")))
            .navigationBarBackButtonHidden(true)
            .toolbar {

                ToolbarItem(placement: .cancellationAction) {
                    backArrow
                }

                ToolbarItem(placement: .primaryAction) {
                    confirmButton
                }
            }
            .actionSheet(isPresented: $profileOptionAction) {
                ActionSheet(title: Text(""), message: Text(self.tm
                                                            .lang
                                                            .localized("Chat.SelectChat.MultiRoomInfoEdit.Profile.Message")), buttons: [
                  .default(Text(tm.lang.localized("Chat.SelectChat.MultiRoomInfoEdit.Profile.Photo")),
                          action: {
                              profileImagePickerAction.toggle()
                              sourceType = .photoLibrary
                        }),
                  .default(Text(tm.lang.localized("Chat.SelectChat.MultiRoomInfoEdit.Profile.Camera")),
                           action: {
                               profileImagePickerAction.toggle()
                               sourceType = .camera
                            }),
                  .cancel(Text(tm.lang.localized("Common.Cancel"))
                            )])

            }
            .fullScreenCover(isPresented: $profileImagePickerAction) {
                ImagePicker(image: self.$profileImage, videoUrl: .constant(nil),
                            isShown: self.$profileImagePickerAction, sourceType: self.sourceType)
            }
            .onAppear {
                UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self])
                    .tintColor = UIColor(tm.theme.labelColorPrimary)
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
            // 그룹대화방 정보 설정 확인
            self.viewModel.createChatRoom(roomName: roomNameInput.isEmpty ?
                                          placeholder : roomNameInput) { _ in
                self.dismissRootView()
            }
        } label: {
            Text(tm.lang.localized("Common.Ok"))
                .font(tm.typo.body)
                .foregroundColor(tm.theme.labelColorPrimary)
        }
    }

    private var roomSttingIconButton: some View {
        Button {
            // 앨범 사진 선택 팝업
            // 사진 촬영 팝업
            profileOptionAction.toggle()
        } label: {
            if let profileImage = profileImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .mask(Circle())

            } else {
                let roomInfo = ChatRoomEntity(roomId: 0,
                                              isNotReceiveNotification: true,
                                              unreadCount: 3,
                                              lastMessage: "blahblahblah",
                                              lastMessageDate: "2025. 02. 09",
                                              memberCount: 4,
                                              roomName: "Name1, Name2, Name3, Name4")
                ChatRoomAvatarSection(roomInfo: roomInfo, buttonEnabled: true)
                .padding(.top, 18)
            }
        }
    }

    private var roomSettingNameField: some View {
        FormField(inputText: $roomNameInput,
                  placeHoldText: placeholder,
                  inputLimit: inputLimit)
        .padding(EdgeInsets(top: 35, leading: 16, bottom: 0, trailing: 16))
    }

    private var roomSettingInfo: some View {
        Text(tm.lang.localized("Chat.SelectChat.MultiRoomInfoEdit.InfoText"))
            .font(tm.typo.body)
            .foregroundColor(tm.theme.labelColorSecondary)
            .padding(16)
    }

    private func dismissRootView() {
        UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true)
    }
}

#if DEBUG
struct MultiRoomInfoEditPage_Previews: PreviewProvider {
    static let tm = ThemeManager(theme: Theme(types: .basic),
                          lang: Language(types: .english),
                          typo: Typography(types: .basic))

    static var previews: some View {
        GroupChatRoomSettingPage()
            .environmentObject(tm)
    }
}
#endif
