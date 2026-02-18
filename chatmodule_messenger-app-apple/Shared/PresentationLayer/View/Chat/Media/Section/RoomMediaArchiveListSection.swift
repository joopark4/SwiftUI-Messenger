//
//  RoomMediaArchiveListSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerChatRoomUI

struct RoomMediaArchiveListSection: View {

    // Todo.. 컨텐츠 데이터를 전달받도록 바인딩시 수정
    private let archiveDate: String
    private let onPreviewClick: (() -> Void)?

    @Binding private var checkedButtonDisable: Bool

    private var gridItemLayout = [GridItem(.flexible(), spacing: 2),
                                  GridItem(.flexible(), spacing: 2),
                                  GridItem(.flexible(), spacing: 2)]

    init(archiveDate: String,
         checkedButtonDisable: Binding<Bool>,
         onPreviewClick: (() -> Void)?) {
        self.archiveDate = archiveDate
        _checkedButtonDisable = checkedButtonDisable
        self.onPreviewClick = onPreviewClick
    }

    var body: some View {
        VStack {
            SubTitleBar(subTitle: archiveDate)

            // Todo.. 아이템 리스트 모델이 나오면 수정
            LazyVGrid(columns: gridItemLayout, alignment: .center, spacing: 2) {
                ForEach(0..<5) { _ in
                    RoomMediaArchiveListItemSection(image: UIImage(systemName: "cpu"),
                                                    contentinfo: .IMAGE,
                                                    frameSize: CGSize(width: 125, height: 125),
                                                    checked: false,
                                                    checkedButtonDisable: $checkedButtonDisable,
                                                    onPreviewClick: self.previewClick,
                                                    onCheckClick: self.checkClick(checked:))
                }
            }
        }
    }

    private func previewClick() {
        print(#function)
    }

    private func checkClick(checked: Bool) {
        print("\(#function) : \(checked)")
    }
}

struct RoomMediaArchiveListSection_Previews: PreviewProvider {
    static var previews: some View {
        RoomMediaArchiveListSection(archiveDate: "2025-02-22",
                                    checkedButtonDisable: .constant(false),
                                    onPreviewClick: nil)
    }
}
