//
//  DebugUtil.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import SwiftUI

func debugLog(_ message: Any = "",
              filename: String = #file,
              line: Int = #line,
              funcname: String = #function) {
    #if DEBUG
    let classname = URL(string: filename)?.deletingPathExtension().lastPathComponent ?? filename
    print("[\(classname):\(line)][\(funcname)] \(message)")
    #endif
}

extension View {
    func debugPrint(_ value: Any) -> Self {
        debugClosure {
            print(value)
        }
    }

    func debugClosure(_ closure: () -> Void) -> Self {
        #if DEBUG
        closure()
        #endif

        return self
    }

    func debugBorder(_ color: Color = .red, width: CGFloat = 1) -> some View {
        debugModifier {
            $0.border(color, width: width)
        }
    }

    func debugBackground(_ color: Color = .red) -> some View {
        debugModifier {
            $0.background(color)
        }
    }

    func debugModifier<T: View> (_ modifier: (Self) -> T) -> some View {
        #if DEBUG
        return modifier(self)
        #else
        return self
        #endif
    }
}
