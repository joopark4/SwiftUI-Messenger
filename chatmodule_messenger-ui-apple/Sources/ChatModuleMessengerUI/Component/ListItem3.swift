//
//  ListItem3.swift
//  ChatModuleMessengerUI
//

import SwiftUI

/// ListItem Default Half Left Icon Component
///
/// Customize components > lists item3 > list_item-default-half-leftIcon
///
///
/// Usage:
///
///       ListItemDefaultHalfLeftIconComponent(leftIconBox: Circle().frame(width: 32, height: 32),
///                                            subTitle1: "SubTitle1",
///                                            subTitle2: "SubTitle2",
///                                            iconText: Label("Lorem", systemImage: "checkmark.circle.fill"),
///                                            rightIconBox: Image(systemName: "chevron.right"))
///
public struct ListItemDefaultHalfLeftIconComponent<LeftBox: View, SubTitle1: View, SubTitle2: View, RightBox: View, IconText: View>: View {
    @EnvironmentObject var tm: ThemeManager
    var leftIconBox: LeftBox
    var subTitle1: SubTitle1
    var subTitle2: SubTitle2
    var iconText: IconText?
    var rightIconBox: RightBox

    /// Create ListItemHalfMobileLeftIconComponent
    ///
    /// - Parameters:
    ///   - leftIconBox: left icon area
    ///   - subTitle1: subTitle1 text
    ///   - subTitle2: subTitle2 text
    ///   - iconText: iconText label area
    ///   - rightIconBox: right icon area
    public init(leftIconBox: LeftBox,
                subTitle1: SubTitle1,
                subTitle2: SubTitle2,
                iconText: IconText,
                rightIconBox: RightBox) {
        self.leftIconBox = leftIconBox
        self.subTitle1 = subTitle1
        self.subTitle2 = subTitle2
        self.iconText = iconText
        self.rightIconBox = rightIconBox
    }

    public var body: some View {
        HStack(spacing: 0) {
            self.leftIconBox
                .padding(.trailing, 16)
            self.subTitle1
            
            self.subTitle2
            
            self.iconText

            Spacer()
            self.rightIconBox
                .padding(.leading, 16)
        }
        .padding(16)
    }
}

/// List Item Half Mobile Icon
///
/// Customize components > lists item3 > list_item-half-mobile-leftIcon
///
///
/// Usage:
///
///       ListItemHalfMobileLeftIconComponent(
///           leftIconBox: Circle().frame(width: 32, height: 32),
///           subTitle1: "SubTitle1",
///           subTitle2: "SubTitle2",
///           iconText: Label("Lorem", systemImage: "checkmark.circle.fill"),
///           rightIconBox: EmptyView()
///       )
///
public struct ListItemHalfMobileLeftIconComponent<LeftBox: View, RightBox: View, IconText: View>: View {
    @EnvironmentObject var tm: ThemeManager
    var leftIconBox: LeftBox
    var subTitle1: String?
    var subTitle2: String?
    var iconText: IconText?
    var rightIconBox: RightBox

    /// Create ListItemHalfMobileLeftIcon
    ///
    /// - Parameters:
    ///   - leftIconBox: left icon area.
    ///   - subTitle1: subTitle1 text
    ///   - subTitle2: subTitle2 text
    ///   - iconText: iconText label area
    ///   - rightIconBox: right icon area
    public init(leftIconBox: LeftBox,
                subTitle1: String? = nil,
                subTitle2: String? = nil,
                iconText: IconText,
                rightIconBox: RightBox) {
        self.leftIconBox = leftIconBox
        self.subTitle1 = subTitle1
        self.subTitle2 = subTitle2
        self.iconText = iconText
        self.rightIconBox = rightIconBox
    }

    public var body: some View {
        HStack(spacing: 0) {
            self.leftIconBox
                .padding(.trailing, 16)
            VStack(alignment: .leading) {
                if let subTitle1 = self.subTitle1, !subTitle1.isEmpty {
                    Text(subTitle1)
                        .fontWeight(.semibold)
                        .font(tm.typo.headline)
                        .foregroundColor(tm.theme.labelColorPrimary)
                }
                if let subTitle2 = self.subTitle2, !subTitle2.isEmpty {
                    Text(subTitle2)
                        .fontWeight(.medium)
                        .font(tm.typo.subheadline)
                        .foregroundColor(tm.theme.labelColorSecondary)
                }
                self.iconText
                    .font(tm.typo.subheadline)
                    .foregroundColor(tm.theme.labelColorSecondary)
            }
            Spacer()
            self.rightIconBox
                .padding(.leading, 16)
        }
        .padding(16)
    }
}


/// List Item Half Mobile Center Icon
///
/// Customize components > lists info item3 > half-mobile-leftIcon
///
///
/// Usage:
///
///       ListItemHalfMobileCenterIcon(
///           topIconBox: Circle().frame(width: 32, height: 32),
///           subTitle1: Button(action: { }, label: { Text("title") }),
///           subTitle2: "SubTitle2",
///           iconText: Label("Lorem", systemImage: "checkmark.circle.fill"),
///           bottomIconBox: EmptyView()
///       )
///
public struct ListItemHalfMobileCenterIcon<TopBox: View, SubTitle1Box: View, IconTextBox: View, BottomBox: View>: View {

    @EnvironmentObject var tm: ThemeManager
    var iconBox: TopBox
    var subTitle1: SubTitle1Box
    var subTitle2: String?
    var iconText: IconTextBox
    var bottomIconBox: BottomBox
    var alignment: HorizontalAlignment

    /// Create ListItemHalfMobileCenterIcon
    ///
    /// - Parameters:
    ///   - topIconBox: left icon area.
    ///   - subTitle1: subtitle area
    ///   - subTitle2: subTitle2 text
    ///   - iconText: iconText label area
    ///   - bottomIconBox: right icon area
    public init(topIconBox: TopBox,
                subTitle1: SubTitle1Box,
                subTitle2: String? = nil,
                iconText: IconTextBox,
                bottomIconBox: BottomBox,
                alignment: HorizontalAlignment = .center) {
        self.iconBox = topIconBox
        self.subTitle1 = subTitle1
        self.subTitle2 = subTitle2
        self.iconText = iconText
        self.bottomIconBox = bottomIconBox
        self.alignment = alignment
    }

    public var body: some View {
        VStack(alignment: self.alignment, spacing: 0) {
            self.iconBox
                .padding(.bottom, 16)

            subTitle1

            if let subTitle2 = self.subTitle2, !subTitle2.isEmpty {
                Text(subTitle2)
                    .fontWeight(.medium)
                    .font(tm.typo.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(tm.theme.labelColorSecondary)
            }

            iconText
                .padding(.top, self.alignment == .leading ? 8 : 0)

            self.bottomIconBox
                .padding(.top, 16)
        }
    }
}

struct ListItem3_Previews: PreviewProvider {
    static var previews: some View {

        VStack {

            ListItemDefaultHalfLeftIconComponent(leftIconBox: Circle().frame(width: 32, height: 32),
                                                 subTitle1: Text("SubTitle1")
                                                             .fontWeight(.semibold)
                                                             .padding(.trailing, 16),
                                                 subTitle2: Text("SubTitle2")
                                                             .fontWeight(.medium)
                                                             .padding(.trailing, 16),
                                                 iconText: Label("Lorem", systemImage: "checkmark.circle.fill"),
                                                 rightIconBox: Image(systemName: "chevron.right"))
            ListItemHalfMobileLeftIconComponent(
                leftIconBox: Circle().frame(width: 32, height: 32),
                subTitle1: "SubTitle1",
                subTitle2: "SubTitle2",
                iconText: Label("Lorem", systemImage: "checkmark.circle.fill"),
                rightIconBox: Button("Button") {})

            ListItemHalfMobileCenterIcon(
                topIconBox: Circle().frame(width: 32, height: 32),
                subTitle1: Button(action: { }, label: { Text("title") }),
                subTitle2: "SubTitle2",
                iconText: Label("Lorem", systemImage: "checkmark.circle.fill"),
                bottomIconBox: EmptyView())

        }
        .previewLayout(.sizeThatFits)
        .environmentObject(ThemeManager())
    }
}
