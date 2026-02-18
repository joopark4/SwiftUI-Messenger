//
//  EmoticonThumbnailComponent.swift
//  ChatModuleMessengerUI
//

import SwiftUI

/// Emoticon Thumbnail
///
/// Customize components > Emoticon Thumbnail
///
///
/// Usage:
///
///       EmoticonThumbnailComponent(emoticon: Image(systemName: "trash"),
///       title: Text("신규 이모티콘 인플루언서..."))
///
public struct EmoticonThumbnailComponent<Emoticon: View, Title: View>: View {
    @EnvironmentObject var tm: ThemeManager
    
    private let emoticon: Emoticon
    private let title: Title
    
    
    /// Emoticon Thumbnail
    /// - Parameters:
    ///   - emoticon: emoticon area
    ///   - title: title area
    public init(emoticon: Emoticon, title: Title) {
        self.emoticon = emoticon
        self.title = title
    }
    
    public var body: some View {
        VStack(spacing: 4) {
            emoticon
            
            title
        }
    }
}

#if DEBUG
struct EmoticonThumbnailComponent_Previews: PreviewProvider {
    static var previews: some View {
        EmoticonThumbnailComponent(emoticon: Image(systemName: "trash"), title: Text("신규 이모티콘 인플루언서..."))
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
