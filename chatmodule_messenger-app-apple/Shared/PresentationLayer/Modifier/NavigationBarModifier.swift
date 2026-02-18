//
//  NavigationBarModifier.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import SwiftUI

 extension View {

     /// navigationBarColor
     ///
     /// Usage:
     ///
     ///       .navigationBarColor(backgroundColor: UIColor.red, tintColor: UIColor.blue)
     ///
     func navigationBarColor(backgroundColor: UIColor, tintColor: UIColor? = nil) -> some View {
         self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, tintColor: tintColor))
     }

     /// navigationBarColorDefault
     ///
     /// Usage:
     ///
     ///       .navigationBarColorDefault()
     ///
    func navigationBarColorDefault() -> some View {
        self.modifier(NavigationBarModifier())
    }

 }

/// NavigationBarModifier
///
/// Usage:
///
///       NavigationBarModifier(backgroundColor: UIColor.red, tintColor: UIColor.blue)
///
 struct NavigationBarModifier: ViewModifier {

     /// NavigationBarModifier
     /// - Parameters:
     ///   - backgroundColor: backgroundColor
     ///   - tintColor: tinkColor
    init(backgroundColor: UIColor? = nil, tintColor: UIColor? = nil) {
        let appearance = UINavigationBarAppearance()

        if let backgroundColor = backgroundColor {
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = backgroundColor
        } else {
            appearance.configureWithOpaqueBackground()
        }

        if let tintColor = tintColor {
            appearance.titleTextAttributes = [.foregroundColor: tintColor]
            appearance.largeTitleTextAttributes = [.foregroundColor: tintColor]
        }

        appearance.shadowColor = .clear

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = tintColor
    }

    func body(content: Content) -> some View {
        content
    }
 }
