//
//  ChatRoomPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerChatRoomUI
import ChatModuleMessengerChatMessagesUI

struct ChatRoomPage: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var messageViewModel: ChatMessagesViewModel
    @ObservedObject var roomViewModel: ChatRoomViewModel

    @State var text = ""
    @State var chatRoomDrawerAction: Bool = false

    @State var emoticonPreViewAction: Bool = false

    @State var chatMediaViewAction: Bool = false
    @State var chatSendContactAction: Bool = false
    @State var chatSendProfileAction: Bool = false
    // TODO: keyboard 높이에 따라 변경 필요
    @State var bottomSectionHeight: CGFloat = 0
    @State var bottomSectionType: ChatRoomBottomSectionType = .NONE
    @State var keyboardHeight: CGFloat = 0
    @State var inputTextFieldHeight = MultiLineTextFieldSize.MIN_HEIGHT.rawValue

    // Album
    @State var imageListSelectType: MessageImageListSelectType?

    @ObservedObject private var keyboardResponder = KeyboardResponder()

    init(messageViewModel: ChatMessagesViewModel = .init(),
         roomViewModel: ChatRoomViewModel = .init()) {
        self.messageViewModel = messageViewModel
        self.roomViewModel = roomViewModel
        debugLog("roomId : \(roomViewModel.room.roomId)")
    }

    var body: some View {
        ZStack {
            self.appState.tm.theme.background
                .ignoresSafeArea(.all)

            NavigationView {
                ZStack {
                    self.appState.tm.theme.background
                        .ignoresSafeArea(.all)

                    VStack(spacing: 0) {
                        ScrollViewReader { scrollView in
                            ScrollView(.vertical) {
                                LazyVStack {
                                    ForEach(messageViewModel.messages, id: \.id) { message in
                                        MessageContainerSection(messageInfo: message)
                                            .listRowSeparatorHidden()
                                    }
                                }
                            }
                            .overlay(
                                RoomGoToLatestMessageSection {
                                    scrollView.scrollTo(messageViewModel.messages[messageViewModel.messages.endIndex-1].id)
                                }
                                    .padding(8),
                                alignment: .bottomTrailing
                            )
                        }
                        .onAppear {
                            messageViewModel.fetchMessagesList(roomId: 1)
                            // 단일 메시지 가져오기 테스트
//                            messageViewModel.getMessage(id: "1")
                        }
                        .listStyle(.plain)
                        .onTapGesture {
                            hideKeyboard()
                            self.emoticonPreViewAction = false
                            self.bottomSectionType = .NONE
                        }

                        MessageInputSection(text: $text,
                                            bottomSectionType: $bottomSectionType,
                                            textFieldHeight: $inputTextFieldHeight,
                                            sendBtnClick: { text in
                            messageViewModel.addMessage(message: ChatMessageEntity(id: String(messageViewModel.messages.count + 1),
                                                                                   type: .TEXT,
                                                                                   payload: .init(payloadType: .TEXT(text: text)),
                                                                                   flow: .SENT_MESSAGE))
                        })

                        bottomSectionView
                        .frame(height: bottomSectionHeight)
                    }

                    VStack {
                        Spacer()

                        if emoticonPreViewAction {
                            let emoticonItemInfo = EmoticonItemInfo(id: "1", emoticonInfoId: "1",
                                                                    name: "emo1", url: "", nameThumb: "", urlThumb: "")

                            EmoticonItemPreviewSection(emoticonItemInfo: emoticonItemInfo, closePreview: {
                                emoticonPreViewAction = false
                            })
                            .padding(.bottom, (inputTextFieldHeight+19+bottomSectionHeight))
                        }
                    }
                }
                .fullScreenCover(isPresented: $chatMediaViewAction) {
                    ChatRoomMediaViewPage(type: .NORMAL)
                }
                .fullScreenCover(item: $imageListSelectType) { select in
                    if select == .ALL {
                        MediaImageSelectionPage()
                    } else if select == .DETAIL {
                        MediaImageDetailSelectionPage(counter: 0, assets: nil, selectList: nil)
                    } else if select == .QULITY {
                        MessageImageQualityOptionPage()
                    }
                }
                .onChange(of: keyboardResponder.currentHeight) { height in
                    keyboardHeight = height

                    if height > 0 {
                        self.bottomSectionType = .NONE
                    }
                }
                .onChange(of: bottomSectionType) { type in
                    // 키보드가 떠있는지 검사해서 없으면 각자의 default 값
                    switch type {
                    case .NONE:
                        bottomSectionHeight = 0
                    default:
                        hideKeyboard()
                        self.emoticonPreViewAction = false
                        if bottomSectionHeight == 0 {
                            bottomSectionHeight = 244
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarColor(backgroundColor: UIColor(appState.tm.theme.background),
                                    tintColor: UIColor(appState.tm.theme.labelColorPrimary))
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(self.appState.tm.theme.labelColorPrimary)
                                .font(.system(size: 17).weight(.semibold))
                        }
                    }

                    ToolbarItem(placement: .principal) {
                        Text(roomViewModel.room.roomName ?? "")
                            .foregroundColor(self.appState.tm.theme.labelColorPrimary)
                            .font(self.appState.tm.typo.title3)
                    }

                    ToolbarItem(placement: .primaryAction) {
                        HStack(spacing: 0) {
                            Button {

                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(self.appState.tm.theme.labelColorPrimary)
                                    .font(Font.body.weight(.semibold))
                            }
                            .frame(width: 38, height: 42)

                            Button {
                                self.chatRoomDrawerAction.toggle()
                            } label: {
                                Image(systemName: "line.horizontal.3")
                                    .foregroundColor(self.appState.tm.theme.labelColorPrimary)
                                    .font(Font.body.weight(.semibold))
                            }
                            .frame(width: 38, height: 42)
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $chatRoomDrawerAction) {
                ChatRoomDrawerPage(viewModel: roomViewModel)
            }
            .fullScreenCover(isPresented: $chatSendProfileAction) {
                FriendsSelectionPage(mode: .sendProfile,
                                     friendsSelectionViewModel: AppDI.shared.friendsSelectionViewModel) { selected in
                    debugLog(selected)
                    // TODO: send profile
                }
            }
            .actionSheet(isPresented: $chatSendContactAction) {
                ActionSheet(title: Text(""),
                            message: Text(appState.tm.lang.localized("Chat.SendContact.Title")),
                            buttons: [
                                .default(Text(appState.tm.lang.localized("Chat.SendContact.Profile")),
                                         action: {
                                             self.chatSendProfileAction = true
                                             self.bottomSectionType = .NONE
                                         }),
                                .default(Text(appState.tm.lang.localized("Chat.SendContact.Contact")),
                                         action: { self.bottomSectionType = .NONE }),
                                .default(Text(appState.tm.lang.localized("Chat.SendContact.BusinessCard")),
                                         action: { self.bottomSectionType = .NONE }),
                                .cancel(Text(appState.tm.lang.localized("Common.Cancel")),
                                        action: { self.bottomSectionType = .NONE })
                            ])
            }
            .onAppear {
                UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self])
                    .tintColor = UIColor(appState.tm.theme.labelColorPrimary)
            }
        }
    }

    @ViewBuilder
    private var bottomSectionView: some View {
        switch self.bottomSectionType {
        case .NONE:
            EmptyView()
        case .SERVICE:
            ChatServicePagerSection(selectService: { service in
                switch service {
                case .ALBUM:
                    self.bottomSectionType = .MEDIA
                case .CONTACTS:
                    self.chatSendContactAction = true
                default:
                    self.bottomSectionType = .NONE
                }
                if service == .ALBUM {

                } else {
                    self.bottomSectionType = .NONE
                }
            })
                .ignoresSafeArea(.all)
        case .MEDIA:
            MessageImageListSection(previewHeight: bottomSectionHeight, imageListSelectType: $imageListSelectType)
        case .EMOTICON:
            EmoticonPagerSection(emoticonSelect: { _ in
                self.emoticonPreViewAction = true
            })
                .ignoresSafeArea(.all)
        case .HASTAG:
            EmptyView()
        }
    }
}

#if DEBUG
struct ChatRoomPage_Previews: PreviewProvider {
    static var previews: some View {

        ChatRoomPage()
            .environmentObject(AppState())
            .environmentObject(ThemeManager())
    }
}
#endif
