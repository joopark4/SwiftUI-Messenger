//
//  MediaImageSelectionPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerChatMessagesUI

struct MediaImageSelectionPage: View {

    @EnvironmentObject var tm: ThemeManager
    @Environment(\.presentationMode) var presentationMode

    var photolib = PhotoLib()

    var checkedPhotoBundle: Bool = false
    var counter: Int = 0

    private var gridItemLayout = [GridItem(.flexible(), spacing: 2),
                                  GridItem(.flexible(), spacing: 2),
                                  GridItem(.flexible(), spacing: 2)]

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: gridItemLayout, alignment: .center, spacing: 2) {

                        // Todo.. UI만 고려된 상태라 썸네일 가져오는 루프문 개선 필요
                        ForEach(0..<photolib.allPhotos.count) { idx in
                            MediaImageSelectionSection(selectionType: .gallery,
                                                       uiImage: photolib.allPhotos.object(at: idx)
                                                        .getAssetThumbnail(size: CGSize(width: 150, height: 150)),
                                                       aspectRatioSize: CGSize(width: 1, height: 1),
                                                       counter: .constant(4), checked: true, onCheckChanged: nil)
                                .environmentObject(tm)
                        }
                    }
                }

                editToolBar
            }
            .navigationTitle(tm.lang.localized("Media.RecentItems"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(backgroundColor: UIColor(tm.theme.systemBackground),
                                tintColor: UIColor(tm.theme.labelColorPrimary))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(tm.theme.labelColorSecondary)
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("\(counter) \(tm.lang.localized(tm.lang.localized("Send")))")
                            .foregroundColor(tm.theme.labelColorSecondary)
                    }
                }
            }
        }
    }

    private var editToolBar: some View {
        HStack {
            if checkedPhotoBundle {
                Image(systemName: "checkmark.circle.fill").foregroundColor(.purple)
                    .font(.system(size: 24))
                    .frame(width: 28, height: 28)
                    .padding(.leading, 16)
            } else {
                Image(systemName: "circle").foregroundColor(tm.theme.labelColorQuarternary)
                    .font(.system(size: 24))
                    .frame(width: 28, height: 28)
                    .padding(.leading, 16)
            }

            Text(tm.lang.localized("ChatMessage.Send.PhotoBundle"))
                .font(.body)
                .padding(.leading, 4)

            Spacer()

            Button {
                // action
            } label: {
                Image(systemName: "wand.and.rays")
                    .foregroundColor(tm.theme.labelColorPrimary)
                    .font(.system(size: 24))
                    .frame(width: 28, height: 28)
                    .padding(.trailing, 24)
            }

            Button {
                // action
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(tm.theme.labelColorPrimary)
                    .font(.system(size: 24))
                    .frame(width: 28, height: 28)
                    .padding(.trailing, 16)
            }
        }
        .frame(height: 44)
    }
}

#if DEBUG
struct MediaImageSelectionPage_Previews: PreviewProvider {
    static var previews: some View {
        MediaImageSelectionPage()
            .environmentObject(AppState())
    }
}
#endif
