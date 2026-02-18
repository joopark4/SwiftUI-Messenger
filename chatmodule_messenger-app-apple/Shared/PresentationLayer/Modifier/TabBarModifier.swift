//
//  TabBarModifier.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import SwiftUI

extension View {

    /// tabBarBackgroundColor
    ///
    /// Usage:
    ///
    ///       .tabBarBackgroundColor(color: UIcolor.red)
    ///
    func tabBarBackgroundColor(color: UIColor) -> some View {
        self.modifier(TabBarColorModifier(color: color))
    }

}

/// TabBarColorModifier
///
/// Usage:
///
///       TabBarColorModifier(color: UIcolor.red)
///
struct TabBarColorModifier: ViewModifier {

    /// TabBarColor
    /// - Parameter color: background color
    init(color: UIColor) {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = color

        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        } else {
            // Fallback on earlier versions
        }
    }

    func body(content: Content) -> some View {
        content
    }
}
