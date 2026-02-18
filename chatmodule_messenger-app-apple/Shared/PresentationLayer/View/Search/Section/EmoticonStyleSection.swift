//
//  EmoticonStyleSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

struct EmoticonStyleSection: View {
    @EnvironmentObject var tm: ThemeManager

    var body: some View {
        VStack(spacing: 0) {

            VStack {
                SearchTitleBarSection(title: tm.lang.localized("Search.EmoticonRecommend"))
                    .padding(.top, 8)
            }
            .frame(height: 45)

            EmoticonStyleListSection()
                .padding(.bottom, 16)
        }
        .background(tm.theme.systemBackground)
        .cornerRadius(8)
        .padding(.horizontal, 8)
    }
}

struct EmoticonStyleSection_Previews: PreviewProvider {
    static var previews: some View {
        EmoticonStyleSection()
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
