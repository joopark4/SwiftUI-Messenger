//
//  UnifiedSearchResultSettingsListSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

struct UnifiedSearchResultSettingsListSection: View {
    @EnvironmentObject var tm: ThemeManager

    var body: some View {
        VStack(spacing: 0) {
            Button(action: {}, label: {
                UnifiedSearchResultSettingsItemSection(title: "Setting 01")
                    .frame(height: 28)
                    .padding(.top, 10)
            })

            Button(action: {}, label: {
                UnifiedSearchResultSettingsItemSection(title: "Setting 02")
                    .frame(height: 28)
                    .padding(.top, 10)
            })

            Button(action: {}, label: {
                UnifiedSearchResultSettingsItemSection(title: "Setting 03")
                    .frame(height: 28)
                    .padding(.top, 10)
            })
        }
        .padding(.bottom, 16)
        .background(tm.theme.systemBackground)
    }
}

#if DEBUG
struct UnifiedSearchResultSettingsListSection_Previews: PreviewProvider {
    static var previews: some View {
        UnifiedSearchResultSettingsListSection()
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
