//
//  ListItem2.swift
//  ChatModuleMessengerUI
//

import SwiftUI

/// List Item Default Half
///
/// Customize components > list item2 > list_item-default-half
///
///
public struct ListItemDefaultHalf<IconText: View, RightIconBox: View>: View {
    @EnvironmentObject var tm: ThemeManager

    var subTitle1: String?
    var subTitle2: String?
    var subTitle2Color: Color?
    var iconText: IconText
    var iconBox: RightIconBox

    /// Create ListItemDefaultHalf
    ///
    /// - Parameters:
    ///   - subTitle1: subTitle1 text
    ///   - subTitle2: subTitle2 text
    ///   - iconText: iconText label area
    ///   - iconBox: right icon area
    public init(subTitle1: String? = nil,
                subTitle2: String? = nil,
                subTitle2Color: Color? = nil,
                iconText: IconText,
                iconBox: RightIconBox) {
        self.subTitle1 = subTitle1
        self.subTitle2 = subTitle2
        self.subTitle2Color = subTitle2Color
        self.iconText = iconText
        self.iconBox = iconBox
    }

    public var body: some View {
        HStack(spacing: 0) {
            if let subTitle1 = subTitle1, !subTitle1.isEmpty {
                Text(subTitle1)
                    .font(tm.typo.headline)
                    .foregroundColor(tm.theme.labelColorPrimary)
                    .padding(.leading, 16)
            }

            if let subTitle2 = subTitle2, !subTitle2.isEmpty {
                Text(subTitle2)
                    .font(tm.typo.subheadline)
                    .foregroundColor(self.subTitle2Color ?? tm.theme.labelColorSecondary)
                    .padding(.leading, 12)
            }

            Spacer()

            iconText
                .padding(.leading, 12)

            iconBox
        }
        .padding(.trailing, 17)
    }
}

/// List Item Half Mobile
///
/// Customize components > list item2 > list_item-half-mobile
///
///
///
public struct ListItemHalfMobile<IconText: View, RightIconBox: View>: View {
    @EnvironmentObject var tm: ThemeManager

    var subTitle1: String
    var subTitle2: String?
    var iconText: IconText
    var iconBox: RightIconBox

    /// Create ListItemHalfMobile
    ///
    /// - Parameters:
    ///   - subTitle1: subTitle1 text
    ///   - subTitle2: subTitle2 text
    ///   - iconText: iconText label area
    ///   - iconBox: right icon area
    public init(subTitle1: String,
                subTitle2: String? = nil,
                iconText: IconText,
                iconBox: RightIconBox) {
        self.subTitle1 = subTitle1
        self.subTitle2 = subTitle2
        self.iconText = iconText
        self.iconBox = iconBox
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {

                Text(subTitle1)
                    .font(.headline)
                    .foregroundColor(tm.theme.labelColorPrimary)
                    .padding(.leading, 16)

                Spacer()

                iconBox
                    .padding(.trailing, 17)
            }

            if let subTitle2 = subTitle2, !subTitle2.isEmpty {
                Text(subTitle2)
                    .font(.subheadline)
                    .foregroundColor(tm.theme.labelColorSecondary)
                    .padding(.leading, 16)
            }

            iconText
                .padding(.leading, 16)
                .padding(.top, 8)
        }
    }
}

#if DEBUG
struct ListItem2_Previews: PreviewProvider {
    static let tm = ThemeManager(theme: Theme(types: .basic),
                          lang: Language(types: .english),
                          typo: Typography(types: .basic))

    static var previews: some View {
        VStack {
            ListItemDefaultHalf(subTitle1: "subTitle1",
                                subTitle2: "subTitle2",
                                iconText: HStack {
                Image(systemName: "location.circle").foregroundColor(tm.theme.systemPurple)
                Text("Lorem ipsum dolor sit").foregroundColor(tm.theme.labelColorSecondary)
            },
                                iconBox: Image(systemName: "chevron.right"))
        }
        .environmentObject(tm)
        .previewLayout(.sizeThatFits)

        VStack {
            ListItemHalfMobile(subTitle1: "subTitle1",
                               subTitle2: "subTitle2",
                               iconText: HStack {
                Image(systemName: "location.circle").foregroundColor(tm.theme.systemPurple)
                Text("Lorem ipsum dolor sit").foregroundColor(tm.theme.labelColorSecondary)
            },
                               iconBox: Image(systemName: "chevron.right"))
        }
        .environmentObject(tm)
        .previewLayout(.sizeThatFits)
    }
}
#endif
