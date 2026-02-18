//
//  Typography.swift
//  ChatModuleMessengerUI
//

import SwiftUI

/// 폰트 적용을 위한 struct
public struct Typography {
    /// Typography.Types
    ///
    /// basic(default), chatmodule, ...
    /// 
    /// chatmodule의 경우 아직 폰트가 따로 나오지 않음
    public enum Types: String {
        case basic
        case chatmodule = "EuphemiaUCAS-Italic"
    }

    /// 사용할 폰트 타입
    public var types: Types

    /// create Typography
    /// - Parameter types: 폰트 타입 (기본값 .basic)
    public init(types: Types = .basic) {
        self.types = types
    }

    // MARK: - TypeFont
    public var largeTitle: Font {
        switch types {
        case .basic:
            return Font.largeTitle
        case .chatmodule:
            return Font.custom(types.rawValue, size: 34).weight(.regular)
        }
    }

    public var title: Font {
        switch types {
        case .basic:
            return Font.title
        case .chatmodule:
            return Font.custom(types.rawValue, size: 28).weight(.regular)
        }
    }

    public var title2: Font {
        switch types {
        case .basic:
            return Font.title2
        case .chatmodule:
            return Font.custom(types.rawValue, size: 22).weight(.regular)
        }
    }

    public var title3: Font {
        switch types {
        case .basic:
            return Font.title3
        case .chatmodule:
            return Font.custom(types.rawValue, size: 20).weight(.regular)
        }
    }

    public var headline: Font {
        switch types {
        case .basic:
            return Font.headline
        case .chatmodule:
            return Font.custom(types.rawValue, size: 17).weight(.semibold)
        }
    }

    public var body: Font {
        switch types {
        case .basic:
            return Font.body
        case .chatmodule:
            return Font.custom(types.rawValue, size: 17).weight(.regular)
        }
    }

    public var callout: Font {
        switch types {
        case .basic:
            return Font.callout
        case .chatmodule:
            return Font.custom(types.rawValue, size: 16).weight(.regular)
        }
    }

    public var subheadline: Font {
        switch types {
        case .basic:
            return Font.subheadline
        case .chatmodule:
            return Font.custom(types.rawValue, size: 15).weight(.regular)
        }
    }

    public var footnote: Font {
        switch types {
        case .basic:
            return Font.footnote
        case .chatmodule:
            return Font.custom(types.rawValue, size: 13).weight(.regular)
        }
    }

    public var caption: Font {
        switch types {
        case .basic:
            return Font.caption
        case .chatmodule:
            return Font.custom(types.rawValue, size: 12).weight(.regular)
        }
    }

    public var caption2: Font {
        switch types {
        case .basic:
            return Font.caption2
        case .chatmodule:
            return Font.custom(types.rawValue, size: 11).weight(.regular)
        }
    }

}
