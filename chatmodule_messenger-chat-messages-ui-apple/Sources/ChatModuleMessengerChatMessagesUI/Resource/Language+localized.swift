//
//  Language+localized.swift
//  ChatModuleMessengerChatMessagesUI
//

import Foundation
import ChatModuleMessengerUI

extension Language {
    public func localizedChatMessage(_ key: String) -> String {
        let path = Bundle.module.path(forResource: self.types.rawValue, ofType: "lproj")
        if let path = path, let bundle = Bundle(path: path) {
            return NSLocalizedString(key, bundle: bundle, value: key, comment: "")
        } else {
            return key
        }
    }
}
