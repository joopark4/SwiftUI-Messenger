//
//  DriveSearchBarSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

struct DriveSearchBarSection: View {

    @EnvironmentObject var tm: ThemeManager
    @Environment(\.presentationMode) var presentationMode

    @State var inputString: String = ""

    var body: some View {
        HStack {
            SearchTextFieldComponent(inputString: $inputString,
                                     placeHoldText: getPlaceHoldTextString(),
                                     leadingImage: leadingImage,
                                     clearButton: clearButton,
                                     cancelButton: cancelButton)
        }
    }

    private func getPlaceHoldTextString() -> String {
        return tm.lang.localized("Search.SendAndKeyword")
    }

    private var leadingImage: some View {
        Image(systemName: "magnifyingglass")
            .resizable()
            .font(.system(size: 17, weight: .medium))
            .foregroundColor(tm.theme.systemGray)
            .frame(width: 17, height: 17)
            .padding(.leading, 8)
    }

    @ViewBuilder
    private var clearButton: some View {
        if inputString.count > 0 {
            Button {
                inputString = ""
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(tm.theme.systemGray)
                    .padding(.trailing, 16)
            }

        } else {
            Button {
                // 달력
            } label: {
                Image(systemName: "calendar")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(tm.theme.systemGray)
                    .padding(.trailing, 16)
            }
        }
    }

    private var cancelButton: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text(tm.lang.localized("Common.Cancel"))
                .font(.body)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(tm.theme.systemPurple)
        }
        .padding([.leading, .trailing], 18)
    }
}

struct DriveSearchBarSection_Previews: PreviewProvider {
    static var previews: some View {
        DriveSearchBarSection()
    }
}
