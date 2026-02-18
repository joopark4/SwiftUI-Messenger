//
//  RoomFileArchiveInfoItemSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

/// Room File Archive Info Item Section
///
/// 대화(Chat), 대화방 서랍, 톡서랍
///
///
/// - Author: trowa

public struct RoomFileArchiveInfoItemSection: View {
    @State public var count: Int
    @State public var size: String

    public var body: some View {
        SubTitleBar(title: "\(count) / \(size)")
    }
}

struct RoomFileArchiveInfoItemSection_Previews: PreviewProvider {
    static var previews: some View {
        RoomFileArchiveInfoItemSection(count: 7, size: "235MB")
    }
}
