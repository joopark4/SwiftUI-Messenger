//
//  MainPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

/// MainPage
///
///  app의 전체적인 navigation
///  loading - login - home 등등
///
struct MainPage: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        HomePage()
            .environmentObject(appState)
            .environmentObject(appState.tm)
    }
}

#if DEBUG
struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
            .environmentObject(AppState())
    }
}
#endif
