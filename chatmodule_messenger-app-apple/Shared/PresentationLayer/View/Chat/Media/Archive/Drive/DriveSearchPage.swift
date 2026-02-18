//
//  DriveSearchPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerRelationshipFriendsUI

struct DriveSearchPage: View {
    var body: some View {
        VStack {

            DriveSearchBarSection()
            Spacer()

            ScrollView(.vertical, showsIndicators: false) {
                SearchSendFriendSubTitleItemSection()

                ForEach(0..<5) { data in
                    SearchSendFriendItemSection(title: "\(data)")
                }
            }
        }
    }
}

struct DriveSearchPage_Previews: PreviewProvider {
    static var previews: some View {
        DriveSearchPage()
    }
}
