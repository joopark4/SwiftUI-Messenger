//
//  Language+localized.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import ChatModuleMessengerUI

extension Language {
    /// string dependency injection
    mutating func inject() {
        // Feature가 추가될때마다 localized function을 주입해줘야함
        self.appendLocalizedFunc(contentsOf: [
            localizedChatMessage,
            localizedChatRoom,
            localizedFriends,
            localizedApp
        ])
    }

    fileprivate func localizedApp(_ key: String) -> String {
        let path = Bundle.main.path(forResource: self.types.rawValue, ofType: "lproj")
        if let path = path, let bundle = Bundle(path: path) {
            return NSLocalizedString(key, bundle: bundle, value: key, comment: "")
        } else {
            return key
        }
    }
}
