//
//  ChatRoomImageViewNavigationItemSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI

/// Chat RoomImageView NavigationItem
///
/// Messengaer 대화방 > 묶음 이미지 메시지 상세보기
///
///
/// Usage:
///
///      ChatServiceItemSection(data: mediaData)
///
public struct ChatRoomImageViewNavigationItemSection: View {
    // 사진 데이터 필요
    
    public init() {}
    
    public var body: some View {
        Image("chatServiceItem", bundle: .module)
            .resizable()
            .frame(width: 36, height: 48)
            .cornerRadius(2)
    }
}

#if DEBUG
struct ChatRoomImageViewNavigationItemSection_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomImageViewNavigationItemSection()
            .previewLayout(.sizeThatFits)
    }
}
#endif
