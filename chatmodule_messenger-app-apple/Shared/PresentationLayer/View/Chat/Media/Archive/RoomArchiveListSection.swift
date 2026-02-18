//
//  RoomArchiveListSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerChatRoomUI

struct RoomArchiveListSection: View {

    let date: String
    let files: [String] = ["1", "2", "3"] // 파일데이터를 받도록 처리 필요
    let contentsType: RoomArchiveContentsType

    @State var hiddenCheckButton: Bool

    init(contentsType: RoomArchiveContentsType, hiddenCheckButton: Bool = true, date: String) {
        self.contentsType = contentsType
        self.hiddenCheckButton = hiddenCheckButton
        self.date = date
    }

    private var gridItemLayout = [GridItem(.fixed(177), spacing: 5, alignment: .center),
                                  GridItem(.fixed(177), spacing: 5, alignment: .center)]

    var body: some View {
        VStack {
            RoomArchiveSubTitleItemSection(date: date)

            LazyVGrid(columns: gridItemLayout, alignment: .center, spacing: 5) {
                ForEach(files, id: \.self) { data in
                    if contentsType == .FILE {
                        RoomFileArchiveItemSection(hiddenCheckButton: hiddenCheckButton, check: false, info: data)
                    } else {
                        RoomLinkArchiveItemSection(hiddenCheckButton: hiddenCheckButton, check: false, info: data)
                    }
                }
            }
        }
    }
}

struct RoomFileArchiveListSection_Previews: PreviewProvider {
    static var previews: some View {
        RoomArchiveListSection(contentsType: .LINK, date: "2025-02-01")
    }
}
