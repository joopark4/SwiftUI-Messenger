//
//  ContentForwardingSelectionTabSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI

struct ContentForwardingSelectionTabSection: View {

    @Binding var selectTabItem: Int
    @Binding var hiddenCheckFriendList: Bool

    init(selectTabItem: Binding<Int>, hiddenCheckFriendList: Binding<Bool>) {
        _selectTabItem = selectTabItem
        _hiddenCheckFriendList = hiddenCheckFriendList
    }

    var body: some View {
        VStack {
            ContentForwardingSelectionTabItemSection(selectItem: $selectTabItem)
                .padding(EdgeInsets(top: 8, leading: 18, bottom: 0, trailing: 18))

            if !hiddenCheckFriendList {
                currentTab
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
            }
        }
    }

    @ViewBuilder
    private var currentTab: some View {
        switch selectTabItem {
        case 0:
            FriendsSelectionHorizontalListSection()

        default:
            RoomSelectionHorizontalListSection()
        }
    }
}

struct ContentForwardingSelectionTabSection_Previews: PreviewProvider {
    static var previews: some View {
        ContentForwardingSelectionTabSection(selectTabItem: .constant(0), hiddenCheckFriendList: .constant(false))
    }
}
