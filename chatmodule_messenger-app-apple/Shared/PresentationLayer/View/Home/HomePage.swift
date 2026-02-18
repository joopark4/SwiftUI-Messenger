//
//  HomePage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

/// HomeTabs
///
/// friends, chat, setting
/// 
public enum HomeTabs: Int, CaseIterable {
    case friends, camera, chat

    var systemImage: String {
        switch self {
        case .friends: return "person.fill"
        case .camera: return "camera.fill"
        case .chat: return "message.fill"
        }
    }

    var labelKey: String {
        switch self {
        case .friends: return "Friends"
        case .camera: return "Camera"
        case .chat: return "Chat"
        }
    }

    var view: some View {
        switch self {
        case .friends: return AnyView(FriendsPage(viewModel: AppDI.shared.friendsViewModel))
        case .camera: return AnyView(CameraPage())
        case .chat: return AnyView(ChatRoomListPage(viewModel: AppDI.shared.chatRoomListViewModel))
        }
    }
}

/// HomePage
///
/// tab을 사용한 home page
///
struct HomePage: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        TabView(selection: appState.appSetting.$lastTab) {
            ForEach(HomeTabs.allCases, id: \.self) { tab in
                tab.view
                    .tabItem {
                        VStack {
                            Image(systemName: tab.systemImage)
                                .font(.system(size: 22))
                            Text(appState.tm.lang.localized(tab.labelKey))
                        }
                    }
                    .tag(tab.rawValue)
                    .backport.badge(tab == .chat ? 1 : 0)
            }
        }
        .tabBarBackgroundColor(color: UIColor(appState.tm.theme.background))
        .accentColor(appState.tm.theme.systemPurple)
    }
}

#if DEBUG
struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
            .environmentObject(AppState())
    }
}
#endif
