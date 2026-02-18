//
//  RoomGoToLatestMessageSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

struct RoomGoToLatestMessageSection: View {
    @EnvironmentObject var tm: ThemeManager

    var onClick: (() -> Void)?

    var body: some View {
        Button {
            onClick?()
        } label: {
            Image(systemName: "chevron.down")
                .font(.system(size: 24))
                .foregroundColor(tm.theme.labelColorPrimary)
        }
        .frame(width: 40, height: 40)
        .background(tm.theme.befamilyBackground02Light)
        .cornerRadius(20)
        .shadow(radius: 1)
        .padding(1)

    }
}

struct RoomGoToLatestMessageSection_Previews: PreviewProvider {
    static var previews: some View {
        RoomGoToLatestMessageSection()
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
