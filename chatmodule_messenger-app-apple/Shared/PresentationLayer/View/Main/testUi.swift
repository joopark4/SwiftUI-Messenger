//
//  testUi.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

protocol testUiStyle {
    associatedtype Body: View
    typealias Configuration = testUiStyleConfiguration

    func makeBody(configuration: Self.Configuration) -> Self.Body
}

struct testUiStyleConfiguration {
    struct Text: View {
        init<Content: View>(content: Content) {
            body = AnyView(content)
        }

        var body: AnyView
    }

    let text: testUiStyleConfiguration.Text
}

// struct testUi<Content: View>: View {
//    var content: () -> Content
//
//    var body: some View {
//        content()
//    }
// }

struct  testUiDefaultStyle: testUiStyle {

    @EnvironmentObject var tm: ThemeManager

    func makeBody(configuration: Configuration) -> some View {
        configuration.text
            .font(tm.typo.headline)
            .foregroundColor(tm.theme.labelColorPrimary)
    }
}

struct testUiTextModifier: ViewModifier {

    @EnvironmentObject var tm: ThemeManager

    func body(content: Content) -> some View {
        content
            .font(tm.typo.headline)
            .foregroundColor(tm.theme.labelColorPrimary)
    }
}

public struct ListItemHalfMobileLeftIconComponent2<StartBox, SubTitle1, SubTitle2, IconText, EndBox>: View
where StartBox: View, SubTitle1: View, SubTitle2: View, IconText: View, EndBox: View {

    @EnvironmentObject var tm: ThemeManager

    private var startBox: StartBox
    private var subTitle1: SubTitle1
    private var subTitle2: SubTitle2
    private var iconText: IconText
    private var endBox: EndBox

//    private var subtitle1Str: String

    public init(@ViewBuilder startBox: () -> StartBox,
                @ViewBuilder subTitle1: () -> SubTitle1,
                @ViewBuilder subTitle2: () -> SubTitle2,
                @ViewBuilder iconText: () -> IconText,
                @ViewBuilder endBox: () -> EndBox) {

        self.startBox = startBox()
        self.subTitle1 = subTitle1()
        self.subTitle2 = subTitle2()
        self.iconText = iconText()
        self.endBox = endBox()

//        self.subtitle1Str = ""
    }

    public var body: some View {
        HStack(spacing: 0) {

            self.startBox

            VStack(alignment: .leading) {

                self.subTitle1
//                if !self.subtitle1Str.isEmpty {
//                    Text(subtitle1Str)
//                        .modifier(testUiTextModifier())
//                }

                self.subTitle2

                self.iconText

            }

            Spacer()
            self.endBox

        }
        .padding(16)
    }
}

extension ListItemHalfMobileLeftIconComponent2 where SubTitle1 == AnyView {

     public init(title: String? = nil,
                 @ViewBuilder startBox: () -> StartBox,
                 @ViewBuilder subTitle2: () -> SubTitle2,
                 @ViewBuilder iconText: () -> IconText,
                 @ViewBuilder endBox: () -> EndBox) {

         self.init {
            startBox()
         } subTitle1: {
            AnyView(
                Group {
                    if let title = title, !title.isEmpty {
                        Text(title).modifier(testUiTextModifier())
                    } else {
                        EmptyView()
                    }
                }
            )
         } subTitle2: {
             subTitle2()
         } iconText: {
             iconText()
         } endBox: {
             endBox()
         }

     }

 }

 struct ListItemHalfMobileLeftIconComponent2_Previews: PreviewProvider {
    static var previews: some View {
        ListItemHalfMobileLeftIconComponent2 {
            Text("a")
        } subTitle1: {
            Text("1")
        } subTitle2: {
            Text("ㅁ")
        } iconText: {
            Text("*")
        } endBox: {
            Text("%^")
        }
    }

 }
