//
//  EmoticonGroupItemSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Chat Message Emoticon Group  Item
///
/// Messengaer 대화방 > 이모티콘 메시지 입력
///
///
/// Usage:
///
///      EmoticonGroupItemSection(emoticonInfo: EmoticonInfo(id: "1", version: 1, name: "name", index: 1, urlOn: "", urlOff: "", useYn: 1, items: [EmoticonItemInfo(id: "1", emoticonInfoId: "1", name: "emo1", url: "", nameThumb: "", urlThumb: "")]), checked: true)
///
public struct EmoticonGroupItemSection: View {
    @EnvironmentObject var tm: ThemeManager
    var emoticonInfo: EmoticonInfo
    var checked: Bool
    
    
    /// Create Chat Message Emoticon Group  Item
    /// - Parameters:
    ///   - emoticonInfo: emoticon info
    ///   - checked: checked
    public init(emoticonInfo: EmoticonInfo, checked: Bool) {
        self.emoticonInfo = emoticonInfo
        self.checked = checked
    }
    
    public var body: some View {
        //TODO: Check test로 임시로 넣어둠
        //TODO: Check 상태에 따라 urlOn/urlOff url로 이미지 변경 필요
        ZStack {
            self.checked ? tm.theme.labelColorQuarternary : Color.clear
            
            if emoticonInfo.index == 2 {
                Image(self.checked ? "chatServiceGroupItemSmileMeOn" : "chatServiceGroupItemOff", bundle: .module)
                    .frame(width: 33, height: 30)
                    .foregroundColor(self.checked ? Color.red : Color.yellow)
            } else {
                Image(self.checked ? "chatServiceGroupItemOn" : "chatServiceGroupItemOff", bundle: .module)
                    .frame(width: 33, height: 30)
                    .foregroundColor(self.checked ? Color.red : Color.yellow)
            }
        }
        .frame(width: 47, height: 40)
    }
}


#if DEBUG
struct EmoticonGroupItemSection_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            EmoticonGroupItemSection(emoticonInfo: EmoticonInfo(id: "1", version: 1, name: "name", index: 1, urlOn: "", urlOff: "", useYn: 1, items: [EmoticonItemInfo(id: "1", emoticonInfoId: "1", name: "emo1", url: "", nameThumb: "", urlThumb: "")]), checked: true)
                
            
            EmoticonGroupItemSection(emoticonInfo: EmoticonInfo(id: "1", version: 1, name: "name", index: 1, urlOn: "", urlOff: "", useYn: 1, items: [EmoticonItemInfo(id: "1", emoticonInfoId: "1", name: "emo1", url: "", nameThumb: "", urlThumb: "")]), checked: false)
                
        }
        .environmentObject(ThemeManager())
        .previewLayout(.sizeThatFits)
    }
}
#endif
