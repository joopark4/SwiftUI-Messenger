//
//  ListModifier.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import SwiftUI

extension List {
    /// remove list header top padding on iOS 15
    ///
    /// Usage:
    ///
    ///     List { ... }
    ///       .removeHeaderTopPadding()
    func removeHeaderTopPadding() -> some View {
        self.modifier(ListHeaderTopPaddingModifier())
    }

}

/// remove list header top padding on iOS 15
struct ListHeaderTopPaddingModifier: ViewModifier {

    /// create modifier
    init() {
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
    }

    func body(content: Content) -> some View {
        content
    }
}

extension View {
    /// remove list row separator (iOS 15.0)
    ///
    /// Usage:
    ///
    ///     List {
    ///         SomeRow()
    ///             .listRowSeparatorHidden()
    ///     }
    @ViewBuilder func listRowSeparatorHidden() -> some View {
        if #available(iOS 15.0, *) {
            self.listRowSeparator(.hidden)
        } else {
            // Fallback on earlier versions
            self
        }
    }
}
