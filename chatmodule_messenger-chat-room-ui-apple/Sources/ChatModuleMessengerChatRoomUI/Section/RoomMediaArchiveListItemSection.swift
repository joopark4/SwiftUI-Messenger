//
//  RoomMediaArchiveListItemSection.swift
//  ChatModuleMessengerChatRoomUI
//

import SwiftUI
import ChatModuleMessengerUI



/// Room Media Archive List Item Section
///
/// Chat Room prototype > 송/수신 컨텐츠 모아보기 아이템
///
///
/// Usage:
///
///     RoomMediaArchiveListItemSection(image: UIImage(systemName: "lanyardcard.fill"),
///                contentinfo: .IMAGE,
///                frameSize: CGSize(width: 150, height: 150),
///                checked: $check,
///                checkedButtonDisable: $checkedDisable,
///                onPreviewClick: self.click)
///         
///
public struct RoomMediaArchiveListItemSection: View {

    public enum CheckMarkType {
        case Check, Bookmark
    }

    @EnvironmentObject var tm: ThemeManager

    private let contentInfo: contentTypeInfo
    private let frameSize: CGSize
    private let onPreviewClick: (() -> Void)?
    private let onCheckClick: ((Bool) -> Void)? //체크 선택에 따른 아이템 정보를 함께 전달해줘야할 듯
    private let image: UIImage?
    private let checkType: CheckMarkType
    @State private var checked: Bool
    @Binding private var checkButtonDisable: Bool

    public init(image: UIImage?,
                contentinfo: contentTypeInfo,
                frameSize: CGSize,
                checkType: CheckMarkType = .Check,
                checked: Bool = false,
                checkedButtonDisable: Binding<Bool> = .constant(true),
                onPreviewClick: (() -> Void)?,
                onCheckClick: ((Bool) -> Void)?) {
        self.image = image
        self.contentInfo = contentinfo
        self.checkType = checkType
        self.frameSize = frameSize
        self.checked = checked
        _checkButtonDisable = checkedButtonDisable
        self.onPreviewClick = onPreviewClick
        self.onCheckClick = onCheckClick
    }

    public var body: some View {
        ThumbnailItemComponents(image: image,
                                view01: checkButton,
                                view02: previewButton,
                                view03: contentTypeInfoView)
            .frame(width: frameSize.width, height: frameSize.height)
    }

    private func previewClick() {
        onPreviewClick?()
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
            Text("99:99:99")
                .font(tm.typo.footnote)
                .font(.system(size: 12))
                .foregroundColor(.white)
                .frame(height: 16)
        }

    }

    @ViewBuilder
    private var checkButton: some View {
        if checkButtonDisable {
            EmptyView()
        } else {
            ZStack {
                if checkType == .Check {
                    ZStack {
                        Circle()
                            .strokeBorder(Color.white.opacity(1), lineWidth: 1.0)
                            .background(Circle().foregroundColor(checked ? Color.purple : Color.gray.opacity(0.2)))
                            .frame(width: 18, height: 18)

                        if checked {
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .font(.system(size: 15))
                        }
                    }
                } else {
                    if checked {
                        Image(systemName: "bookmark.fill")
                            .foregroundColor(tm.theme.systemPurple)
                            .font(.system(size: 15))
                    } else {
                        Image(systemName: "bookmark")
                            .foregroundColor(.white)
                            .font(.system(size: 15))
                    }
                }

                HStack {
                    Spacer()
                    VStack {
                        Button {
                            checked.toggle()
                            onCheckClick?(checked)
                        } label: {
                            Color.clear
                        }
                        .frame(width: 28, height: 28)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10))

                        Spacer()
                    }
                }
            }
        }
    }

    private var previewButton: some View {
        HStack {
            VStack {
                Spacer()
                Button {
                    onPreviewClick?()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(tm.theme.labelColorSecondary)

                        Image(systemName: "arrow.up.left.and.arrow.down.right")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                    }
                }
            }
            Spacer()
        }
    }
}

struct RoomMediaArchiveListItemSection_Previews: PreviewProvider {
    static var previews: some View {
        RoomMediaArchiveListItemSection(image: UIImage(systemName: "list.bullet.rectangle.fill"),
                                        contentinfo: .MOVIE,
                                        frameSize: CGSize(width: 150, height: 150),
                                        checked: false,
                                        checkedButtonDisable: .constant(false),
                                        onPreviewClick: nil,
                                        onCheckClick: nil)
    }
}
