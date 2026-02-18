//
//  RecentSearchesListSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

public struct RecentSearchesListSection: View {
    @EnvironmentObject var tm: ThemeManager

    public var body: some View {
        HStack(alignment: .top, spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Button(action: {
                        print("search text")
                    }, label: {
                        ChipImageTextCancelSection(isProfile: false, text: "icon", isDeleteButton: true)
                    })
                    Button(action: {
                        print("search text")
                    }, label: {
                        ChipImageTextCancelSection(isProfile: true, text: "chatmodule", isDeleteButton: true)
                    })
                    Button(action: {
                        print("search text")
                    }, label: {
                        ChipImageTextCancelSection(isProfile: false, text: "이모티콘", isDeleteButton: true)
                    })
                    Button(action: {
                        print("search text")
                    }, label: {
                        ChipImageTextCancelSection(isProfile: false, text: "챗", isDeleteButton: true)
                    })
                    Button(action: {
                        print("search text")
                    }, label: {
                        ChipImageTextCancelSection(isProfile: true, text: "모듈", isDeleteButton: true)
                    })
                }
                .padding(.leading, 8)
            }
        }
    }
}

#if DEBUG
struct RecentSearchesListSection_Previews: PreviewProvider {
    static var previews: some View {
        RecentSearchesListSection()
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
