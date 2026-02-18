//
//  Theme.swift
//  ChatModuleMessengerUI
//

import SwiftUI

/// 테마 적용을 위한 struct
public struct Theme {
    /// Theme.Types
    ///
    /// basic(default), chatmodule, ...
    /// 
    /// chatmodule의 경우 아직 color palate가 나오지 않음
    public enum Types: String {
        case basic
        case chatmodule
    }

    /// 사용할 테마 타입
    public var types: Types

    /// Create Theme
    /// - Parameter types: 테마 타입 (기본값 .basic)
    public init(types: Types = .basic) {
        self.types = types
    }


    public var surface_medium_emphasis: Color {
        return Color("surface-medium-emphasis", bundle: .module)
    }

    public var linear00: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color("linear00-start", bundle: .module),
                                                   Color("linear00-end", bundle: .module)]),
                       startPoint: .top, endPoint: .bottomTrailing)
    }
    
    public var linear00Start: Color {
        return Color("linear00-start", bundle: .module)
    }
    
    public var linear00End: Color {
        return Color("linear00-end", bundle: .module)
    }
    
    public var backgroundInfoSelect: Color {
        switch types {
        case .basic:
            return Color("background-info-select", bundle: .module)

        case .chatmodule:
            return Color("background-info-select", bundle: .module)
        }
    }

    public var befamilyBackgroundSemiBlack: Color {
        switch types {
        case .basic:
            return Color("background-semi-black", bundle: .module)

        case .chatmodule:
            return Color("background-semi-black", bundle: .module)
        }
    }

    public var befamilyBackground01Light: Color {
        switch types {
        case .basic:
            return Color("befamilyBackground01-Light", bundle: .module)

        case .chatmodule:
            return Color("befamilyBackground01-Light", bundle: .module)
        }
    }

    public var befamilyBackground02Light: Color {
        switch types {
        case .basic:
            return Color("befamilyBackground02-Light", bundle: .module)

        case .chatmodule:
            return Color("befamilyBackground02-Light", bundle: .module)
        }
    }

    public var bubbleBgMine01: Color {
        switch types {
        case .basic:
            return Color("bubble-bg-mine01", bundle: .module)

        case .chatmodule:
            return Color("bubble-bg-mine01", bundle: .module)
        }
    }

    public var befamilySecondaryVariant: Color {
        switch types {
        case .basic:
            return Color("befamily-secondary-variant", bundle: .module)
        case .chatmodule:
            return Color("befamily-secondary-variant", bundle: .module)
        }
    }

    public var chatmoduleColor00: Color {
        switch types {
        case .basic:
            return Color("ChatModule-Color00", bundle: .module)
        case .chatmodule:
            return Color("ChatModule-Color00", bundle: .module)
        }
    }

    // MARK: - SystemColor
    // 현재 chatmodule 설정은 예제로만 되어있고 추후 테마가 나오면 변경 필요
    public var systemPurple: Color {
        switch types {
        case .basic:
            return Color(UIColor.systemPurple)
        case .chatmodule:
            return Color("chatmodulePrimary", bundle: .module)
        }
    }

    public var systemRed: Color {
        switch types {
        case .basic:
            return Color(UIColor.systemRed)
        case .chatmodule:
            return Color(UIColor.systemRed)
        }
    }

    public var systemOrange: Color {
        switch types {
        case .basic:
            return Color(UIColor.systemOrange)
        case .chatmodule:
            return Color(UIColor.systemOrange)
        }
    }

    public var systemYellow: Color {
        switch types {
        case .basic:
            return Color(UIColor.systemYellow)
        case .chatmodule:
            return Color(UIColor.systemYellow)
        }
    }

    public var systemGreen: Color {
        switch types {
        case .basic:
            return Color(UIColor.systemGreen)
        case .chatmodule:
            return Color(UIColor.systemGreen)
        }
    }

    public var systemBlue: Color {
        switch types {
        case .basic:
            return Color(UIColor.systemBlue)
        case .chatmodule:
            return Color(UIColor.systemBlue)
        }
    }

    public var systemPink: Color {
        switch types {
        case .basic:
            return Color(UIColor.systemPink)
        case .chatmodule:
            return Color(UIColor.systemPink)
        }
    }

    public var systemGray: Color {
        switch types {
        case .basic:
            return Color(UIColor.systemGray)
        case .chatmodule:
            return Color(UIColor.systemGray)
        }
    }
    
    public var systemTeal: Color {
        switch types {
        case .basic:
            return Color(UIColor.systemTeal)
        case .chatmodule:
            return Color(UIColor.systemTeal)
        }
    }
    
    public var systemIndigo: Color {
        switch types {
        case .basic:
            return Color(UIColor.systemIndigo)
        case .chatmodule:
            return Color(UIColor.systemIndigo)
        }
    }
    
    public var systemFill: Color {
        switch types {
        case .basic:
            return Color(UIColor.systemFill)
        case .chatmodule:
            return Color(UIColor.systemFill)
        }
    }

    // MARK: - System Label Color
    public var labelColorPrimary: Color {
        switch types {
        case .basic:
            return Color(UIColor.label)
        case .chatmodule:
            return Color(UIColor.label)
        }
    }

    public var labelColorSecondary: Color {
        switch types {
        case .basic:
            return Color(UIColor.secondaryLabel)
        case .chatmodule:
            return Color(UIColor.secondaryLabel)
        }
    }

    public var labelColorTertiary: Color {
        switch types {
        case .basic:
            return Color(UIColor.tertiaryLabel)
        case .chatmodule:
            return Color(UIColor.tertiaryLabel)
        }
    }

    public var labelColorQuarternary: Color {
        switch types {
        case .basic:
            return Color(UIColor.quaternaryLabel)
        case .chatmodule:
            return Color(UIColor.quaternaryLabel)
        }
    }

    // MARK: - System Separator Color
    public var separatorColor: Color {
        switch types {
        case .basic:
            return Color(UIColor.separator)
        case .chatmodule:
            return Color(UIColor.separator)
        }
    }

    public var background: Color {
        switch types {
        case .basic:
            return Color("background", bundle: .module)
        case .chatmodule:
            return Color("background", bundle: .module)
        }
    }
}

#if !os(macOS)
// macos에서 매핑되지 않은 색상
extension Theme {
    public var systemGray2: Color {
        switch types {
        case .basic:
            return Color(UIColor.systemGray2)
        case .chatmodule:
            return Color(UIColor.systemGray2)
        }
    }
    
    public var systemGray4: Color {
        switch types {
        case .basic:
            return Color(UIColor.systemGray4)
        case .chatmodule:
            return Color(UIColor.systemGray4)
        }
    }

    public var systemGray5: Color {
        switch types {
        case .basic:
            return Color(UIColor.systemGray5)
        case .chatmodule:
            return Color(UIColor.systemGray5)
        }
    }

    // MARK: - Background Color
    public var systemBackground: Color {
        switch types {
        case .basic:
            return Color(UIColor.systemBackground)
        case .chatmodule:
            return Color(UIColor.systemBackground)
        }
    }

    public var systemBackgroundSecondary: Color {
        switch types {
        case .basic:
            return Color(UIColor.secondarySystemBackground)
        case .chatmodule:
            return Color(UIColor.secondarySystemBackground)
        }
    }

    public var systemBackgroundTertiary: Color {
        switch types {
        case .basic:
            return Color(UIColor.tertiarySystemBackground)
        case .chatmodule:
            return Color(UIColor.tertiarySystemBackground)
        }
    }

    public var fillColorPrimary: Color {
        switch types {
        case .basic:
            return Color(UIColor.systemFill)
        case .chatmodule:
            return Color(UIColor.systemFill)
        }
    }
    
    public var fillColorSecondary: Color {
        switch types {
        case .basic:
            return Color(UIColor.secondarySystemFill)
        case .chatmodule:
            return Color(UIColor.secondarySystemFill)
        }
    }

    public var fillColorTertiary: Color {
        switch types {
        case .basic:
            return Color(UIColor.tertiarySystemFill)
        case .chatmodule:
            return Color(UIColor.tertiarySystemFill)
        }
    }

    public var fillColorQuarternary: Color {
        switch types {
        case .basic:
            return Color(UIColor.quaternarySystemFill)
        case .chatmodule:
            return Color(UIColor.quaternarySystemFill)
        }
    }
}

#else

// macos는 UIColor가 없어 NSColor로 매핑함
typealias UIColor = NSColor
extension NSColor {
    static var label = NSColor.labelColor
    static var secondaryLabel = NSColor.secondaryLabelColor
    static var tertiaryLabel = NSColor.tertiaryLabelColor
    static var quaternaryLabel = NSColor.quaternaryLabelColor
    static var separator = NSColor.separatorColor
}

#endif
