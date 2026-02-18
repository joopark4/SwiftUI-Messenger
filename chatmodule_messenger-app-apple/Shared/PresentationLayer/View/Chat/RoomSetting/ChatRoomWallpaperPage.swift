//
//  ChatRoomWallpaperPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerChatRoomUI

struct ChatRoomWallpaperPage: View {

    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) var presentationMode

    @State private var defaultBackgroundApply: Bool = false

    @State private var showImagePicker: Bool = false
    @State private var selectedImage: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary

    @State private var showColorBackground: Bool = false
    @State private var showIllustBackground: Bool = false

    private let viewModel: ChatRoomViewModel

    init(viewModel: ChatRoomViewModel = .init()) {
        self.viewModel = viewModel
    }

    var body: some View {
//        NavigationView {
            VStack {
                wallpaperPreview
                    .frame(width: 155, height: 200)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 32, trailing: 0))

                VStack {
                    titleText

                    selectedBackground

                    setDefaultBackground
                }

                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle(appState.tm.lang.localized("Wallpapers"))
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
//        }
    }

    private var wallpaperPreview: some View {
        ZStack(alignment: .topLeading) {
            appState.tm.theme.befamilySecondaryVariant

            Avatar(icon: Image.profileImage(nil)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundColor(appState.tm.theme.chatmoduleColor00),
                   badge: EmptyView())
                .padding(EdgeInsets(top: 20, leading: 8, bottom: 0, trailing: 0))

            appState.tm.theme.systemBackground
                .cornerRadius(8, corners: .topRight)
                .cornerRadius(8, corners: .bottomLeft)
                .cornerRadius(8, corners: .bottomRight)
                .frame(width: 73, height: 27)
                .padding(EdgeInsets(top: 32, leading: 48, bottom: 0, trailing: 0))

            appState.tm.theme.labelColorTertiary
                .frame(width: 64, height: 6)
                .padding(EdgeInsets(top: 38, leading: 52, bottom: 0, trailing: 0))

            appState.tm.theme.labelColorTertiary
                .frame(width: 23, height: 6)
                .padding(EdgeInsets(top: 48, leading: 52, bottom: 0, trailing: 0))

            appState.tm.theme.bubbleBgMine01
                .cornerRadius(8, corners: .topLeft)
                .cornerRadius(8, corners: .topRight)
                .cornerRadius(8, corners: .bottomLeft)
                .frame(width: 73, height: 27)
                .padding(EdgeInsets(top: 75, leading: 74, bottom: 0, trailing: 0))

            appState.tm.theme.labelColorTertiary
                .frame(width: 64, height: 6)
                .padding(EdgeInsets(top: 80, leading: 78, bottom: 0, trailing: 0))

            appState.tm.theme.labelColorTertiary
                .frame(width: 23, height: 6)
                .padding(EdgeInsets(top: 89, leading: 78, bottom: 0, trailing: 0))
        }
    }

    private var titleText: some View {
        SubTitleBar(subTitle: appState.tm.lang.localized("Wallpaper.Background.Select"))
            .font(.subheadline)
            .foregroundColor(appState.tm.theme.labelColorSecondary)
            .padding(.bottom, 10)
    }

    private var selectedBackground: some View {
        VStack(spacing: 0) {
            Button {
                showColorBackground.toggle()
            } label: {
                ChatListItemDefaultSection(subTitle1: appState.tm.lang.localized("Wallpaper.BackgroundColor"), subTitle2: nil)
            }
            .fullScreenCover(isPresented: self.$showColorBackground, onDismiss: {
                // dismiss
            }, content: {
                ChatRoomWallpaperSelectionPage(wallpaperType: .color)
            })
            .padding(.bottom, 25)

            Button {
                showIllustBackground.toggle()
            } label: {
                ChatListItemDefaultSection(subTitle1: appState.tm.lang.localized("Wallpaper.BackgroundIllust"), subTitle2: nil)
            }
            .fullScreenCover(isPresented: self.$showIllustBackground, onDismiss: {
                // dismiss
            }, content: {
                ChatRoomWallpaperSelectionPage(wallpaperType: .image)
            })
            .padding(.bottom, 25)

            Button {
                showImagePicker.toggle()
            } label: {
                ChatListItemDefaultSection(subTitle1: appState.tm.lang.localized("Chat.SelectChat.MultiRoomInfoEdit.Profile.Photo"),
                                           subTitle2: nil)
            }
            .fullScreenCover(isPresented: $showImagePicker, onDismiss: {
                // dismiss
            }, content: {
                ImagePicker(image: self.$selectedImage, videoUrl: .constant(nil),
                            isShown: self.$showImagePicker, sourceType: self.sourceType)
            })
            .padding(.bottom, 14)
        }
    }

    private var setDefaultBackground: some View {
        VStack(spacing: 0) {
            Divider().padding(.bottom, 17)

            Button {
                self.defaultBackgroundApply.toggle()
            } label: {
                ChatListItemHalfMobileSection(subTitle1: appState.tm.lang.localized("Wallpaper.Default.Apply"),
                                              buttonBox: Text(appState.tm.lang.localized("Apply"))
                                                .font(appState.tm.typo.footnote)
                                                .foregroundColor(appState.tm.theme.labelColorPrimary)
                                                .padding()
                                                .frame(width: 64, height: 36)
                                                .overlay(RoundedRectangle(cornerRadius: 4)
                                                            .stroke(appState.tm.theme.labelColorTertiary, lineWidth: 1)))
            }
            .actionSheet(isPresented: self.$defaultBackgroundApply) {
                ActionSheet(title: Text(""),
                            message: Text(appState.tm.lang.localized("Wallpaper.Default.Apply.Message")),
                            buttons: [.default(Text(appState.tm.lang.localized("Wallpaper.Default.Apply.Comfirm")),
                                               action: nil),
                                      .cancel(Text(appState.tm.lang.localized("Common.Cancel")))])
            }
            .onAppear {
                UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self])
                    .tintColor = UIColor(appState.tm.theme.labelColorPrimary)
            }
        }
    }
}

#if DEBUG
struct ChatRoomWallpaperPage_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomWallpaperPage()
            .environmentObject(AppState())
    }
}
#endif
