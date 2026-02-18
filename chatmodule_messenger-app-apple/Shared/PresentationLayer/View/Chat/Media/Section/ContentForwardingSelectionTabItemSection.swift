//
//  ContentForwardingSelectionTabItemSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

struct ContentForwardingSelectionTabItemSection: View {

    @EnvironmentObject var tm: ThemeManager

    @Binding private var selectItem: Int

    init(selectItem: Binding<Int> = .constant(0)) {
        _selectItem = selectItem
    }

    var body: some View {
        VStack {
            Picker(selection: $selectItem) {
                Text(tm.lang.localized("Friends")).tag(0)
                Text(tm.lang.localized("ChatRoom")).tag(1)
            } label: {

            }
            .font(.system(size: 15))
            .pickerStyle(.segmented)
        }
    }
}

struct ContentForwardingSelectionTabItemSection_Previews: PreviewProvider {
    static var previews: some View {
        ContentForwardingSelectionTabItemSection(selectItem: .constant(0))
    }
}
