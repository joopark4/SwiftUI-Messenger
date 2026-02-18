//
//  ThumbnailItem1Component.swift
//  ChatModuleMessengerUI
//

import SwiftUI

/// Thumbnail Item 1 Component
///
/// Customize components
///
/// Usage:
///
///        ThumbnailItem1Component(topBox: Image(systemName: "pencil.and.outline"),
///                               subtitle1: "가나다라",
///                                subtitle2: "abcd",
///                                subtitle3: "www.aadd.com")
///                                
public struct ThumbnailItem1Component<TopBox: View>: View {

    @EnvironmentObject var tm: ThemeManager

    let topBox: TopBox

    let subtitle1: String?
    let subtitle2: String?
    let subtitle3: String?

    public init(topBox: TopBox,
                  subtitle1: String? = nil,
                  subtitle2: String? = nil,
                  subtitle3: String?) {
        self.topBox = topBox
        self.subtitle1 = subtitle1
        self.subtitle2 = subtitle2
        self.subtitle3 = subtitle3
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            self.topBox

            Spacer()

            if let subtitle1 = subtitle1, !subtitle1.isEmpty {
                Text(subtitle1)
                    .font(.headline)
                    .font(.system(size: 17, weight: .semibold))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(tm.theme.labelColorPrimary)
                    .padding(EdgeInsets(top: 8, leading: 10, bottom: 0, trailing: 0))
            }

            if let subtitle2 = subtitle2, !subtitle2.isEmpty {
                Text(subtitle2)
                    .font(.subheadline)
                    .font(.system(size: 15, weight: .medium))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(tm.theme.labelColorSecondary)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
            }

            if let subtitle3 = subtitle3, !subtitle3.isEmpty {
                Text(subtitle3)
                    .font(.subheadline)
                    .font(.system(size: 15, weight: .regular))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(tm.theme.labelColorSecondary)
                    .padding(EdgeInsets(top: 8, leading: 10, bottom: 22, trailing: 0))
            }
        }
    }
}

struct ThumbnailItem1Component_Previews: PreviewProvider {
    static var previews: some View {
        ThumbnailItem1Component(topBox: EmptyView(), subtitle1: "가나다라", subtitle2: "abcd", subtitle3: "www.aadd.com")
    }
}
