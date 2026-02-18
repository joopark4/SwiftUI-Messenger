//
//  View+Extension.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }

    func dismissToRootView() {
        UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true)
    }
}
