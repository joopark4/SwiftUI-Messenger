//
//  SearchTitleBarSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

public struct SearchTitleBarSection: View {
    @EnvironmentObject var tm: ThemeManager

    private let title: String

    public init(title: String) {
        self.title = title
    }

    public var body: some View {
        SubTitleBar2Component(title: title,
                              leftButton: EmptyView(),
                              rightButton: EmptyView(),
                              trailingImage: EmptyView())
            .background(tm.theme.systemBackground)
    }
}

#if DEBUG
struct KeywordBarSection_Previews: PreviewProvider {
    static var previews: some View {
        SearchTitleBarSection(title: "추천 키워드")
            .environmentObject(ThemeManager())
    }
}
#endif
