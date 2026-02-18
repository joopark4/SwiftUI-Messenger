//
//  EmoticonItemPreviewSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import ChatModuleMessengerUI


/// Chat Message Emoticon Item  Preview
///
/// Messengaer 대화방 > 이모티콘 메시지 미리보기
///
///
/// Usage:
///
///      EmoticonItemPreviewSection(emoticonItemInfo: EmoticonItemInfo(id: "1", emoticonInfoId: "1", name: "emo1", url: "", nameThumb: "", urlThumb: ""), closePreview: {
///      })
///
public struct EmoticonItemPreviewSection: View {
    @EnvironmentObject var tm: ThemeManager
    var emoticonItemInfo: EmoticonItemInfo
    var closePreview: () -> Void
    
    
    /// Create Chat Message Emoticon Item Preview
    /// - Parameters:
    ///   - emoticonItemInfo: emoticon info
    ///   - closePreview: preview close closure
    public init(emoticonItemInfo: EmoticonItemInfo, closePreview: @escaping () -> Void) {
        self.emoticonItemInfo = emoticonItemInfo
        self.closePreview = closePreview
    }
    
    public var body: some View {
        HStack {
            VStack {
                Button(action: {
                    
                }, label: {
                    Image(systemName: "star.fill")
                        .font(.system(size: 24))
                        .frame(width: 28, height: 28)
                        .foregroundColor(.white)
                })
                
                Spacer()
            }
            .padding([.top, .leading], 8)
            
            Spacer()
            
            Image("chatServiceItem", bundle: .module)
                .resizable()
                .frame(width: 100, height: 100)
            
            Spacer()
            
            VStack {
                Button(action: {
                    closePreview()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 24))
                        .frame(width: 28, height: 28)
                        .foregroundColor(.white)
                })
                
                Spacer()
            }
            .padding([.top, .trailing], 8)
        }
        .background(tm.theme.systemFill)
        .frame(height: 120)
    }
}

#if DEBUG
struct EmoticonItemPreviewSection_Previews: PreviewProvider {
    static var previews: some View {
        EmoticonItemPreviewSection(emoticonItemInfo: EmoticonItemInfo(id: "1", emoticonInfoId: "1", name: "emo1", url: "", nameThumb: "", urlThumb: ""), closePreview: {
            
        })
        .environmentObject(ThemeManager())
        .previewLayout(.sizeThatFits)
    }
}
#endif
