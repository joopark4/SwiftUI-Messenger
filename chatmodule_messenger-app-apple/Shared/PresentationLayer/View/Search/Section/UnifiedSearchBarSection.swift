//
//  UnifiedSearchBarSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import Combine
import ChatModuleMessengerUI

public struct UnifiedSearchBarSection: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var tm: ThemeManager

    @Binding var inputString: String

    public var body: some View {

        SearchTextFieldComponent(inputString: $inputString,
                                 placeHoldText: tm.lang.localized("Search.UnifiedSearch.PlaceHold"),
                                 leadingImage: searchIcon,
                                 clearButton: qrcodeIcon,
                                 cancelButton: cancleButton)
    }

    private var searchIcon: some View {
        Image(systemName: "magnifyingglass")
           .font(.system(size: 17))
           .foregroundColor(tm.theme.systemGray)
           .padding(.leading, 8)
    }

    private var qrcodeIcon: some View {
        Image(systemName: "qrcode.viewfinder")
            .font(.system(size: 24))
            .foregroundColor(tm.theme.systemGray)
            .padding(.trailing, 16)
    }

    private var cancleButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Text(tm.lang.localized("Common.Cancel"))
            .font(tm.typo.body)
            .foregroundColor(Color.purple)
            .padding(.horizontal, 18.5)
        })
    }
}

#if DEBUG
struct UnifiedSearchBarSection_Previews: PreviewProvider {
    static var previews: some View {
        UnifiedSearchBarSection(inputString: .constant(""))
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
