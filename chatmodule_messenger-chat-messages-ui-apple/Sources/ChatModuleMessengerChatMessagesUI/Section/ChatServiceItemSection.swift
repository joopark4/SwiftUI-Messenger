//
//  ChatServiceItemSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Chat Message Service Item
///
/// Messengaer 대화방 > 미디어 입력
///
///
/// Usage:
///
///      ChatServiceItemSection(mediaInputInfo: .ALBUM,
///                             iconBackgroundColor: tm.theme.systemGreen)
///
public struct ChatServiceItemSection: View {
    @EnvironmentObject var tm: ThemeManager
    var mediaInputInfo: MediaInputType
    var iconBackgroundColor: Color
    
    
    /// Create Chat Message Service Item
    /// - Parameters:
    ///   - mediaInputInfo: mediaInputInfo
    ///   - iconBackgroundColor: background color
    public init(mediaInputInfo: MediaInputType, iconBackgroundColor: Color) {
        self.mediaInputInfo = mediaInputInfo
        self.iconBackgroundColor = iconBackgroundColor
    }
    
    public var body: some View {
        
        ServiceItemComponent(icon: iconImage, subTitle: subTitle)
            .frame(width: 60, height: 72)
    }
    
    private var iconImage: some View {
        var iconName: String = ""
        switch self.mediaInputInfo {
            case .ALBUM:
                iconName = "person.2.crop.square.stack"
            case .CAMERA:
                iconName = "camera"
            case .GIFT:
                iconName = ""
            case .FREE_CALL:
                iconName = ""
            case .REMIT_MONEY:
                iconName = ""
            case .MUSIC:
                iconName = "music.note"
            case .CALENDER:
                iconName = "calendar"
            case .MAP:
                iconName = ""
            case .CAPTURED:
                iconName = "crop"
            case .VOICE_REC:
                iconName = "mic"
            case .CONTACTS:
                iconName = "person.crop.rectangle.stack"
            case .FILE:
                iconName = "paperclip"
            case .LINK:
                iconName = ""
        }
        
        return ZStack {
            self.iconBackgroundColor
            Image(systemName: iconName)
                .foregroundColor(.white)
                .font(.system(size: 26))
        }
        .frame(width: 48, height: 48)
        .mask(Circle())
            
    }
    
    private var subTitle: some View {
        var name: String = ""
        switch self.mediaInputInfo {
            case .ALBUM:
                name = "ChatMessage.Album"
            case .CAMERA:
                name = "ChatMessage.Camera"
            case .GIFT:
                name = ""
            case .FREE_CALL:
                name = ""
            case .REMIT_MONEY:
                name = ""
            case .MUSIC:
                name = "ChatMessage.Music"
            case .CALENDER:
                name = "ChatMessage.Calendar"
            case .MAP:
                name = ""
            case .CAPTURED:
                name = "ChatMessage.Captured"
            case .VOICE_REC:
                name = "ChatMessage.VoiceRec"
            case .CONTACTS:
                name = "ChatMessage.Contact"
            case .FILE:
                name = "ChatMessage.File"
            case .LINK:
                name = ""
        }
        
        return Text(tm.lang.localizedChatMessage(name))
                .font(tm.typo.caption)
                .foregroundColor(tm.theme.labelColorPrimary)
    }
}

#if DEBUG
struct ChatServiceItemSection_Previews: PreviewProvider {
    static let tm = ThemeManager()
    
    static var previews: some View {
        
        VStack {
            HStack {
                ChatServiceItemSection(mediaInputInfo: .ALBUM, iconBackgroundColor: tm.theme.systemGreen)
                    
                ChatServiceItemSection(mediaInputInfo: .CAMERA, iconBackgroundColor: tm.theme.systemBlue)
                
                ChatServiceItemSection(mediaInputInfo: .MUSIC, iconBackgroundColor: tm.theme.systemTeal)
                
                ChatServiceItemSection(mediaInputInfo: .FILE, iconBackgroundColor: tm.theme.systemIndigo)
            }
            
            HStack {
                ChatServiceItemSection(mediaInputInfo: .VOICE_REC, iconBackgroundColor: tm.theme.systemOrange)
                
                ChatServiceItemSection(mediaInputInfo: .CONTACTS, iconBackgroundColor: tm.theme.systemBlue)
                
                ChatServiceItemSection(mediaInputInfo: .CAPTURED, iconBackgroundColor: tm.theme.systemGreen)
                
                ChatServiceItemSection(mediaInputInfo: .CALENDER, iconBackgroundColor: tm.theme.systemGray)
                
            }
            
        }
        .environmentObject(tm)
        .previewLayout(.sizeThatFits)
    }
}
#endif
