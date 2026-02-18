//
//  EmoticonStyleItemSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

public struct EmoticonStyleItemSection: View {
    @EnvironmentObject var tm: ThemeManager

    public var body: some View {
        EmoticonThumbnailComponent(emoticon: emoticon, title: title)
        .frame(width: 96, height: 140)
    }

    private var emoticon: some View {
        ZStack {
            tm.theme.fillColorSecondary

            Image("visual02")
                .resizable()
                .frame(width: 60, height: 60)

        }
        .cornerRadius(8)
    }

    private var title: some View {
        Text("신규 이모티콘 인플루언서...")
            .font(tm.typo.footnote)
            .foregroundColor(tm.theme.labelColorPrimary)
            .frame(height: 40)
            .padding(.horizontal, 7)
    }
}

#if DEBUG
struct EmoticonStyleItemSection_Previews: PreviewProvider {
    static var previews: some View {
        EmoticonStyleItemSection()
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
