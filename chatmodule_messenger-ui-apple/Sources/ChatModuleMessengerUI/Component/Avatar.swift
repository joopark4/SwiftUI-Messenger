//
//  Avatar.swift
//  ChatModuleMessengerUI
//

import SwiftUI

/// Avatar
///
/// customize components > Avatar
///
///
/// Usage:
///
///     
///     Avatar(icon: Image(systemName: "person.circle.fill"),
///            badge: Text("Test")
///            .frame(width: 8, height: 8))
///
/// or
///
///     Avatar(icon: Image(systemName: "person.circle.fill")
///             .resizable()
///             .frame(width: 48, height: 48),
///            badge: EmptyView())
///
///
public struct Avatar<Icon: View, Badge: View>: View {
    var icon: Icon
    var badge: Badge

    /// Create Avatar
    ///
    /// - Parameters:
    ///   - icon: icon area.
    ///   - badge: badge Icon area (require frame)
    public init(icon: Icon,
                badge: Badge) {
        self.icon = icon
        self.badge = badge
    }

    public var body: some View {
        ZStack(alignment: .topTrailing) {
            self.icon
                .clipShape(Circle())

            self.badge
        }
    }
}

/// AvatarGroup
///
/// customize components > AvatarGroup
///
///
/// Usage:
///
///     AvatarGroup(icon: Avatar(icon: Image(systemName: "person.circle.fill")
///                              .resizable()
///                              .frame(width: 32, height: 32),
///                              stateShapes: Circle(),
///                              showState: true))
///
public struct AvatarGroup<Icon: View>: View {
    var icon: Icon

    /// Create AvatarGroup
    ///
    /// - Parameters:
    ///   - icon: icon area.
    public init(icon: Icon) {
        self.icon = icon
    }

    public var body: some View {
        ZStack {
            self.icon
        }
    }
}

/// AvatarGroupBig
///
/// customize components > AvatarGroupBig
///
///
/// Usage:
///
///     AvatarGroupBig(icon: Avatar(icon: Image(systemName: "person.circle.fill")
///                                 .resizable()
///                                 .frame(width: 100, height: 100),
///                                 stateShapes: Circle()),
///                    buttonIcon: Image(systemName: "camera.fill").font(.system(size: 13)))
///
public struct AvatarGroupBig<Icon: View, ButtonIcon: View>: View {
    var icon: Icon
    var buttonIcon: ButtonIcon

    /// AvatarGroupBig
    /// - Parameters:
    ///   - icon: icon area
    ///   - buttonIcon: buttonIcon ara
    public init(icon: Icon, buttonIcon: ButtonIcon) {
        self.icon = icon
        self.buttonIcon = buttonIcon
    }

    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
            self.icon

            self.buttonIcon
            .frame(width: 24, height: 24)
        }
    }
}

#if DEBUG
struct Avatar_Previews: PreviewProvider {
    static let tm = ThemeManager(theme: Theme(types: .basic),
                          lang: Language(types: .english),
                          typo: Typography(types: .basic))

    static var previews: some View {
        VStack {
            Avatar(icon: Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32),
                   badge: Circle().frame(width: 8, height: 8))

            Avatar(icon: Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32),
                   badge: Circle().frame(width: 8, height: 8))

            Avatar(icon: Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 48, height: 48),
                   badge: Circle().frame(width: 8, height: 8))

            Avatar(icon: Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 48, height: 48),
                   badge: RoundedRectangle(cornerRadius: 4).frame(width: 8, height: 8))

            AvatarGroup(icon: Avatar(icon: Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .frame(width: 32, height: 32),
                                       badge: Circle().frame(width: 8, height: 8)))

            AvatarGroupBig(icon: Avatar(icon: Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .frame(width: 100, height: 100),
                                           badge: EmptyView()), buttonIcon: Image(systemName: "camera.fill").font(.system(size: 13))
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .mask(Circle()))
                .environmentObject(tm)

            AvatarGroupBig(icon: Avatar(icon: Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .frame(width: 100, height: 100),
                                           badge: EmptyView()), buttonIcon: EmptyView())
                .environmentObject(tm)
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif
