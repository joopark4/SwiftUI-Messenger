//
//  ThemeManager.swift
//  ChatModuleMessengerUI
//

import Foundation

/// Theme Manager
public class ThemeManager: ObservableObject {
    @Published public var theme: Theme
    @Published public var lang: Language
    @Published public var typo: Typography

    /// Create ThemeManager
    /// 
    /// - Parameters:
    ///   - theme: 테마
    ///   - lang: 언어
    ///   - typo: 폰트
    public init(theme: Theme = Theme(),
                lang: Language = Language(),
                typo: Typography = Typography()) {
        self.theme = theme
        self.lang = lang
        self.typo = typo
    }
}
