//
//  EmoticonItemSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI

/// Chat Message Emoticon Item
///
/// Messengaer 대화방 > 이모티콘 메시지 입력
///
///
/// Usage:
///
///      EmoticonItemSection(emoticonItemInfo: EmoticonItemInfo(id: "1", emoticonInfoId: "1", name: "emo1", url: "", nameThumb: "", urlThumb: ""))
///
public struct EmoticonItemSection: View {
    var emoticonItemInfo: EmoticonItemInfo
    
    
    /// Create Chat Message Emoticon Item
    /// - Parameter emoticonItemInfo: emoticon info
    public init(emoticonItemInfo: EmoticonItemInfo) {
        self.emoticonItemInfo = emoticonItemInfo
    }
    
    public var body: some View {
        //TODO: url로 이미지 표시 필요
        Image("chatServiceItem", bundle: .module)
            .frame(width: 50, height: 50)
    }
}

#if DEBUG
struct EmoticonItemSection_Previews: PreviewProvider {
    static var previews: some View {
        EmoticonItemSection(emoticonItemInfo: EmoticonItemInfo(id: "1", emoticonInfoId: "1", name: "emo1", url: "", nameThumb: "", urlThumb: ""))
            .previewLayout(.sizeThatFits)
    }
}
#endif
