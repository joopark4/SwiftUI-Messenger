//
//  NewFriendsGroupTitleSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

/// New Friends Group Title Section
///
/// Friends prototype > Messenger 친구 목록
///
///
/// Usage:
///
///     NewFriendsGroupTitleSection(title: "즐겨찾기",
///                                       isExpand: .constant(true))
///
struct NewFriendsGroupTitleSection: View {
    @EnvironmentObject var tm: ThemeManager

    let title: String
    @Binding var isExpand: Bool

    /// Create NewFriendsGroupTitleSection
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

struct NewFriendsGroupTitleSection_Previews: PreviewProvider {
    static var previews: some View {
        NewFriendsGroupTitleSection(title: "새로운 친구",
                                          isExpand: .constant(true))
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
