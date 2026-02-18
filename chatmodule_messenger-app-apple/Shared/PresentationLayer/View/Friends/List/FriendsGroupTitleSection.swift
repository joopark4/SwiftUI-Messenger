//
//  FriendsGroupTitleSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

/// Friends Group Title Section
///
/// Friends prototype > Messenger 친구 목록
///
///
/// Usage:
///
///      FriendsGroupTitleSection(title: "즐겨찾기",
///                               isExpand: .constant(true))
///
struct FriendsGroupTitleSection: View {
    @EnvironmentObject var tm: ThemeManager

    let title: String
    @Binding var isExpand: Bool

    /// Create FriendsGroupTitleSection
    ///
    /// - Parameters:
    ///   - title: title string
    ///   - isExpand: expand state
    init(title: String,
         isExpand: Binding<Bool> = .constant(true)) {
        self.title = title
        _isExpand = isExpand
    }

    var body: some View {
        VStack(spacing: 0) {
            Divider()
            SubTitleBar(title: title) {
                Image(systemName: isExpand ? "chevron.up" : "chevron.down")
                    .font(.system(size: 15))
                    .onTapGesture {
                        self.isExpand.toggle()
                    }
            }
            .padding(.vertical, 8)
        }
        .listRowInsets(EdgeInsets())
    }
}

struct FriendsGroupTitleSection_Previews: PreviewProvider {
    static var previews: some View {
        FriendsGroupTitleSection(title: "친구 1",
                                 isExpand: .constant(true))
        .environmentObject(ThemeManager())
        .previewLayout(.sizeThatFits)
    }
}
