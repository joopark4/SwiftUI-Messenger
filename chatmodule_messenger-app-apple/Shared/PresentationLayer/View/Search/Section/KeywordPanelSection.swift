//
//  KeywordPanelSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

public struct KeywordPanelSection: View {
    @EnvironmentObject var tm: ThemeManager

    public var body: some View {
        VStack(spacing: 0) {

            VStack {
                SearchTitleBarSection(title: tm.lang.localized("Search.Keyword"))
                    .padding(.top, 8)
            }
            .frame(height: 45)

            HStack {
                ChipTextOnlyListSection()
                Spacer()
            }
            .padding(.leading, 8)
            .padding(.bottom, 16)
        }
        .background(tm.theme.systemBackground)
        .cornerRadius(8)
        .padding(.horizontal, 8)
    }
}

#if DEBUG
struct KeywordPanelSection_Previews: PreviewProvider {
    static var previews: some View {
        KeywordPanelSection()
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
