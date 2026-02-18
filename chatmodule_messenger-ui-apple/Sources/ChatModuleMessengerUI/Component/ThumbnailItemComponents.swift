//
//  ThumbnailItemComponents.swift
//  ChatModuleMessengerUI
//

import SwiftUI

public enum contentTypeInfo {
    case IMAGE, GIF, MOVIE
}

/// ThumbnailItemComponents
///
/// Customize components
///
///
/// Usage:
///
///         ThumbnailItemComponents(image: nil, contentInfo: EmptyView(), checked: .constant(true), checkButtonDisable: .constant(false) , onPreviewClick: nil)
///
/// or
///
///         ThumbnailItemComponents(image: UIImage(systemName: "text.below.photo.fill"),
///             contentInfo: Image(systemName: "photo.on.rectangle"),
///             checked: $check,
///             checkButtonDisable: $checkDisable,
///             onPreviewClick: self.onClick)
///        .frame(width: 200, height: 200)
///
public struct ThumbnailItemComponents<View01: View, View02: View, View03: View>: View {

    @EnvironmentObject var tm: ThemeManager

    private let image: UIImage?
    private let view01: View01
    private let view02: View02
    private let view03: View03


    public init(image: UIImage?,
                view01: View01,
                view02: View02,
                view03: View03) {
        self.image = image
        self.view01 = view01
        self.view02 = view02
        self.view03 = view03
    }

    public var body: some View {
        ZStack {
            Image.profileImage(image)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .clipped()

            view01View

            view02View

            view03View
        }
    }

    private var view01View: some View {
        ZStack {
            HStack {
                Spacer()
                VStack {
                    view01.frame(width: 18, height: 18)
                    Spacer()
                }
            }
        }
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10))
    }

    private var view02View: some View {
        HStack {
            VStack {
                Spacer()
                view02.frame(width: 28, height: 28)
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 0))
    }

    private var view03View: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                view03
                    .padding(2)
                    .background(tm.theme.backgroundInfoSelect)
                    .cornerRadius(5)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 6, trailing: 6))
    }
}

struct ThumbnailItemComponents_Previews: PreviewProvider {
    static var previews: some View {
        ThumbnailItemComponents(image: UIImage(systemName: "map.fill"),
                                view01: Text("0"),
                                view02: Text("1"),
                                view03: Text("2"))
    }
}
