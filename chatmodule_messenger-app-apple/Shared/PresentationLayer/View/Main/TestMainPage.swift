//
//  TestMainPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

/// 페이지 테스트를 위한 뷰
/// 테스트할 페이지 추가 시 화면 표시 타입에 맞는 enum과 viewbuilder에 추가하면 됨
struct TestMainPage: View {
    // MARK: - Full Screen Cover 타입
    enum FullScreens: String, Identifiable, CaseIterable {
        // Home
        case HomePage
        // Friends
        case FriendsPage, ViewFriendProfilePage
        // Chat
        case ChatRoomListPage, ChatRoomPage, ChatRoomInvitationPage
        case ChatRoomDrawerPage, ChatRoomSettingPage, MediaImageSelectionPage
        case SmileMeCameraViewPage, RoomMediaArchivePage, ChatRoomMediaViewPage
        // Setting
        case SettingPage, PasscodePage

        var id: String { self.rawValue }
    }

    @ViewBuilder
    private func fullScreensView(_ screen: FullScreens) -> some View {
        switch screen {
        case .HomePage: HomePage()
        case .FriendsPage: FriendsPage(viewModel: .init())
        case .ViewFriendProfilePage: FriendProfilePage(friendsViewModel: .init(), friendInfo: FriendEntity(account: .init(signInId: "0", username: "김개똥")))
        case .ChatRoomListPage: ChatRoomListPage()
        case .ChatRoomPage: ChatRoomPage()
        case .ChatRoomInvitationPage: FriendsSelectionPage()
        case .ChatRoomDrawerPage: ChatRoomDrawerPage()
        case .ChatRoomSettingPage: ChatRoomSettingPage()
        case .MediaImageSelectionPage: MediaImageSelectionPage()
        case .SmileMeCameraViewPage: SmileMeCameraViewPage()
        case .RoomMediaArchivePage: RoomMediaArchivePage()
        case .ChatRoomMediaViewPage: ChatRoomMediaViewPage(type: .NORMAL)
        case .SettingPage: SettingPage()
        case .PasscodePage: PasscodePage()
        }
    }

    // MARK: - Sheet 타입
    enum Sheets: String, Identifiable, CaseIterable {
        // Friends
        case AddFriendByContactPage, EditFriendNamePage, SelectCountryPage
        // Chat

        var id: String { self.rawValue }
    }

    @ViewBuilder
    private func sheetsView(_ sheet: Sheets) -> some View {
        switch sheet {
        case .AddFriendByContactPage : FriendAddPage(friendViewModel: .init(),
                                                              selectCountryViewModel: .init())
        case .EditFriendNamePage: EditFriendNamePage(friendsViewModel: .init(),
                                                     friendInfo: FriendEntity(account: .init(signInId: "0", username: "김개똥")),
                                                     editInput: "친구 이름",
                                                     friendsSetName: "친구가 설정한 이름")
        case .SelectCountryPage: SelectCountryPage(selectCountryViewModel: .init(),
                                                   selectCountryCode: .constant("KR"))
        }
    }

    // MARK: - Navigation 타입
    enum Navigations: String, Identifiable, CaseIterable {
        // Friends
        case InviteFriendPage
        // Chat
        case ChatRoomContentsExportPage, GroupChatRoomSettingPage
        case ChatRoomNameSettingPage, ChatRoomTextToneSettingPage, ChatRoomWallpaperPage
        case ChatRoomWallpaperSelectionPage, MediaImageDetailSelectionPage
        case MessageImageQualityOptionPage, MessageMassTextViewerPage

        var id: String { self.rawValue }
    }

    @ViewBuilder
    private func navigationsView(_ nav: Navigations) -> some View {
        switch nav {
        case .InviteFriendPage: FriendInvitePage(viewModel: .init())
        case .ChatRoomContentsExportPage: ChatRoomContentsExportPage()
        case .GroupChatRoomSettingPage: GroupChatRoomSettingPage()
        case .ChatRoomNameSettingPage: ChatRoomNameSettingPage()
        case .ChatRoomTextToneSettingPage: ChatRoomTextToneSettingPage()
        case .ChatRoomWallpaperPage: ChatRoomWallpaperPage()
        case .ChatRoomWallpaperSelectionPage:
            ChatRoomWallpaperSelectionPage(wallpaperType: .color)
        case .MediaImageDetailSelectionPage: MediaImageDetailSelectionPage(counter: 0, assets: nil, selectList: nil)
        case .MessageImageQualityOptionPage: MessageImageQualityOptionPage()
        case .MessageMassTextViewerPage: MessageMassTextViewerPage(messageInfo: .init())
        }
    }

    // MARK: - body 이하 수정할 필요 없음
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var tm: ThemeManager

    @State var fullScreens: FullScreens?
    @State var sheets: Sheets?

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Full screen")) {
                    ForEach(FullScreens.allCases) { screen in
                        Button { fullScreens = screen } label: { Text(screen.rawValue) }
                    }
                }

                Section(header: Text("Sheet")) {
                    ForEach(Sheets.allCases) { sheet in
                        Button { sheets = sheet } label: { Text(sheet.rawValue) }
                    }
                }

                Section(header: Text("Navigation")) {
                    ForEach(Navigations.allCases) { nav in
                        NavigationLink(destination: navigationsView(nav)) { Text(nav.rawValue) }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("TestMainPage")
            .navigationBarColorDefault()
        }
        .fullScreenCover(item: $fullScreens) { fullScreensView($0) }
        .sheet(item: $sheets) { sheetsView($0) }
    }
}

#if DEBUG
struct TestMainPage_Previews: PreviewProvider {
    static var previews: some View {
        TestMainPage()
            .environmentObject(AppState())
            .environmentObject(ThemeManager())
    }
}
#endif
