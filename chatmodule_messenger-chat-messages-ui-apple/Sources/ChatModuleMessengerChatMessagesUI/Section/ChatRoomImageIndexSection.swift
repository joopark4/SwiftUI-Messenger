//
//  ChatRoomImageIndexSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Chat RoomImageView Index
///
/// Messengaer 대화방 > 묶음 이미지 메시지 상세보기
///
///
/// Usage:
///
///      ChatRoomImageIndexSection()
///
public struct ChatRoomImageIndexSection: View {
    @EnvironmentObject var tm: ThemeManager
    
    let count: Int
    let index: Int
    
    
    /// create chatRoomImageIndexSection
    /// - Parameters:
    ///   - count: total count
    ///   - index: current index
    public init(count: Int, index: Int) {
        self.count = count
        self.index = index
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "photo.fill.on.rectangle.fill")
                .foregroundColor(Color(UIColor.lightGray))
                .font(.system(size: 15))
                .padding(.trailing, 4)
            
            Text("\(count)")
                .font(tm.typo.subheadline)
                .foregroundColor(.white)
            
            Text("장 중 ")
                .font(tm.typo.subheadline)
                .foregroundColor(Color(UIColor.lightGray))
            
            Text("\(index)")
                .font(tm.typo.subheadline)
                .foregroundColor(.white)
            
            Text("번")
                .font(tm.typo.subheadline)
                .foregroundColor(Color(UIColor.lightGray))
        }
        .frame(height: 19)
        .padding(.bottom, 8)
    }
}

#if DEBUG
struct ChatRoomImageIndexSection_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomImageIndexSection(count: 7, index: 1)
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
