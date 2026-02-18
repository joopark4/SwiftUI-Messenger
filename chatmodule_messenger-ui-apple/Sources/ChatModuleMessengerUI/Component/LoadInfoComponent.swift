//
//  LoadInfoComponent.swift
//  ChatModuleMessengerUI
//

import SwiftUI

/// LoadInfo Component
///
/// Customize components > load info
///
///
/// Usage:
///
///     LoadInfoComponent(icon: Image(systemName: "photo"),
///                       progress: Rectangle()
///                                    .frame(width: 68, height: 68)
///                                    .foregroundColor(Color.gray)
///                                    .mask(Circle()),
///                       title: Text("눌러서 보기"))
///
public struct LoadInfoComponent<Icon: View, Progress: View, Title: View>: View {
    @EnvironmentObject var tm: ThemeManager
    var icon: Icon
    var progress: Progress
    var title: Title

    /// Create LoadInfoComponent
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
        VStack(spacing: 4) {
            ZStack {
                progress
                icon.frame(width: 26, height: 26)
            }
            .frame(width: 44, height: 44)

            title
        }
    }
}

#if DEBUG
struct LoadInfoComponent_Previews: PreviewProvider {
    static var previews: some View {
        LoadInfoComponent(icon: Image(systemName: "photo"),
                             progress: Rectangle()
                                .foregroundColor(Color.gray)
                                .mask(Circle()),
                             title: Text("눌러서 보기"))
        .previewLayout(.sizeThatFits)
        .environmentObject(ThemeManager())
    }
}
#endif
