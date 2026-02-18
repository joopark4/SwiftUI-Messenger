//
//  RoomArchiveSubTitleItemSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

public struct RoomArchiveSubTitleItemSection: View {
    private let date: String

    init(date: String) {
        self.date = date
    }

    public var body: some View {
        SubTitleBar(subTitle: date)
    }
}

struct RoomFileArchiveSubTitleItemSection_Previews: PreviewProvider {
    static var previews: some View {
        RoomArchiveSubTitleItemSection(date: "2025-02-22")
    }
}
