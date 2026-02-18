//
//  ContentForwardingSelectionPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerChatRoomUI

struct ContentForwardingSelectionPage: View {
    @EnvironmentObject var tm: ThemeManager
    @Environment(\.presentationMode) private var presentationMode
    @State var searchText: String = ""
    @State var counter: Int = 0
    @State var forwardingType: Int = 0
    @State var hiddenCheckFriends = false
    @State var searchResult = true

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ContentForwardingSelectionTabSection(selectTabItem: $forwardingType, hiddenCheckFriendList: $hiddenCheckFriends)

                textfiledView

                if searchResult {
                    if forwardingType == 0 {
                        FriendsSelectionListSection(accountInfos: [
                            AccountEntity(signInId: "", username: "Name 01"),
                            AccountEntity(signInId: "", username: "Name 02"),
                            AccountEntity(signInId: "", username: "Name 03")
                        ])
                    } else {
                        RoomSelectionListSection(roomInfos: [
                            ChatRoomEntity(roomId: 0, lastMessage: "lastMessage 1", roomName: "Room 1"),
                            ChatRoomEntity(roomId: 1,
                                           isNotReceiveNotification: true,
                                           lastMessage: "lastMessage 2 lastMessage 2 lastMessage 2 lastMessage 2 lastMessage 2",
                                           roomName: "Room 2"),
                            ChatRoomEntity(roomId: 2,
                                           lastMessage: "lastMessage 3",
                                           memberCount: 99,
                                           roomName: "Room 3")
                        ])
                    }
                } else {
                    Spacer()

                    Text(tm.lang.localized("ChatRoom.Forwarding.SearchEmpty"))

                    Spacer()
                }
            }
            .navigationTitle(tm.lang.localized("ChatRoom.Forwarding.Select"))
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(backgroundColor: UIColor(tm.theme.systemBackground), tintColor: UIColor(tm.theme.labelColorPrimary))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(tm.theme.labelColorPrimary)
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            if counter > 0 {
                                Text("\(counter)")
                                    .foregroundColor(tm.theme.systemPurple)
                                    .font(tm.typo.body)
                            }

                            Text(tm.lang.localized(tm.lang.localized("Common.Ok")))
                                .foregroundColor(tm.theme.labelColorPrimary)
                        }
                    }
                }
            }
            .onChange(of: forwardingType) { value in
                // 검색 초기화
                searchText = ""

                // 대화방이 1
                // enum 타입으로 변경해야할거 같음
                if value == 1 {
                    hiddenCheckFriends = true
                } else {
                    hiddenCheckFriends = false
                }
            }
        }
    }

    private var textfiledView: some View {
        ZStack(alignment: .trailing) {
            tm.theme.fillColorTertiary

            TextField(tm.lang.localized("Chat.Invitation.Search.Placehold"),
                               text: self.$searchText)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 2, trailing: 41))

            Button {
                searchText = ""
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 17))
                    .foregroundColor(.gray)
            }.padding(.trailing, 16)
        }
        .frame(minWidth: 342, maxWidth: .infinity, minHeight: 44, maxHeight: 44)
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 17))
    }
}

#if DEBUG
struct ContentForwardingSelectionPage_Previews: PreviewProvider {
    static var previews: some View {
        ContentForwardingSelectionPage()
            .environmentObject(ThemeManager())
    }
}
#endif
