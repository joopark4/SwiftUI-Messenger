//
//  RecentSearchesBarSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

public struct RecentSearchesBarSection: View {
    @EnvironmentObject var tm: ThemeManager

    public var body: some View {
        SubTitleBar2Component(title: tm.lang.localized("Search.RecentSearch"),
                              leftButton: leftButton,
                              rightButton: rightButton,
                              trailingImage: EmptyView(), isShowDivider: true)
            .background(tm.theme.systemBackground)
    }

    private var leftButton: some View {
        Button(action: {

        }, label: {
            Text(tm.lang.localized("Search.RecentSearch.RemoveAll"))
                .font(tm.typo.footnote)
                .foregroundColor(tm.theme.labelColorPrimary)
        })
    }

    private var rightButton: some View {
        Button(action: {

        }, label: {
            Text(tm.lang.localized("Search.RecentSearch.AutoSaveOn"))
                .font(tm.typo.footnote)
                .foregroundColor(tm.theme.labelColorPrimary)
        })
    }
}

#if DEBUG
struct RecentSearchesBarSection_Previews: PreviewProvider {
    static var previews: some View {
        RecentSearchesBarSection()
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
