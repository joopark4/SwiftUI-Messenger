//
//  MessageImageListSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerChatMessagesUI

enum MessageImageListSelectType: CaseIterable, Identifiable {
    var id: MessageImageListSelectType { self }

    case ALL
    case DETAIL
    case QULITY
}

struct MessageImageListSection: View {

    @EnvironmentObject var tm: ThemeManager
    @Environment(\.presentationMode) var presentationMode

    let previewHeight: CGFloat
    var photolib = PhotoLib()
    private let editToolBarHeight: CGFloat = 44

    @Binding var imageListSelectType: MessageImageListSelectType?

    init(previewHeight: CGFloat = 200, imageListSelectType: Binding<MessageImageListSelectType?>) {
        self.previewHeight = previewHeight - editToolBarHeight
        _imageListSelectType = imageListSelectType
    }

    var body: some View {
        VStack(spacing: 0) {
            itemHorizontalListView

            editToolBar
        }
    }

    private var itemHorizontalListView: some View {
        ZStack {
            tm.theme.systemBackground
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 2) {
                    ForEach(0..<photolib.allPhotos.count) { idx in
                        MediaImageSelectionSection(selectionType: .inputImage,
                                                   uiImage: photolib.allPhotos.object(at: idx)
                                                    .getAssetThumbnail(size: CGSize(width: 150, height: previewHeight)),
                                                   aspectRatioSize: CGSize(width: 150, height: previewHeight),
                                                   counter: .constant(4),
                                                   checked: true,
                                                   onCheckChanged: nil)
                            .frame(width: 150, height: previewHeight)
                    }
                }
            }
            .frame(height: previewHeight)
        }
    }

    private var editToolBar: some View {
        HStack {

            Button {
                imageListSelectType = .ALL
            } label: {
                Image(systemName: "square.grid.2x2.fill")
                    .foregroundColor(tm.theme.labelColorPrimary)
                    .font(.system(size: 24))
                    .frame(width: 28, height: 28)
                    .padding(.leading, 16)

                Text(tm.lang.localized("Media.AllView"))
                    .foregroundColor(tm.theme.labelColorPrimary)
                    .font(.body)
                    .padding(.leading, 4)
            }

            Spacer()

            Button {
                imageListSelectType = .DETAIL
            } label: {
                Image(systemName: "wand.and.rays")
                    .foregroundColor(tm.theme.labelColorPrimary)
                    .font(.system(size: 24))
                    .frame(width: 28, height: 28)
                    .padding(.trailing, 24)
            }

            Button {
                imageListSelectType = .QULITY
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(tm.theme.labelColorPrimary)
                    .font(.system(size: 24))
                    .frame(width: 28, height: 28)
                    .padding(.trailing, 16)
            }
        }
        .frame(height: editToolBarHeight)
        .background(tm.theme.systemBackground)
    }
}

#if DEBUG
struct MessageImageListSection_Previews: PreviewProvider {
    static var previews: some View {
        MessageImageListSection( imageListSelectType: .constant(.ALL))
            .environmentObject(ThemeManager())
    }
}
#endif
