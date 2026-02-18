//
//  LoadInfoBigComponent.swift
//  ChatModuleMessengerUI
//

import SwiftUI

/// LoadInfo Big Component
///
/// Customize components > chat info text
///
///
/// Usage:
///
///     LoadInfoBigComponent(icon: Image(systemName: "photo"),
///         progress: Rectangle()
///         .frame(width: 68, height: 68)
///         .foregroundColor(Color.gray)
///         .mask(Circle()),
///         title: Text("눌러서 보기"))
///
public struct LoadInfoBigComponent<Icon: View, Progress: View, Title: View>: View {
    @EnvironmentObject var tm: ThemeManager
    var icon: Icon
    var progress: Progress
    var title: Title

    
    /// Create LoadInfoBigComponent
    /// - Parameters:
    ///   - icon: icon area
    ///   - progress: progress area
    ///   - title: title text area
    public init(icon: Icon, progress: Progress, title: Title) {
        self.icon = icon
        self.progress = progress
        self.title = title
    }

    public var body: some View {
        VStack(spacing: 0) {
            ZStack {
                progress
                icon
            }
            .frame(width: 68, height: 68)
            
            title
                .padding(.top, 4)
        }
    }
}

#if DEBUG
struct LoadInfoBigComponent_Previews: PreviewProvider {
    static var previews: some View {
        LoadInfoBigComponent(icon: Image(systemName: "photo"),
                             progress: Rectangle()
                                .foregroundColor(Color.gray)
                                .mask(Circle()),
                             title: Text("눌러서 보기"))
        .previewLayout(.sizeThatFits)
        .environmentObject(ThemeManager())
    }
}
#endif
