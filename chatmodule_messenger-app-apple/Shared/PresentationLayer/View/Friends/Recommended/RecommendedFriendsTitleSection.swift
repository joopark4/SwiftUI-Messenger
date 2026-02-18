//
//  RecommendedFriendsTitleSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

struct RecommendedFriendsTitleSection: View {
    @EnvironmentObject var tm: ThemeManager

    let title: String

    var body: some View {
        SubTitleBar(title: title)
            .padding(.vertical, 8)
            .listRowInsets(EdgeInsets())
    }
}

struct RecommendedFriendsTitleSection_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedFriendsTitleSection(title: "추천친구")
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
