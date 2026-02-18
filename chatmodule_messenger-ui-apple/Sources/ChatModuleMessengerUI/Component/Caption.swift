//
//  Caption.swift
//  ChatModuleMessengerUI
//

import SwiftUI

/// Caption
///
/// customize components > caption
///
///
public struct Caption: View {

    @EnvironmentObject var tm: ThemeManager

    private var counter: Int

    private let caption: String
    private let maxCount: Int
    private let counterHidden: Bool

    /// create Caption
    ///
    /// - Parameters:
    ///   - caption: caption string
    ///   - counter: input text count
    ///   - maxCount: max input count
    public init(caption: String, counter: Int, maxCount: Int, counterHidden: Bool = false) {
        self.caption = caption
        self.counter = counter
        self.maxCount = maxCount
        self.counterHidden = counterHidden
    }

    public var body: some View {
        HStack {
            Text(caption).font(tm.typo.footnote)
                .fontWeight(.medium)
                .foregroundColor(tm.theme.labelColorSecondary)
                .frame(minWidth: 40, maxWidth: .infinity,
                       minHeight: 16, maxHeight: 16,
                       alignment: .leading)
                .padding(0)

            if !counterHidden {
                Text("\(counter)/\(maxCount)").font(tm.typo.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(tm.theme.labelColorSecondary)
                    .frame(minWidth: 40, maxWidth: 40,
                           minHeight: 16, maxHeight: 16,
                           alignment: .trailing)
                    .padding(.trailing, 8)
            }
        }
    }
}

#if DEBUG
struct Caption_Previews: PreviewProvider {
    static let tm = ThemeManager(theme: Theme(types: .basic),
                          lang: Language(types: .english),
                          typo: Typography(types: .basic))

    static var previews: some View {
        Caption(caption: "안녕하시우~", counter: 10, maxCount: 40)
            .environmentObject(tm)
    }
}
#endif
