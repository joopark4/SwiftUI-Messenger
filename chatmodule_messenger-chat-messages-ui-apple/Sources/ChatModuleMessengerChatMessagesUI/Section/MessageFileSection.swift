//
//  MessageFileSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import ChatModuleMessengerUI

enum FileStatus {
    
}

public struct MessageFileSection: View {
    @EnvironmentObject var tm: ThemeManager

    let messageInfo: MessageInfo
    var progress: CGFloat?
    
    public init(messageInfo: MessageInfo, progress: CGFloat? = nil) {
        self.messageInfo = messageInfo
        self.progress = progress
    }
    
    public var body: some View {
        ZStack {
            HStack(spacing: 0) {
                
                // 확장자에 따라 아이콘이 변경 되야함
                // 확장자를 어떻게 구분하는지 확인 필요
                ZStack {
//                    download
//                    downloading
                    icon
                }
                .frame(width: 36, height: 36)
                .padding(.horizontal, 16)
                
                
                VStack(alignment: .leading, spacing: 0){
                    Text("File.docx")
                        .font(tm.typo.headline)
                        .foregroundColor(tm.theme.labelColorPrimary)
                        .frame(height: 22)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("유효기간: ~ 2025.3.31")
                            .font(.caption)
                            .foregroundColor(tm.theme.labelColorSecondary)
                        Text("용량: 321.21MB")
                            .font(.caption)
                            .foregroundColor(tm.theme.labelColorSecondary)
                    }
                    .frame(height: 32)
                }
                
                Spacer()
            }
            .frame(width: messageInfo.flow == .SENT_MESSAGE ? 241 : 230, height: 80)
        }
        .background(Color.white)
        .cornerRadius(20)
        .padding(messageInfo.flow == .SENT_MESSAGE ? .trailing : .leading, 8)
    }
    
    private var icon: some View {
        let iconName: String = "doc.text.fill"
        let iconColor: Color = tm.theme.systemPurple
        
        return Image(systemName: iconName)
            .font(.system(size: 31))
            .foregroundColor(iconColor)
    }
    
    private var download: some View {
        ZStack {
            Circle()
                .stroke(tm.theme.systemGray, lineWidth: 1)
                .frame(width: 44, height: 44)
            
            Image(systemName: "arrow.down.to.line.alt")
                .foregroundColor(tm.theme.systemGray)
                .font(.system(size: 20))
        }
    }
    
    @ViewBuilder
    private var downloading: some View {
        if let progress = progress {
            ZStack {
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(tm.theme.systemGray, lineWidth: 8)
                    .mask(Circle())
                    .rotationEffect(.degrees(-90))
                    .frame(width: 44, height: 44)
                
                Image(systemName: "xmark")
                    .foregroundColor(tm.theme.systemGray)
                    .font(.system(size: 20))
            }
        }
    }
    
}

#if DEBUG
struct MessageFileSection_Previews: PreviewProvider {
    static var previews: some View {
        MessageFileSection(messageInfo: MessageInfo(type:.FILE, flow: .SENT_MESSAGE), progress: 0.5)
            .previewLayout(.sizeThatFits)
            .environmentObject(ThemeManager())
    }
}
#endif
