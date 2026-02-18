//
//  MessageMediaProgressBarSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Message Media ProgressBar Section
///
/// ChatRoom prototype > Messenger 대화방 - 메시지
///
///
/// Usage:
///
///     MessageMediaProgressBarSection(icon: "photo",
///                                    progress: 0.75,
///                                    title: "223.00/225KB",
///                                    subTitle: "눌러서 보기")
///
///
public struct MessageMediaProgressBarSection: View {
    @EnvironmentObject var tm: ThemeManager
    var icon: String
    var progress: CGFloat?
    var title: String?
    var subTitle: String?
    var onClick: (() -> Void)?

    /// Create MessageMediaProgressBarSection
    ///
    /// - Parameters:
    ///   - icon: system icon name
    ///   - progress: progress percent (Float)
    ///   - title: title text
    ///   - subTitle: subtitle text
    ///   - onClick: progress onClick event
    public init(icon: String,
                progress: CGFloat? = nil,
                title: String? = nil,
                subTitle: String? = nil,
                onClick: (() -> Void)? = nil) {
        self.icon = icon
        self.progress = progress
        self.title = title
        self.subTitle = subTitle
        self.onClick = onClick
    }

    public var body: some View {
        Button {
            onClick?()
        } label: {
            LoadInfoComponent(icon: mediaIcon,
                              progress: mediaProgress,
                              title: mediaTitle)
        }
    }

    private var mediaIcon: some View {
        Image(systemName: icon)
            .font(.system(size: 20))
            .foregroundColor(.white)
    }

    @ViewBuilder
    private var mediaProgress: some View {
        if let progress = progress {
            Circle()
                .trim(from: 0, to: progress)
                .stroke(.white, lineWidth: 8)
                .background(tm.theme.backgroundInfoSelect)
                .mask(Circle())
                .rotationEffect(.degrees(-90))
        } else {
            Circle()
                .stroke(.white, lineWidth: 1)
                .background(tm.theme.backgroundInfoSelect)
                .mask(Circle())
        }
    }

    private var mediaTitle: some View {
        VStack {
            if let title = title {
                Text(title)
                    .foregroundColor(.white)
                    .font(tm.typo.caption)
            }

            if let subTitle = subTitle {
                Text(subTitle)
                    .foregroundColor(.white)
                    .font(tm.typo.caption)
            }
        }
    }
}

#if DEBUG
struct MessageMediaProgressBarSection_Previews: PreviewProvider {
    static var previews: some View {
        MessageMediaProgressBarSection(icon: "photo",
                                       progress: 0.75,
                                       title: "223.00/225KB",
                                       subTitle: "눌러서 보기")
            .environmentObject(ThemeManager())
            .background(Color.gray)
            .previewLayout(.sizeThatFits)

    }
}
#endif
