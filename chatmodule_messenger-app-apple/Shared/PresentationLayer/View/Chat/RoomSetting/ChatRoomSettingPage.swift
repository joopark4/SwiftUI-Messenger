//
//  ChatRoomSettingPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerChatRoomUI

struct ChatRoomSettingPage: View {
    @EnvironmentObject var tm: ThemeManager

    @State var profileOptionAction: Bool = false
    @State var profileImagePickerAction: Bool = false
    @State var removeAllAction: Bool = false
    @State var leaveRoomAction: Bool = false

    @State var profileImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    @State private var sourceType: UIImagePickerController.SourceType = .camera

    @ObservedObject private var viewModel: ChatRoomViewModel

    init(viewModel: ChatRoomViewModel = .init()) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                roomSettingIconButton

                roomName

                roomSetting

                roomManage

                roomLeave

                Spacer()
            }
            .navigationTitle(Text(tm.lang.localized("Chat.ChatRoomSetting")))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarColor(backgroundColor: UIColor(tm.theme.systemBackground),
                                tintColor: UIColor(tm.theme.labelColorPrimary))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    closeButton
                }
            }
            .actionSheet(isPresented: $removeAllAction) {
                ActionSheet(title: Text(""), message: Text(tm.lang.localized("Chat.ChatRoomSetting.RoomRemoveAll.Message")), buttons: [
                  .destructive(Text(tm.lang.localized("Chat.ChatRoomSetting.RoomRemoveAll")),
                           action: {
                               viewModel.deleteAllMessage()
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
        .alert(isPresented: $leaveRoomAction) {
            Alert(title: Text(tm.lang.localized("Chat.Drawer.Leave.Title")),
                  message: Text(tm.lang.localized("Chat.Drawer.Leave.Description")),
                  primaryButton: .default(Text(tm.lang.localized("Common.Cancel"))),
                  secondaryButton: .destructive(Text(tm.lang.localized("Common.Delete")), action: {
                self.viewModel.leaveChatRoom {
                    dismissToRootView()
                }
            }))
        }
    }

    private var closeButton: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark")
                .foregroundColor(self.tm.theme.labelColorPrimary)
        }
    }

    private var roomSettingIconButton: some View {
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
                if viewModel.room.roomType == .SINGLE {
                    ChatRoomAvatarSection(roomInfo: viewModel.room)
                        .padding(.top, 18)
                } else {
                    ChatRoomAvatarSection(roomInfo: viewModel.room, buttonEnabled: true)
                        .padding(.top, 18)
                }
            }
        }
        .disabled(viewModel.room.roomType == .SINGLE ? true : false)
    }

    private var roomName: some View {
        // 대화방 이름
        VStack {
            NavigationLink(destination: {
                ChatRoomNameSettingPage(viewModel: viewModel)
            }, label: {
                ChatListItemDefaultSection(subTitle1: tm.lang.localized("Chat.ChatRoomSetting.RoomName"),
                                           subTitle2: viewModel.room.roomName)
            })
            .padding(.top, 18)

            divider
        }
    }

    private var roomSetting: some View {
        VStack(spacing: 0) {
            ChatSubTitleBarSection(subTitle2: tm.lang.localized("Chat.ChatRoomSetting"))

            let button = Button(action: {

            }, label: {
                Text("색상")
                    .foregroundColor(.white)
            })
            .frame(width: 56, height: 36)
            .background(tm.theme.befamilyBackground01Light)
            .cornerRadius(4)

            // 대화방 배경화면
            NavigationLink(destination: {
                ChatRoomWallpaperPage(viewModel: viewModel)
            }, label: {
                ChatListItemHalfMobileSection(subTitle1: tm.lang.localized("Chat.ChatRoomSetting.CurrentRoomWallPaper"), buttonBox: button)
            })
                .frame(height: 61)

            // 대화방 알림음
            NavigationLink(destination: {
                ChatRoomTextToneSettingPage(viewModel: viewModel)
            }, label: {
                ChatListItemDefaultSection(subTitle1: tm.lang.localized("Chat.ChatRoomSetting.CurrentRoomTone"), subTitle2: "챗모듈")
            })
            .frame(height: 47)

            divider
        }
        .padding(.top, 16)
    }

    private var roomManage: some View {
        VStack(spacing: 0) {

            ChatSubTitleBarSection(subTitle2: tm.lang.localized("Chat.ChatRoomSetting.RoomControl"))

            // 대화내용 모두 삭제
            Button(action: {
                removeAllAction.toggle()
            }, label: {
                ChatListItemDefaultSection(subTitle1: tm.lang.localized("Chat.ChatRoomSetting.RoomRemoveAll"))
            })
            .frame(height: 47)

            // 대화내용 내용 내보내기
            NavigationLink(destination: {
                ChatRoomContentsExportPage(viewModel: viewModel)
            }, label: {
                ChatListItemDefaultSection(subTitle1: tm.lang.localized("Chat.ChatRoomSetting.RoomContentsExport"))
            })
            .frame(height: 47)

            divider
        }
        .padding(.top, 16)
    }

    private var roomLeave: some View {
        VStack(spacing: 0) {
            Button(action: {
                leaveRoomAction = true
            }, label: {
                Text(tm.lang.localized("Chat.ChatRoomSetting.RoomLeave"))
                    .font(tm.typo.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(tm.theme.systemPink)
            })
            .frame(width: 342, height: 42)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(tm.theme.systemGray, lineWidth: 1)
            )
            .padding(.top, 16)

            if viewModel.room.roomType == .MULTI {
                Button(action: {

                }, label: {
                    Text(tm.lang.localized("Chat.ChatRoomSetting.RoomDenial"))
                        .font(tm.typo.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(tm.theme.systemPink)
                })
                .frame(width: 342, height: 42)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(tm.theme.systemGray, lineWidth: 1)
                )
                .padding(.top, 16)
            }
        }
    }

    private var divider: some View {
        Divider()
            .padding([.leading, .trailing], 16)
    }
}

#if DEBUG
struct ChatRoomSettingPage_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomSettingPage()
            .environmentObject(ThemeManager())

    }
}
#endif
