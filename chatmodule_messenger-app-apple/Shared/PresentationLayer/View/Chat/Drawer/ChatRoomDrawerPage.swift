//
//  ChatRoomDrawerPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerChatRoomUI
import ChatModuleMessengerRelationshipFriendsUI

struct ChatRoomDrawerPage: View {
    @EnvironmentObject var tm: ThemeManager
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.isPreview) var isPreview

    @State var chatMediaViewAction: Bool = false
    @State var chatMediaArchiveAction: Bool = false
    @State var roomSettingAction: Bool = false
    @State var leaveRoomAction: Bool = false
    @State var inviteRoomAction: Bool = false

    private let viewModel: ChatRoomViewModel

    init(viewModel: ChatRoomViewModel = .init()) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                List {
                    Button {
                        self.chatMediaArchiveAction.toggle()
                    } label: {
                        ChatItemDefaultSection(leadingIcon: Image(systemName: "photo"),
                                               leadingIconTint: tm.theme.labelColorPrimary,
                                               subTitle2: tm.lang.localized("Chat.Drawer.Album"),
                                               trailingIcon: Image(systemName: "chevron.right"))
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparatorHidden()
                    .frame(height: 38)

                    if !isPreview {
                        RoomMediaHorizontalListSection {
                            debugLog()
                            self.chatMediaViewAction.toggle()
                        }
                        .listRowInsets(EdgeInsets())
                        .padding(.horizontal, 16)
                    }

                    ChatItemDefaultSection(leadingIcon: Image(systemName: "folder"),
                                           leadingIconTint: tm.theme.labelColorPrimary,
                                           subTitle2: tm.lang.localized("Chat.Drawer.File"),
                                           trailingIcon: Image(systemName: "chevron.right"))
                        .listRowSeparatorHidden()
                        .frame(height: 38)

                    ChatItemDefaultSection(leadingIcon: Image(systemName: "link"),
                                           leadingIconTint: tm.theme.labelColorPrimary,
                                           subTitle2: tm.lang.localized("Chat.Drawer.Link"),
                                           trailingIcon: Image(systemName: "chevron.right"))
                        .frame(height: 38)

                    ChatItemDefaultSection(subTitle1: tm.lang.localized("Chat.Drawer.Music"),
                                           trailingIcon: Image(systemName: "chevron.right"))
                        .frame(height: 47)

                    ChatItemDefaultSection(subTitle1: tm.lang.localized("Chat.Drawer.Board"),
                                           trailingIcon: Image(systemName: "chevron.right"))
                        .frame(height: 47)

                    ChatItemDefaultSection(subTitle2: tm.lang.localized("Chat.Drawer.Member"))
//                        .listRowSeparatorHidden()
                        .frame(height: 32)

                    Button {
                        self.inviteRoomAction.toggle()
                    } label: {
                        ChatItemDefaultSection(leadingIcon: Image(systemName: "plus"),
                                               leadingIconTint: tm.theme.systemPurple,
                                               leadingIconBackground: tm.theme.fillColorPrimary,
                                               subTitle1: tm.lang.localized("Chat.Drawer.Member.Invite"))

                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparatorHidden()
                    .frame(height: 42)

                    ChatItemDefaultSection(model: AccountEntity(signInId: "",
                                                              username: "Nayana"),
                                           isMe: true)
                        .frame(height: 42)

                    ChatItemDefaultSection(model: AccountEntity(signInId: "",
                                                              username: "Name 01"))
                        .frame(height: 42)
                }
                .listStyle(.plain)

                ZStack {
                    tm.theme.systemBackgroundSecondary
                        .ignoresSafeArea(.all, edges: .bottom)

                    HStack(spacing: 24) {
                        Button {
                            self.leaveRoomAction = true
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                                .rotationEffect(.degrees(90))
                                .foregroundColor(tm.theme.labelColorSecondary)
                        }
                        Spacer()
                        Button {} label: {
                            Image(systemName: "bell.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                                .foregroundColor(tm.theme.labelColorSecondary)
                        }
                        Button {} label: {
                            Image(systemName: "star")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                                .foregroundColor(tm.theme.labelColorSecondary)
                        }
                        Button {
                            roomSettingAction.toggle()
                        } label: {
                            Image(systemName: "gear")
                                .font(.system(size: 24))
                                .frame(width: 28, height: 28)
                                .foregroundColor(tm.theme.labelColorSecondary)
                        }
                    }
                    .padding(16)
                }
                .frame(height: 56)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(tm.lang.localized("Chat.Drawer.Title"))
            .navigationBarColor(backgroundColor: UIColor(tm.theme.systemBackground),
                                tintColor: UIColor(tm.theme.labelColorPrimary))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 17))
                            .foregroundColor(tm.theme.labelColorPrimary)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $chatMediaArchiveAction) {
            RoomMediaArchivePage()
        }
        .fullScreenCover(isPresented: $chatMediaViewAction) {
            ChatRoomMediaViewPage(type: .NORMAL)
        }
        .fullScreenCover(isPresented: $roomSettingAction) {
            ChatRoomSettingPage(viewModel: viewModel)
        }
        .fullScreenCover(isPresented: $inviteRoomAction) {
            FriendsSelectionPage(mode: .inviteRoom,
                                 friendsSelectionViewModel: AppDI.shared.friendsSelectionViewModel) { selected in
                debugLog(selected)
                // TODO: invite
            }
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
}

#if DEBUG
struct ChatRoomDrawerPage_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomDrawerPage()
            .environmentObject(ThemeManager())
    }
}
#endif
