//
//  Image+Extension.swift
//  ChatModuleMessengerUI
//

import SwiftUI
#if os(macOS)
import Cocoa
public typealias UIImage = NSImage
#else
import UIKit
#endif

extension Image {
    public static func profileImage(_ uiImage: UIImage? = nil) -> Image {
        if let uiImage = uiImage {
            #if os(macOS)
            return Image(nsImage: uiImage)
            #else
            return Image(uiImage: uiImage)
            #endif
        } else {
            return Image(systemName: "person.circle.fill")
        }
    }
}
