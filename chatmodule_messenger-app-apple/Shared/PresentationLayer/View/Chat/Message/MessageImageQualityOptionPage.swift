//
//  MessageImageQualityOptionPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerChatMessagesUI

struct MessageImageQualityOptionPage: View {

    @EnvironmentObject var tm: ThemeManager
    @Environment(\.presentationMode) var presentationMode

    @State private var photoLowChecked: Bool = false
    @State private var photoNormalChecked: Bool = true
    @State private var photoOriginalChecked: Bool = false
    @State private var videoNormalChecked: Bool = true
    @State private var videoHighChecked: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                SubTitleBar(subTitle: tm.lang.localized("Photo"))
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 0))

                MessageQualityItemSection(itemText: tm.lang.localized("Quality_Low"),
                                          qualityInfo: MessageQualityItemInfo(contentType: .PHOTO, quality: .LOW),
                                          checked: $photoLowChecked,
                                          onClick: onClickQualityItem(qualityInfo:))
                    .padding(.bottom, 25)

                MessageQualityItemSection(itemText: tm.lang.localized("Quality_Normal"),
                                          qualityInfo: MessageQualityItemInfo(contentType: .PHOTO, quality: .NORMAL),
                                          checked: $photoNormalChecked,
                                          onClick: onClickQualityItem(qualityInfo:))
                    .padding(.bottom, 25)

                MessageQualityItemSection(itemText: tm.lang.localized("Quality_Original"),
                                          qualityInfo: MessageQualityItemInfo(contentType: .PHOTO, quality: .ORIGINAL),
                                          checked: $photoOriginalChecked,
                                          onClick: onClickQualityItem(qualityInfo:))
                    .padding(.bottom, 15)

                Divider()
                    .padding(.bottom, 20)

                SubTitleBar(subTitle: tm.lang.localized("Video"))
                    .padding(.bottom, 10)

                MessageQualityItemSection(itemText: tm.lang.localized("Quality_Normal"),
                                          qualityInfo: MessageQualityItemInfo(contentType: .VIDEO, quality: .NORMAL),
                                          checked: $videoNormalChecked,
                                          onClick: onClickQualityItem(qualityInfo:))
                    .padding(.bottom, 25)

                MessageQualityItemSection(itemText: tm.lang.localized("Quality_High"),
                                          qualityInfo: MessageQualityItemInfo(contentType: .VIDEO, quality: .HIGH),
                                          checked: $videoHighChecked,
                                          onClick: onClickQualityItem(qualityInfo:))
                    .padding(.bottom, 25)

                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationTitle(Text(tm.lang.localized("Resolution")))
            .navigationBarColor(backgroundColor: UIColor(tm.theme.systemBackground),
                                tintColor: UIColor(tm.theme.labelColorPrimary))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(tm.theme.labelColorSecondary)
                    }
                }
            }
        }
    }

    private func onClickQualityItem(qualityInfo: MessageQualityItemInfo) {
        print(qualityInfo)

        if qualityInfo.contentType == .PHOTO {
            photoLowChecked = false
            photoNormalChecked = false
            photoOriginalChecked = false

            switch qualityInfo.quality {
            case .LOW:
                photoLowChecked = true
            case .NORMAL:
                photoNormalChecked = true
            case .ORIGINAL:
                photoOriginalChecked = true
            case .HIGH:
                break
            }
        } else if qualityInfo.contentType == .VIDEO {
            videoNormalChecked = false
            videoHighChecked = false

            switch qualityInfo.quality {
            case .NORMAL:
                videoNormalChecked = true
            case .HIGH:
                videoHighChecked = true
            case .LOW, .ORIGINAL:
                break
            }
        }

        // 전송 화질 설정 값 저장을 여기서 해주면 될듯
    }
}

#if DEBUG
struct MessageImageQualityOptionPage_Previews: PreviewProvider {
    static var previews: some View {
        MessageImageQualityOptionPage()
            .environmentObject(ThemeManager())
    }
}
#endif
