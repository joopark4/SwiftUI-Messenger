//
//  MediaProgressBarSection.swift
//  ChatModuleMessengerChatRoomUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Media ProgressBar Section
///
/// ChatRoom prototype > Messenger 대화 > 이미지 상세보기 - 메시지 눌러서 보기
///
///
/// Usage:
///
///     MediaProgressBarSection(icon: "photo", title: "225KB", subTitle: "눌러서 보기")
///         .environmentObject(ThemeManager())
///         .background(Color.blue)
///         .previewLayout(.sizeThatFits)
///
///     MediaProgressBarSection(icon: "xmark", progress: 0.2, title: "203.00/255KB")
///         .environmentObject(ThemeManager())
///         .background(Color.blue)
///         .previewLayout(.sizeThatFits)
///
///     MediaProgressBarSection(icon: "checkmark", title: "225KB")
///         .environmentObject(ThemeManager())
///         .background(Color.blue)
///         .previewLayout(.sizeThatFits)
///
///     MediaProgressBarSection(icon: "play.fill", title: "0:25")
///         .environmentObject(ThemeManager())
///         .background(Color.blue)
///         .previewLayout(.sizeThatFits)
///     
///
public struct MediaProgressBarSection: View {
    @EnvironmentObject var tm: ThemeManager
    var icon: String
    var progress: CGFloat?
    var title: String
    var subTitle: String?
    var onClick: (() -> Void)?
    
    
    /// Create MediaProgressBarSection
    /// - Parameters:
    ///   - icon: system icon name
    ///   - progress: progress percent (Float)
    ///   - title: title text
    ///   - subTitle: subtitle text
    ///   - onClick: progress onClickc event
    public init(icon: String, progress: CGFloat? = nil, title: String, subTitle: String? = nil, onClick: (() -> Void)? = nil) {
        self.icon = icon
        self.progress = progress
        self.title = title
        self.subTitle = subTitle
        self.onClick = onClick
    }
    
    public var body: some View {
        Button {
            if let onClick = onClick {
                onClick()
            }
        } label: {
            LoadInfoBigComponent(icon: mediaIcon, progress: mediaProgress, title: mediaTitle)
        }
    }
    
    private var mediaIcon: some View {
        Image(systemName: icon)
            .font(.system(size: 31))
            .foregroundColor(.white)
    }
    
    @ViewBuilder
    private var mediaProgress: some View {
        if progress != nil {
            Circle()
                .trim(from: 0, to: progress ?? 0)
                .stroke(.white, lineWidth: 6)
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
            Text(title)
                .foregroundColor(.white)
                .font(tm.typo.subheadline)
            
            if let subTitle = subTitle {
                Text(subTitle)
                    .foregroundColor(.white)
                    .font(tm.typo.subheadline)
            }
        }
    }
}

#if DEBUG
struct MediaProgressBarSection_Previews: PreviewProvider {
    static var previews: some View {
        MediaProgressBarSection(icon: "photo", title: "225KB", subTitle: "눌러서 보기")
            .environmentObject(ThemeManager())
            .background(Color.blue)
            .previewLayout(.sizeThatFits)
        
        MediaProgressBarSection(icon: "xmark", progress: 0.2, title: "203.00/255KB")
            .environmentObject(ThemeManager())
            .background(Color.blue)
            .previewLayout(.sizeThatFits)
        
        MediaProgressBarSection(icon: "checkmark", title: "225KB")
            .environmentObject(ThemeManager())
            .background(Color.blue)
            .previewLayout(.sizeThatFits)
        
        MediaProgressBarSection(icon: "play.fill", title: "0:25")
            .environmentObject(ThemeManager())
            .background(Color.blue)
            .previewLayout(.sizeThatFits)
    }
}
#endif
