//
//  Environment+Extension.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import SwiftUI

public extension EnvironmentValues {
    /// 현재 프로세스가 Preview인지 구분
    var isPreview: Bool {
        #if DEBUG
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        #else
        return false
        #endif
    }
}
