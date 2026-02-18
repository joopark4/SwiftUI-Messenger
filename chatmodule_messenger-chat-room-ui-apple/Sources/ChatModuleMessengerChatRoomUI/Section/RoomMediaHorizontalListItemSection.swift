//
//  RoomMediaHorizontalListItemSection.swift
//  ChatModuleMessengerChatRoomUI
//

import SwiftUI
import ChatModuleMessengerUI


/// Room Media Horizontal ListItem Section
///
/// Chat prototype
///
///
public struct RoomMediaHorizontalListItemSection: View {
    @EnvironmentObject var tm: ThemeManager

    private let contentInfo: contentTypeInfo
    private let frameSize: CGSize
    private let onPreviewClick: (() -> Void)?
    private let image: UIImage?

    public init(image: UIImage? = nil,
                contentInfo: contentTypeInfo,
                frameSize: CGSize,
                onPreviewClick: (() -> Void)? = nil) {
        self.image = image
        self.contentInfo = contentInfo
        self.frameSize = frameSize
        self.onPreviewClick = onPreviewClick
    }

    public var body: some View {
        Button {
            onPreviewClick?()
        } label: {
            ThumbnailItemComponents(image: image,
                                    view01: EmptyView(),
                                    view02: EmptyView(),
                                    view03: contentTypeInfoView)
        }
        .frame(width: self.frameSize.width, height: self.frameSize.height)
        .cornerRadius(2)
    }

    @ViewBuilder
    private var contentTypeInfoView: some View {
        switch contentInfo {
        case .IMAGE:
            Image(systemName: "photo.on.rectangle")
                .resizable()
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(width: 26, height: 24)
        case .GIF:
            Text("GIF")
                .font(tm.typo.footnote)
                .font(.system(size: 12))
                .foregroundColor(.white)
                .frame(width: 26, height: 16)
        case .MOVIE:
            EmptyView()
//            Text("99:99:99")
//                .font(tm.typo.footnote)
//                .font(.system(size: 12))
//                .foregroundColor(.white)
//                .frame(height: 16)
        }

    }
}

struct RoomMediaHorizontalListItemSection_Previews: PreviewProvider {
    static var previews: some View {
        RoomMediaHorizontalListItemSection(image: nil, contentInfo: .IMAGE, frameSize: CGSize(width: 73, height: 73), onPreviewClick: nil)
    }
}
