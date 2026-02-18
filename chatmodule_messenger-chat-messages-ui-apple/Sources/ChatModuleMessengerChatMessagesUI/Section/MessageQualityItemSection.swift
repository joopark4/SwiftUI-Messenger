//
//  MessageQualityItemSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import ChatModuleMessengerUI


public enum ContentType {
    case PHOTO, VIDEO
}

public enum ContentQuality {
    case LOW, NORMAL, ORIGINAL, HIGH
}

/// Message Quality Item Info
///
/// Chat Room prototype > 화질 선택 라디오 버튼
///
///
public struct MessageQualityItemInfo {
    public let contentType: ContentType
    public let quality: ContentQuality

    public init(contentType: ContentType, quality: ContentQuality) {
        self.contentType = contentType
        self.quality = quality
    }
}


public struct MessageQualityItemSection: View {
    @EnvironmentObject var tm: ThemeManager

    private let itemText: String
    private let qualityInfo: MessageQualityItemInfo
    private let onClick: ((MessageQualityItemInfo) -> Void)
    @Binding private var checked: Bool

    public init(itemText: String,
                qualityInfo: MessageQualityItemInfo,
                checked: Binding<Bool>,
                onClick: @escaping (MessageQualityItemInfo) -> Void) {
        self.itemText = itemText
        self.qualityInfo = qualityInfo
        _checked = checked
        self.onClick = onClick
    }

    public var body: some View {
        ListItemDefaultHalf(subTitle1: itemText,
                            subTitle2: nil,
                            iconText: EmptyView(),
                            iconBox: radioButton)
    }

    private var radioButton: some View {
        Button {
            onClick(qualityInfo)
        } label: {
            Image(systemName: checked ? "smallcircle.filled.circle" : "circle")
                .foregroundColor(checked ? tm.theme.systemPurple : tm.theme.labelColorTertiary)
        }
    }
}

struct MessageQualityItemSection_Previews: PreviewProvider {
    static var previews: some View {
        MessageQualityItemSection(itemText: "test",
                                  qualityInfo: MessageQualityItemInfo(contentType: .PHOTO, quality: .NORMAL), checked: .constant(true)) { info in
        }
    }
}
