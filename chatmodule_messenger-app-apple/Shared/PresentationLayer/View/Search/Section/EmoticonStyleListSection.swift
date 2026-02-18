//
//  EmoticonStyleListSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

public struct EmoticonStyleListSection: View {
    @EnvironmentObject var tm: ThemeManager

    public var body: some View {
        HStack(alignment: .top, spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Button(action: {
                        print("click emoticon")
                    }, label: {
                        EmoticonStyleItemSection()
                    })
                    Button(action: {
                        print("click emoticon")
                    }, label: {
                        EmoticonStyleItemSection()
                    })
                    Button(action: {
                        print("click emoticon")
                    }, label: {
                        EmoticonStyleItemSection()
                    })
                    Button(action: {
                        print("click emoticon")
                    }, label: {
                        EmoticonStyleItemSection()
                    })
                    Button(action: {
                        print("click emoticon")
                    }, label: {
                        EmoticonStyleItemSection()
                    })
                }
                .padding(.leading, 16)
            }
        }
    }
}

#if DEBUG
struct EmoticonStyleListSection_Previews: PreviewProvider {
    static var previews: some View {
        EmoticonStyleListSection()
            .environmentObject(ThemeManager())
    }
}
#endif
