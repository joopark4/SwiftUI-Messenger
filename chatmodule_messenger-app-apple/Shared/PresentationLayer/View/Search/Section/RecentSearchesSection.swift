//
//  RecentSearchesSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

public struct RecentSearchesSection: View {
    @EnvironmentObject var tm: ThemeManager

    public var body: some View {
        VStack(spacing: 0) {

            VStack {
                RecentSearchesBarSection()
                    .padding(.top, 8)
            }
            .frame(height: 45)

            RecentSearchesListSection()
            .frame(height: 28)
            .padding(.bottom, 16)
        }
        .background(tm.theme.systemBackground)
        .cornerRadius(8)
        .padding(.horizontal, 8)
    }
}

#if DEBUG
struct RecentSearchesSection_Previews: PreviewProvider {
    static var previews: some View {
        RecentSearchesSection()
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
