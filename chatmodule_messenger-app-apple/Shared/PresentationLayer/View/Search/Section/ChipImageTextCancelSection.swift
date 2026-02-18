//
//  ChipImageTextCancelSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

public struct ChipImageTextCancelSection: View {
    @EnvironmentObject var tm: ThemeManager

    private var isProfile: Bool = false
    private let text: String
    private var isDeleteButton: Bool = false

    public init(isProfile: Bool, text: String, isDeleteButton: Bool) {
        self.isProfile = isProfile
        self.text = text
        self.isDeleteButton = isDeleteButton
    }

    public var body: some View {
        // 프로필 이미지를 어떤식으로 받아올지 정해지지 않았음

        ChipComponent(profile: profile,
                      title: title,
                      deleteButton: deleteButton)
    }

    @ViewBuilder
    private var profile: some View {
        if isProfile {
            Avatar(icon: Image(systemName: "person.circle.fill"), badge: EmptyView())
                .frame(width: 18, height: 18)
                .foregroundColor(tm.theme.systemPurple)
        } else {
            EmptyView()
        }
    }

    private var title: some View {
        Text(self.text)
            .font(.subheadline)
            .foregroundColor(tm.theme.labelColorPrimary)
    }

    @ViewBuilder
    private var deleteButton: some View {
        if isDeleteButton {
            Button(action: {
                print("deletButton")
            }, label: {
                Image(systemName: "xmark")
                    .font(.system(size: 15))
                    .foregroundColor(tm.theme.labelColorSecondary)
            })
        } else {
            EmptyView()
        }
    }
}

#if DEBUG
struct ChipImageTextCancelSection_Previews: PreviewProvider {
    static var previews: some View {
        ChipImageTextCancelSection(isProfile: true, text: "bodyText", isDeleteButton: true)
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
