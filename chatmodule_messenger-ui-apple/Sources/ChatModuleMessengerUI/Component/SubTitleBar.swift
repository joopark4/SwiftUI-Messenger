//
//  SubTitleBar.swift
//  ChatModuleMessengerUI
//

import SwiftUI

/// SubTitleBar
///
/// customize components > sub title bar
///
///
/// Usage:
///
///     SubTitleBar(subTitle: "안녕하세요~")
///
/// or
///
///     SubTitleBar(subTitle: "안녕하세요~", trailingImage: anyView)
///
/// or
///
///     SubTitleBar(subTitle: "안녕하세요~", bodyText: "굿!보!이~!")
///
/// or
///
///     SubTitleBar(subTitle: "안녕하세요~",
///                 bodyText: "굿!보!이~!",
///                 trailingImage: anyView)
///
///
public struct SubTitleBar<TrailingImage: View>: View {

    @EnvironmentObject var tm: ThemeManager

    private let title: String?
    private let trailingImage: TrailingImage
    private let subTitle: String?

    /// careate SubTitleBar
    /// - Parameters:
    ///   - subTitle: sub title string
    ///   - bodyText: body text string
    ///   - trailingImage: anyView
    public init(title: String? = nil,
                subTitle: String? = nil,
                @ViewBuilder trailingImage: () -> TrailingImage) {
        self.title = title
        self.trailingImage = trailingImage()
        self.subTitle = subTitle
    }

    public var body: some View {
        VStack(spacing: 4) {
            if let title = title {
                HStack {
                    Text(title).font(tm.typo.body)
                        .foregroundColor(tm.theme.labelColorPrimary)
                        .multilineTextAlignment(.leading)

                    Spacer()

                    trailingImage
                        .padding(.trailing, 8)
                }
            }

            if let body = subTitle {
                HStack {
                    Text(body).font(tm.typo.subheadline)
                        .foregroundColor(tm.theme.labelColorSecondary)
                        .multilineTextAlignment(.leading)

                    Spacer()
                }
            }
        }
        .padding(.leading, 16)
    }
}

extension SubTitleBar where TrailingImage == EmptyView {
    public init(title: String? = nil,
                subTitle: String? = nil) {
        self.init(title: title, subTitle: subTitle) {
            EmptyView()
        }
    }
}

public struct SubTitleBar2Component<LeftButton: View, RightButton: View, TrailingImage: View>: View {
    @EnvironmentObject var tm: ThemeManager
    
    private let title: String?
    private let subTitle: String?
    private let leftButton: LeftButton
    private let rightButton: RightButton
    private let trailingImage: TrailingImage
    private let isShowDivider: Bool
    
    public init (title: String? = nil, subTitle: String? = nil,
                 leftButton: LeftButton, rightButton: RightButton,
                 trailingImage: TrailingImage, isShowDivider: Bool = false) {
        self.title = title
        self.subTitle = subTitle
        self.trailingImage = trailingImage
        self.leftButton = leftButton
        self.rightButton = rightButton
        self.isShowDivider = isShowDivider
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 0) {
            SubTitleBar(title: title, subTitle: subTitle, trailingImage: { trailingImage })
            
            HStack(spacing: 0) {
                leftButton
                
                if isShowDivider {
                    Text("|")
                        .font(tm.typo.caption)
                        .padding(.horizontal, 8)
                        .foregroundColor(tm.theme.labelColorTertiary)
                }
                
                rightButton
                    .padding(.trailing, 8)
            }
            .frame(height: 21)
        }
        .padding(.vertical, 9)
    }
    
}


#if DEBUG
struct SubTitleBar_Previews: PreviewProvider {
    static let tm = ThemeManager(theme: Theme(types: .basic),
                          lang: Language(types: .english),
                          typo: Typography(types: .basic))

    static var previews: some View {
        VStack {
            SubTitleBar2Component(title: "Sub title", subTitle: "body text", leftButton: Text("action"), rightButton: Text("action"), trailingImage: Image(systemName: "questionmark.circle"))

            SubTitleBar(title: "안녕하시우깡~")

                Divider()

                SubTitleBar(title: "안녕하시우깡~",
                            trailingImage: { Button(
                                action: {
                                    //action
                                }, label: {
                                    Text("버튼")
                                })
                })

                Divider()

            SubTitleBar(title: "안녕하시우깡~", subTitle: "굿!보!이~!")

                Divider()

                SubTitleBar(title: "안녕하시우깡~", subTitle: "굿!보!이~!", trailingImage: {
                    Image(systemName: "trash.fill")
                })

                Divider()

            SubTitleBar(subTitle: "굿!보!이~!")
        }
        .environmentObject(tm)
        .previewLayout(.sizeThatFits)
    }
}
#endif
