//
//  MediaImageSelectionSection.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import Photos
import ChatModuleMessengerUI

public enum ImageSelectionType: Int {
    case inputImage, previewImage, gallery
}


/// Media Image Selection Section
///
/// Chat Room > 사진앱 미디어 리스트 아이템 선택
///
///
public struct MediaImageSelectionSection: View {

    @EnvironmentObject var tm: ThemeManager

    @State private var checked: Bool = false
    @Binding private var counter: Int
    let selectionType: ImageSelectionType
    let image: UIImage?
    let onCheckChanged: (() -> Void)?
    let circleWH: CGSize
    let circleMarginTop: CGFloat
    let circleMarginTrailing: CGFloat
    let countFont: Font
    let aspectRatioSize: CGSize //이미지의 W, H 비율 또는 size를 전달해줘야 제대로 나온다

    public init(selectionType: ImageSelectionType,
                uiImage: UIImage? = nil,
                aspectRatioSize: CGSize,
                counter: Binding<Int>,
                checked: Bool,
                onCheckChanged: (() -> Void)? = nil) {
        self.selectionType = selectionType
        self.image = uiImage
        self.aspectRatioSize = aspectRatioSize
        _counter = counter
        self.checked = checked
        self.onCheckChanged = onCheckChanged

        switch selectionType {
        case .inputImage:
            self.circleWH = CGSize(width: 20, height: 20)
            self.circleMarginTop = 10
            self.circleMarginTrailing = 10
            self.countFont = .caption
        case .previewImage:
            self.circleWH = CGSize(width: 46, height: 46)
            self.circleMarginTop = 16
            self.circleMarginTrailing = 16
            self.countFont = .title2
        case .gallery:
            self.circleWH = CGSize(width: 20, height: 20)
            self.circleMarginTop = 10
            self.circleMarginTrailing = 20
            self.countFont = .caption
        }
    }

    public var body: some View {
        ZStack {
            Image.profileImage(image)
                .resizable()
                .aspectRatio(aspectRatioSize, contentMode: .fit)
                .clipped()

            checkCount

            HStack {
                VStack {
                    Spacer()
                    previewButton
                }
                Spacer()
            }
        }

    }

    private var checkCount: some View {
        ZStack {
            HStack {
                Spacer()
                VStack {
                    ZStack {
                        Circle()
                            .strokeBorder(Color.white
                                            .opacity(0.8), lineWidth: 1.5)
                            .background(Circle()
                                            .foregroundColor(checked ? Color.purple.opacity(1) : Color.gray.opacity(0.2)))
                            .frame(width: circleWH.width, height: circleWH.height)

                        if checked {
                            Text("\(counter)")
                                .font(countFont)
                                .foregroundColor(.white)
                        }
                    }

                    Spacer()
                }
            }

            HStack {
                Spacer()
                VStack {
                    Button {
                        self.checked.toggle()
                        self.onCheckChanged?()
                    } label: {
                        Color.clear
                    }
                    .frame(width: circleWH.width+30, height: circleWH.height+30)

                    Spacer()
                }
            }
        }
        .padding(EdgeInsets(top: circleMarginTop, leading: 0, bottom: 0, trailing: circleMarginTrailing))
    }

    private var previewButton: some View {
        VStack {
            if selectionType != .previewImage {
                Button {
                    // action
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(tm.theme.labelColorSecondary)
                            .frame(width: 28, height: 28)

                        Image(systemName: "arrow.up.left.and.arrow.down.right")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                    }
                }
                .frame(width: 28, height: 28)
                .padding(EdgeInsets(top: 0, leading: 4, bottom: 4, trailing: 0))
            }
        }
        .padding(EdgeInsets(top: 0, leading: 4, bottom: 4, trailing: 0))
    }
}

#if DEBUG
struct MediaImageSelectionSection_Previews: PreviewProvider {
    static var previews: some View {
        MediaImageSelectionSection(selectionType: .inputImage,
                                   uiImage: nil,
                                   aspectRatioSize: CGSize(width: 1, height: 1), counter: .constant(30),
                                   checked: true) {
        }
        .environmentObject(ThemeManager())
    }
}
#endif
