//
//  UnifiedSearchResultTabBarSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

struct UnifiedSearchResultTabBarSection: View {
    @EnvironmentObject var tm: ThemeManager

    @Binding var unifiedSearchType: UnifiedSearchType

    public init(unifiedSearchType: Binding<UnifiedSearchType>) {
        _unifiedSearchType = unifiedSearchType
    }

    var body: some View {
        VStack {
            Picker(selection: $unifiedSearchType) {
                Text(tm.lang.localized("Search.Result.All")).tag(UnifiedSearchType.ALL)
                Text(tm.lang.localized("Search.Result.Friend")).tag(UnifiedSearchType.FRIEND)
                Text(tm.lang.localized("Search.Result.ChatRoom")).tag(UnifiedSearchType.CHAT)
                Text(tm.lang.localized("Search.Result.Setting")).tag(UnifiedSearchType.SETTING)
            } label: {}
            .font(.system(size: 13))
            .pickerStyle(.segmented)
        }
        .padding(.horizontal, 8)
    }
}

#if DEBUG
struct UnifiedSearchResultTabBarSection_Previews: PreviewProvider {
    static var previews: some View {
        UnifiedSearchResultTabBarSection(unifiedSearchType: .constant(UnifiedSearchType.ALL))
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
