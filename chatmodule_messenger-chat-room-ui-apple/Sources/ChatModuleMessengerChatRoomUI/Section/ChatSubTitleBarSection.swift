//
//  ChatSubTitleBarSection.swift
//  ChatModuleMessengerChatRoomUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Chat Room Setting Avata Section
///
/// Chat prototype > Messenger 대화 > 대화방 설정 > chat setting1
///
///
/// Usage:
///
///     ChatSubTitleBarSection(subTitle1: "", subTitle2: "대화")
///
public struct ChatSubTitleBarSection: View {
    @EnvironmentObject var tm: ThemeManager
    let subTitle1: String?
    let subTitle2: String?

    /// Crete ChatSubTitleBarSection
    /// - Parameters:
    ///   - subTitle1: Subtitle1
    ///   - subTitle2: Subtitle2
    public init(subTitle1: String? = nil, subTitle2: String? = nil) {
        self.subTitle1 = subTitle1
        self.subTitle2 = subTitle2
    }

    public var body: some View {
        SubTitleBar(title: subTitle1, subTitle: subTitle2)
    }
}

#if DEBUG
struct ChatSubTitleBarSection_Previews: PreviewProvider {
    static var previews: some View {
        ChatSubTitleBarSection(subTitle1: "", subTitle2: "대화")
            .environmentObject(ThemeManager())
    }
}
#endif
