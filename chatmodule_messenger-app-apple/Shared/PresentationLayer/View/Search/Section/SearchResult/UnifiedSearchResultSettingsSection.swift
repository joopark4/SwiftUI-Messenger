//
//  UnifiedSearchResultSettingsSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

struct UnifiedSearchResultSettingsSection: View {
    @EnvironmentObject var tm: ThemeManager

    var body: some View {
        VStack(spacing: 0) {

            VStack {
                SearchTitleBarSection(title: tm.lang.localized("Search.Result.Setting"))
            }
            .frame(height: 37)

            UnifiedSearchResultSettingsListSection()
        }
        .background(tm.theme.systemBackground)
        .cornerRadius(8)
        .padding(.horizontal, 8)
    }
}

#if DEBUG
struct UnifiedSearchResultSettingsSection_Previews: PreviewProvider {
    static var previews: some View {
        UnifiedSearchResultSettingsSection()
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
