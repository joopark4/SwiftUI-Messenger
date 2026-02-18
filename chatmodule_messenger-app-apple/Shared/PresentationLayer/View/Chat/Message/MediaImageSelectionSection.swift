//
//  MediaImageSelectionSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import Photos

enum ImageSelectionType: Int {
    case inputImage, previewImage, gallery
}

struct MediaImageSelectionSection: View {

    @State private var checked: Bool = false
    @Binding private var counter: Int
    let selectionType: ImageSelectionType
    let asset: PHAsset?
    let onCheckChanged: ((PHAsset?) -> Void)?
    let circleWH: CGSize
    let circleMarginTop: CGFloat
    let circleMarginTrailing: CGFloat
    let countFont: Font

    public init(selectionType: ImageSelectionType,
                asset: PHAsset? = nil,
                counter: Binding<Int>,
                checked: Bool,
                onCheckChanged: ((PHAsset?) -> Void)? = nil) {
        self.selectionType = selectionType
        self.asset = asset
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

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.yellow

            Image(systemName: "scribble.variable")
                .resizable()

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
            .padding(EdgeInsets(top: circleMarginTop, leading: 0, bottom: 0, trailing: circleMarginTrailing))

            Button {
                self.checked.toggle()
                self.onCheckChanged?(self.asset)
            } label: {
                Color.clear
            }
            .frame(width: circleWH.width+50, height: circleWH.height+50)
        }
    }
}

struct MediaImageSelectionSection_Previews: PreviewProvider {
    static var previews: some View {
        MediaImageSelectionSection(selectionType: .inputImage, asset: nil, counter: .constant(30), checked: true) { _ in
        }
    }
}
