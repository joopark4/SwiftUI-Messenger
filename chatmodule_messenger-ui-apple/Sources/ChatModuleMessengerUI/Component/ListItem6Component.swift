//
//  ListItem6Component.swift
//  ChatModuleMessengerUI
//

import SwiftUI



/// List Item 6 Component
///
/// Customize components > lists item6
///
///
/// Usage:
///
///         ListItem6Component(iConBox: Circle().frame(width: 48, height: 48),
///                   title: Text("title"),
///                   subTitle2: "subtitle2",
///                   iconText: Label("secondary text", systemImage: "square.and.arrow.up.trianglebadge.exclamationmark"),
///                   subTitle3: "subtitle3",
///                   buttonList: HStack{
///            Button {
///            } label: {
///                Text("button1")
///            }
///            Button {
///            } label: {
///                Text("button2")
///            }
///            Button {
///            } label: {
///                Text("button3")
///         }
///         })
///
public struct ListItem6Component<TopBox: View, TitleBox: View, IconTextBox: View, ButtonListBox: View>: View {

    @EnvironmentObject var tm: ThemeManager

    var iconBox: TopBox
    var title: TitleBox
    var subTitle2: String?
    var iconText: IconTextBox
    var subTitle3: String?
    var buttonList: ButtonListBox

    /// Create ListItem6Component
    ///
    /// - Parameters:
    ///   - iConBox: Top Icon Area
    ///   - title: Title Area
    ///   - subTitle2: subtitle String
    ///   - iconText: icon & text label Area
    ///   - subTitle3: subtitle3 Area
    ///   - buttonList: buttons list Area
    public init(iConBox: TopBox,
                title: TitleBox,
                subTitle2: String? = nil,
                iconText: IconTextBox,
                subTitle3: String? = nil,
                buttonList: ButtonListBox) {
        self.iconBox = iConBox
        self.title = title
        self.subTitle2 = subTitle2
        self.iconText = iconText
        self.subTitle3 = subTitle3
        self.buttonList = buttonList
    }

    public var body: some View {
        VStack(alignment: .center, spacing: 0) {
            self.iconBox.padding(.bottom, 8)

            self.title

            if let subTitle2 = subTitle2, !subTitle2.isEmpty {
                Text(subTitle2)
                    .fontWeight(.medium)
                    .font(tm.typo.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(tm.theme.labelColorSecondary)
            }

            self.iconText.padding(.bottom, 10)

            if let subTitle3 = subTitle3, !subTitle3.isEmpty {
                Text(subTitle3)
                    .fontWeight(.regular)
                    .font(tm.typo.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(tm.theme.surface_medium_emphasis)
                    .padding(.bottom, 8)
            }

            self.buttonList
        }
    }
}


struct ListItem6Component_Previews: PreviewProvider {
    static var previews: some View {
        ListItem6Component(iConBox: Circle().frame(width: 48, height: 48),
                           title: Text("title"),
                           subTitle2: "subtitle2",
                           iconText: Label("secondary text", systemImage: "square.and.arrow.up.trianglebadge.exclamationmark"),
                           subTitle3: "subtitle3",
                           buttonList: HStack{
            Button {
            } label: {
                Text("button1")
            }
            Button {
            } label: {
                Text("button2")
            }
            Button {
            } label: {
                Text("button3")
            }
        })
    }
}
