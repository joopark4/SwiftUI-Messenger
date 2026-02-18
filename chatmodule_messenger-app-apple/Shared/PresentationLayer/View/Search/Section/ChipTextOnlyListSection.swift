//
//  ChipTextOnlyListSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

public struct ChipTextOnlyListSection: View {
    @EnvironmentObject var tm: ThemeManager

    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: { }, label: {
                    ChipImageTextCancelSection(isProfile: false, text: "keyword", isDeleteButton: false)
                })

                Button(action: { }, label: {
                    ChipImageTextCancelSection(isProfile: false, text: "이모티콘", isDeleteButton: false)
                })

                Button(action: { }, label: {
                    ChipImageTextCancelSection(isProfile: false, text: "챗", isDeleteButton: false)
                })

                Button(action: { }, label: {
                    ChipImageTextCancelSection(isProfile: false, text: "모듈", isDeleteButton: false)
                })
            }

            HStack {
                Button(action: { }, label: {
                    ChipImageTextCancelSection(isProfile: false, text: "iOS", isDeleteButton: false)
                })

                Button(action: { }, label: {
                    ChipImageTextCancelSection(isProfile: false, text: "Android", isDeleteButton: false)
                })

                Button(action: { }, label: {
                    ChipImageTextCancelSection(isProfile: false, text: "body text", isDeleteButton: false)
                })

                Button(action: { }, label: {
                    ChipImageTextCancelSection(isProfile: false, text: "text", isDeleteButton: false)
                })
            }
        }
    }
}

#if DEBUG
struct ChipTextOnlyListSection_Previews: PreviewProvider {
    static var previews: some View {
        ChipTextOnlyListSection()
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
