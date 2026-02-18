//
//  UnifiedSearchResultSettingsItemSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

struct UnifiedSearchResultSettingsItemSection: View {
    @EnvironmentObject var tm: ThemeManager

    private var title: String

    init(title: String) {
        self.title = title
    }

    var body: some View {

        ListItemHalfMobileLeftIconComponent(leftIconBox: settingIcon, iconText: settingTtitle, rightIconBox: EmptyView())
    }

    private var settingIcon: some View {
        ZStack {
            Circle()
                .foregroundColor(tm.theme.systemGray)
                .frame(width: 28, height: 28)

            Image(systemName: "gear")
                .foregroundColor(Color.white)
                .font(.system(size: 11))
        }
    }

    private var settingTtitle: some View {
        Text(title)
            .foregroundColor(tm.theme.labelColorPrimary)
            .font(tm.typo.headline)
    }
}

#if DEBUG
struct UnifiedSearchResultSettingsItemSection_Previews: PreviewProvider {
    static var previews: some View {
        UnifiedSearchResultSettingsItemSection(title: "Setting 01")
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
