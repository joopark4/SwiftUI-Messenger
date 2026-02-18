//
//  MessageImageSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Message Image Section
///
/// costomize components > bubble contents > image
///
///
/// Usage:
///
///     MessageImageSection(messageInfo: MessageInfo(...))
///
public struct MessageImageSection: View {
    @EnvironmentObject var tm: ThemeManager

    let messageInfo: MessageInfo

    let threeImages: [ImageInfo]
    let twoImages: [ImageInfo]
    let images: [ImageInfo]

    /// Create MessageImageSection
    /// - Parameter messageInfo: message info data (``MessageInfo``)
    public init(messageInfo: MessageInfo) {
        self.messageInfo = messageInfo
        switch messageInfo.payload.payloadType {
        case .IMAGE(id: _, _, let images):
            self.images = images
        default:
            self.images = []
        }

        let mod = images.count % 3
        if images.count <= 1 {
            threeImages = []
            twoImages = []
        } else if mod == 0 {
            threeImages = images
            twoImages = []
        } else if mod == 1 {
            threeImages = Array(images.prefix(images.count - 4))
            twoImages = images.suffix(4)
        } else {
            threeImages = Array(images.prefix(images.count - 2))
            twoImages = images.suffix(2)
        }
    }

    public var body: some View {
        VStack(spacing: 2) {
            if images.count == 1 {
//               let first = images.first {
                // min / max 사이즈 정책 필요
//                Image(uiImage: UIImage(contentsOfFile: first.url) ?? UIImage())
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: CGFloat(first.width), height: CGFloat(first.height))
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: 250, height: 150)
            } else {
                // TODO: 일단 Rectangle로 영역만 잡음
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 2),
                                    GridItem(.flexible(), spacing: 2),
                                    GridItem(.flexible())],
                          spacing: 2) {
                    ForEach(0..<self.threeImages.count) { _ in
                        Rectangle()
                            .foregroundColor(.gray)
                            .frame(height: 92)
                    }
                }
                .frame(maxWidth: .infinity)

                LazyVGrid(columns: [GridItem(.flexible(), spacing: 2),
                                    GridItem(.flexible())],
                          spacing: 2) {
                    ForEach(0..<self.twoImages.count) { _ in
                        Rectangle()
                            .foregroundColor(.gray)
                            .frame(height: self.threeImages.isEmpty ? 130 : 92)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .cornerRadius(20)
        .padding(messageInfo.flow == .SENT_MESSAGE ? .trailing : .leading, 8)
    }
}

#if DEBUG
struct MessageImageSection_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ForEach(1..<11) { i in
                VStack {
                    Text("\(i)")
                    MessageImageSection(messageInfo: MessageInfo(type: .IMAGE,
                                                                 payload:
                                                                        .init(payloadType: .IMAGE(id: "", extensionInfo: "", images: [ImageInfo](repeating: ImageInfo(), count: i)))))
                }
            }
        }
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
