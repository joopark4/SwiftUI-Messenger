//
//  ListItem1.swift
//  ChatModuleMessengerUI
//

import SwiftUI

/// List Item Mobile
///
/// Customize components > lists item1 > list_item-mobile
///
///
/// Usage:
///
///       ListItemMobile(subTitle1: "SubTitle1",
///                      secondaryText: "secondaryText",
///                      rightIconBox: Circle().frame(width: 32, height: 32))
///
public struct ListItemMobile<RightBox: View>: View {
    @EnvironmentObject var tm: ThemeManager
    var subTitle1: String?
    var secondaryText: String?
    var rightIconBox: RightBox

    /// Create ListItemMobile
    ///
    /// - Parameters:
    ///   - subTitle1: subTitle1 text
    ///   - secondaryText: secondary text
    ///   - rightIconBox: right icon area
    public init(subTitle1: String? = nil,
                secondaryText: String? = nil,
                rightIconBox: RightBox) {
        self.subTitle1 = subTitle1
        self.secondaryText = secondaryText
        self.rightIconBox = rightIconBox
    }

    public var body: some View {
        HStack(spacing: 0) {
            Spacer()
            VStack(alignment: .trailing) {
                if let subTitle1 = self.subTitle1, !subTitle1.isEmpty {
                    Text(subTitle1)
                        .fontWeight(.semibold)
                        .font(tm.typo.headline)
                        .foregroundColor(tm.theme.labelColorPrimary)
                }
                if let secondaryText = self.secondaryText, !secondaryText.isEmpty {
                    Text(secondaryText)
                        .fontWeight(.medium)
                        .font(tm.typo.subheadline)
                        .foregroundColor(tm.theme.labelColorSecondary)
                }
            }
            self.rightIconBox
                .padding(.leading, 16)
        }
        .padding(16)
    }
}

#if DEBUG
struct ListItem1_Previews: PreviewProvider {
    static let tm = ThemeManager(theme: Theme(types: .basic),
                          lang: Language(types: .english),
                          typo: Typography(types: .basic))

    static var previews: some View {
        VStack {
            ListItemMobile(subTitle1: "SubTitle1",
                           secondaryText: "secondaryText",
                           rightIconBox: Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .frame(width: 32, height: 32))
        }
        .environmentObject(tm)
        .previewLayout(.sizeThatFits)

        VStack {
            ListItemMobile(subTitle1: "SubTitle1",
                           secondaryText: "secondaryText",
                           rightIconBox: Circle().frame(width: 32, height: 32))
        }
        .environmentObject(tm)
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
}
#endif
