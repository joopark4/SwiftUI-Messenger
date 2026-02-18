//
//  AppState.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine
import ChatModuleMessengerUI

public class AppState: ObservableObject {
    @Published var appSetting: AppSettings
    @Published var tm: ThemeManager

    var settingCancellable: AnyCancellable?
    var tmCancellable: AnyCancellable?

    init(appSetting: AppSettings = AppSettings(),
         tm: ThemeManager = ThemeManager()) {
        self.appSetting = appSetting
        self.tm = tm

        settingCancellable = appSetting.objectWillChange
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.objectWillChange.send()
            })

        tmCancellable = tm.objectWillChange
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.objectWillChange.send()
            })
    }

}
