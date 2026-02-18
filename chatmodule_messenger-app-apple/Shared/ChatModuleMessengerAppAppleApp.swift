//
//  ChatModuleMessengerAppAppleApp.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import SDWebImageWebPCoder

@main
struct ChatModuleMessengerAppAppleApp: App {
    @Environment(\.scenePhase) var scenePhase
    let appState = AppState()
    let contactViewModel = AppDI.shared.contactsViewModel

    init() {
        self.appState.tm.lang.inject()

        // alert 버튼 색
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(self.appState.tm.theme.systemPurple)

        // SDWebImage
        SDImageCodersManager.shared.addCoder(SDImageWebPCoder.shared)
        SDImageCodersManager.shared.addCoder(SDImageGIFCoder.shared)
    }

    var body: some Scene {
        WindowGroup {
//            TestMainPage()

            MainPage()
                .environmentObject(appState)
                .environmentObject(appState.tm)
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                print("Active")
                contactViewModel.fetchContactsList(historyToken: appState.appSetting.historyToken, completion: { historyToken in
                    self.appState.appSetting.historyToken = historyToken
                })
            } else if newPhase == .inactive {
                print("Inactive")
            } else if newPhase == .background {
                print("Background")
            }
        }
    }
}
