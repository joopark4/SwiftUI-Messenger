//
//  PersonRemoveComponent.swift
//  ChatModuleMessengerUI
//

import SwiftUI

/// Person Remove
///
/// Chat > 대화상대 선택 시 아바타
///
///
public struct PersonRemoveComponent<BadgeView: View>: View {
    
    @EnvironmentObject var tm: ThemeManager
    
    var iconBox: UIImage?
    var subTitle: String
    var badgeView: BadgeView
    
    public init(iconBox: UIImage? = nil,
                subTitle: String,
                badgeView: BadgeView) {
        self.iconBox = iconBox
        self.subTitle = subTitle
        self.badgeView = badgeView
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            Avatar(icon: Image.profileImage(iconBox)
                .resizable()
                .foregroundColor(tm.theme.chatmoduleColor00)
                .frame(width: 40, height: 40, alignment: .leading),
                   badge: badgeView)
            .padding(.bottom, 8)
            
            Text(subTitle).font(.caption)
                .frame(maxWidth: 52, maxHeight: 16)
                .foregroundColor(tm.theme.labelColorPrimary)
        }
    }
}

#if DEBUG
struct PersonRemoveComponent_Previews: PreviewProvider {
    static var previews: some View {
        PersonRemoveComponent(
            iconBox: UIImage(systemName: "person.crop.circle.fill")?
                .withRenderingMode(.alwaysTemplate),
            subTitle: "name",
            badgeView: Circle()
                .foregroundColor(.pink)
                .frame(width: 8, height: 8)
        )
        .environmentObject(ThemeManager())
        .previewLayout(.sizeThatFits)
    }
}
#endif
