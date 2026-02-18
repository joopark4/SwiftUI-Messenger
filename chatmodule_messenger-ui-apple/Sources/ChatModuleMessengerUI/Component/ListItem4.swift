//
//  ListItem4.swift
//  ChatModuleMessengerUI
//

import SwiftUI

/// Chat Two Line Component
///
/// Customize components > lists item4 > chat twoline
///
///
/// Usage:
///
///     ChatTwoLineComponent(checkBox: Image(systemName: "checkmark.square.fill"),
///                          avatarGroup: Image(systemName: "person.circle.fill")
///                             .resizable().frame(width: 50, height: 50),
///                          subTitle1: "subTitle1subTitle1subTitle1subTitle1subTitle1",
///                          subTitle2: "subTitle2subTitle2subTitle2subTitle2subTitle2subTitle2",
///                          amountPerson: 3,
///                          notification: Image(systemName: "bell.slash.fill"),
///                          dayText: "2025. 02. 09",
///                          badge: 2)
///
public struct ChatTwoLineComponent<CheckBox: View,
                                   AvatarBox: View,
                                   FavoriteBox: View,
                                   NotificationBox: View>: View {
    @EnvironmentObject var tm: ThemeManager
    var checkBox: CheckBox
    var avatarGroup: AvatarBox
    var subTitle1: String
    var subTitle2: String?
    var amountPerson: Int?
    var favorite: FavoriteBox?
    var notification: NotificationBox?
    var dayText: String?
    var badge: Int

    /// Create ChatTwoLineComponent
    ///
    /// - Parameters:
    ///   - checkBox: checkBox area
    ///   - avatarGroup: avatar-group area
    ///   - subTitle1: subTitle1 text
    ///   - subTitle2: subTitle2 text
    ///   - amountPerson: amounts of person
    ///   - notification: notifications icon
    ///   - dayText: date text (ex: 2025. 02. 02)
    ///   - badge: badge count
    public init(checkBox: CheckBox,
                avatarGroup: AvatarBox,
                subTitle1: String,
                subTitle2: String? = nil,
                amountPerson: Int? = nil,
                favorite: FavoriteBox,
                notification: NotificationBox,
                dayText: String? = nil,
                badge: Int = 0) {
        self.checkBox = checkBox
        self.avatarGroup = avatarGroup
        self.subTitle1 = subTitle1
        self.subTitle2 = subTitle2
        self.amountPerson = amountPerson
        self.favorite = favorite
        self.notification = notification
        self.dayText = dayText
        self.badge = badge
    }

    public var body: some View {
        HStack(spacing: 0) {
            self.checkBox
                .frame(width: 18, height: 18)
                .padding(.trailing, 16)

            self.avatarGroup
                .padding(.trailing, 16)

            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    Text(self.subTitle1)
                        .foregroundColor(tm.theme.labelColorPrimary)
                        .fontWeight(.semibold)
                        .font(tm.typo.body)

                    if let amountPerson = self.amountPerson,
                       amountPerson > 2 {
                        Text("\(amountPerson)")
                            .foregroundColor(tm.theme.labelColorSecondary)
                            .fontWeight(.medium)
                            .font(tm.typo.subheadline)
                            .padding(.leading, 4)
                    }
                    
                    if let favorite = self.favorite {
                        favorite
                            .foregroundColor(tm.theme.labelColorSecondary)
                            .frame(width: 18, height: 18)
                            .padding(.leading, 4)
                    }

                    if let notification = self.notification {
                        notification
                            .foregroundColor(tm.theme.labelColorSecondary)
                            .frame(width: 18, height: 18)
                            .padding(.leading, 4)
                    }
                }
                .frame(height: 22)

                if let subTitle2 = self.subTitle2, !subTitle2.isEmpty {
                    Text(subTitle2)
                        .foregroundColor(tm.theme.labelColorSecondary)
                        .fontWeight(.medium)
                        .font(tm.typo.subheadline)
                        .lineLimit(2)
                }
            }

            Spacer()
            
            VStack(alignment: .trailing, spacing: 8) {
                if let dayText = self.dayText, !dayText.isEmpty {
                    Text(dayText)
                        .foregroundColor(tm.theme.labelColorSecondary)
                        .fontWeight(.medium)
                        .font(tm.typo.caption)
                }
                if self.badge > 0 {
                    Text(badge > 999 ? "+999" : "\(badge)")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(tm.typo.caption2)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 4)
                        .background(Color.pink)
                        .cornerRadius(8)
                }
            }
            .padding(.leading, 16)
        }
        .frame(minHeight: 75, maxHeight: 87)
        .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
    }
}

#if DEBUG
struct ListItem4_Previews: PreviewProvider {
    static var previews: some View {
        ChatTwoLineComponent(checkBox: Image(systemName: "checkmark.square.fill"),
                             avatarGroup: Image(systemName: "person.circle.fill")
                                .resizable().frame(width: 50, height: 50),
                             subTitle1: "subTitle1subTitle1subTitle1subTitle1subTitle1",
                             subTitle2: "subTitle2subTitle2subTitle2subTitle2subTitle2subTitle2",
                             amountPerson: 3,
                             favorite: Image(systemName: "pin.fill"),
                             notification: Image(systemName: "bell.slash.fill"),
                             dayText: "2025. 02. 09",
                             badge: 2)
            .previewLayout(.sizeThatFits)
            .environmentObject(ThemeManager())
    }
}
#endif
