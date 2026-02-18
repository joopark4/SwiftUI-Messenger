//
//  ChatRoomListPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerChatRoomUI

struct ChatRoomListPage: View {
    @EnvironmentObject var appState: AppState

    @StateObject var searchBar: SearchBar = SearchBar()
    @State var enterChatRoom: ChatRoomEntity?
    @State var inviteFriendAction = false

    @ObservedObject private var viewModel: ChatRoomListViewModel

    init(viewModel: ChatRoomListViewModel = .init()) {
        debugLog()
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                if self.viewModel.rooms.isEmpty {
                    emptyView
                } else {
                    List {
                        ForEach(self.viewModel.rooms, id: \.roomId) { room in
                            Button { enterChatRoom = room } label: {
                                ChatRoomInfoItemSection(roomInfo: room)
                            }
                            .listRowInsets(EdgeInsets())
                            .listRowSeparatorHidden()
                        }
                    }
                    .removeHeaderTopPadding()
                    .listStyle(.plain)
                    .add(searchBar)
                }
            }
            .navigationBarColorDefault()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // navigation title
                ToolbarItem(placement: .principal) {
                    Text(self.appState.tm.lang.localized("Chat"))
                        .font(.headline)
                }

                ToolbarItem(placement: .primaryAction) {
                    HStack(spacing: 0) {
                        Button {
                            inviteFriendAction.toggle()
                        } label: {
                            Image(systemName: "plus.bubble")
                                .foregroundColor(appState.tm.theme.labelColorSecondary)
                        }
                        .frame(width: 38, height: 42)
                        .fullScreenCover(isPresented: $inviteFriendAction) {
                            FriendsSelectionPage(mode: .createRoom,
                                                 friendsSelectionViewModel: AppDI.shared.friendsSelectionViewModel)
                        }

                        Button { } label: {
                            Image(systemName: "music.note")
                                .foregroundColor(appState.tm.theme.labelColorSecondary)
                        }
                        .frame(width: 38, height: 42)
                        Button { } label: {
                            Image(systemName: "gear")
                                .foregroundColor(appState.tm.theme.labelColorSecondary)
                        }
                        .frame(width: 38, height: 42)
                    }
                }
            }
            .onAppear {
                self.viewModel.fetchChatRoomList()
            }
            .fullScreenCover(item: $enterChatRoom, onDismiss: {
                self.viewModel.fetchChatRoomList()
            }) {
                ChatRoomPage(messageViewModel: AppDI.shared.chatMessagesViewModel,
                             roomViewModel: AppDI.shared.chatRoomViewModel(room: $0))
            }
        }
    }

    var emptyView: some View {
        ListItemHalfMobileCenterIcon(topIconBox: Image("visual 01"),
                                     subTitle1: Text(appState.tm.lang.localized("Chat.RoomList.Empty.Title")),
                                     subTitle2: appState.tm.lang.localized("Chat.RoomList.Empty.Description"),
                                     iconText: EmptyView(),
                                     bottomIconBox: Button {
            inviteFriendAction.toggle()
        } label: {
            Text(appState.tm.lang.localized("Chat.RoomList.Empty.Button"))
                .fontWeight(.semibold)
                .font(appState.tm.typo.body)
                .foregroundColor(appState.tm.theme.systemPurple)
                .padding(.horizontal, 20)
                .frame(height: 42)
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(red: 0.56, green: 0.56, blue: 0.58), lineWidth: 1))
        })
        .frame(width: 327)
    }
}

struct ChatRoomListPage_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomListPage()
            .environmentObject(AppState())
            .environmentObject(ThemeManager())
    }
}
