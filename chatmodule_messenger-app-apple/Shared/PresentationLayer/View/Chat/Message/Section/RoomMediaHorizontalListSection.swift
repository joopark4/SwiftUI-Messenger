//
//  RoomMediaHorizontalListSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerChatRoomUI

struct RoomMediaHorizontalListSection: View {

    let maxCount = 4
    var previewHeight: CGFloat = 73
    var photolib = PhotoLib()
    var onClick: (() -> Void)?

    init(onClick: (() -> Void)? = nil) {
        self.onClick = onClick
        previewHeight = (UIScreen.main.bounds.width - 32 - 12) / CGFloat(maxCount)
    }

    var body: some View {
        VStack {
//            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 4) {
                    ForEach(0..<maxCount) { idx in
                        if idx < photolib.allPhotos.count {
                            RoomMediaHorizontalListItemSection(image: photolib.allPhotos.object(at: idx)
                                .getAssetThumbnail(size: CGSize(width: previewHeight, height: previewHeight)),
                                                               contentInfo: .IMAGE,
                                                               frameSize: CGSize(width: previewHeight,
                                                                                 height: previewHeight),
                                                               onPreviewClick: onClick)
                            .cornerRadius(2)
                        } else {
                            EmptyView()
                        }
                    }
                }
//            }
        }
    }
}

struct RoomMediaHorizontalListSection_Previews: PreviewProvider {
    static var previews: some View {
        RoomMediaHorizontalListSection()
    }
}
