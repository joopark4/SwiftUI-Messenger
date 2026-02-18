//
//  PersonRemove.swift
//  ChatModuleMessengerUI
//

import SwiftUI

/// Person Remove
///
/// Chat > 대화상대 선택 시 아바타
///
///
public struct PersonRemove: View {

    @EnvironmentObject var tm: ThemeManager

    var iconBox: UIImage?
    var subTitle: String

    public init(iconBox: UIImage? = nil, subTitle: String) {
        self.iconBox = iconBox
        self.subTitle = subTitle
    }

    public var body: some View {
        VStack(spacing: 0) {

            Avatar(icon: Image.profileImage(iconBox)
                    .resizable()
                    .foregroundColor(tm.theme.chatmoduleColor00)
                    .frame(width: 40, height: 40, alignment: .leading),
                   badge:
                    Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .font(.caption2)
                    .foregroundColor(tm.theme.labelColorSecondary))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 12))

            Text(subTitle).font(.caption)
                .frame(width: 52, height: 16)
                .foregroundColor(tm.theme.labelColorPrimary)
        }
    }
}

#if DEBUG
struct PersonRemove_Previews: PreviewProvider {
    static var previews: some View {
        PersonRemove(iconBox: UIImage(systemName: "person.crop.circle.fill")?.withRenderingMode(.alwaysTemplate), subTitle: "name")
    }
}
#endif
