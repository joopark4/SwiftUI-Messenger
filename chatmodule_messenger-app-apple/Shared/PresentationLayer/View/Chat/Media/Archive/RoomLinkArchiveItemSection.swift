//
//  RoomLinkArchiveItemSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

public struct RoomLinkArchiveItemSection: View {

    @EnvironmentObject var tm: ThemeManager

    @State public var check: Bool
    @State public var hiddenCheckButton: Bool

    private let info: String

    public init(hiddenCheckButton: Bool = true,
                check: Bool = false,
                info: String) {
        self.hiddenCheckButton = hiddenCheckButton
        self.check = check
        self.info = info
    }

    public var body: some View {
        Button {
            self.check.toggle()
        } label: {
            ThumbnailItem1Component(topBox: topBox,
                                    subtitle1: info,
                                    subtitle2: "ADNS",
                                    subtitle3: "WWW.r")
            .padding(0)
            .frame(width: 177, height: 177)
        }
        .padding(0)
        .background(RoundedRectangle(cornerRadius: 8).stroke(check ? .purple : tm.theme.systemBackgroundSecondary, lineWidth: 1))
    }

    private var topBox: some View {
        ZStack {
            imageBox

            VStack {
                HStack(alignment: .top, spacing: 0) {
                    Spacer()
                    if !hiddenCheckButton {
                        checkBox.padding([.top, .trailing], 10)
                    }
                }
                Spacer()
            }
        }
//        .padding(.top, 10)
        .frame(width: 177, height: 77)
    }

    private var imageBox: some View {
        Image(uiImage: UIImage(named: "tempImage") ?? UIImage())
            .resizable()
            .scaledToFill()
            .frame(width: 177, height: 77)
            .clipped()
    }

    private var checkBox: some View {
        ZStack {
            Circle()
                .strokeBorder(Color.white.opacity(1), lineWidth: 1.0)
                .background(Circle().foregroundColor(check ? Color.purple : Color.gray.opacity(0.2)))
                .frame(width: 18, height: 18)

            if check {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .regular))
                    .frame(width: 18, height: 18)
            }
        }
    }
}

struct RoomLinkArchiveItemSection_Previews: PreviewProvider {
    static var previews: some View {
        RoomLinkArchiveItemSection(info: "Link Link")
    }
}
