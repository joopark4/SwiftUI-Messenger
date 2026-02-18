//
//  ProfileThumbnailSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

enum ProfileType {
    case MY, FRIEND_EDIT, FRIEND_ADD
}

struct ProfileThumbnailSection: View {

    @EnvironmentObject var tm: ThemeManager

    let profileType: ProfileType // 임시로 타입을 만들었지만 firendInfo 값중 하나로 타입지정
    let name: String

    init(profileType: ProfileType = .MY, name: String) {
        self.profileType = profileType
        self.name = name
    }

    var body: some View {
        switch profileType {
        case .MY:
            ListItem6Component(iConBox: AvatarGroupBig(icon: Image.profileImage()
                .resizable()
                .frame(width: 100, height: 100),
                                                       buttonIcon: EmptyView()),
                               title: Text(name),
                               subTitle2: nil,
                               iconText: EmptyView(),
                               subTitle3: nil,
                               buttonList: myProfileButtons)
        case .FRIEND_EDIT:
            ListItem6Component(iConBox: AvatarGroupBig(icon: Image.profileImage()
                .resizable()
                .frame(width: 100, height: 100),
                                                       buttonIcon: EmptyView()),
                               title: Text(name),
                               subTitle2: nil,
                               iconText: EmptyView(),
                               subTitle3: nil,
                               buttonList: friendEditButtons)
        case .FRIEND_ADD:
            ListItem6Component(iConBox: AvatarGroupBig(icon: Image.profileImage()
                .resizable()
                .frame(width: 100, height: 100),
                                                       buttonIcon: EmptyView()),
                               title: Text(name),
                               subTitle2: nil,
                               iconText: EmptyView(),
                               subTitle3: nil,
                               buttonList: friendAddButtons)
        }
    }

    private var myProfileButtons: some View {
        HStack(spacing: 10) {
            Spacer()

            Button {
                // action
            } label: {
                Label("Profile.My.Chat", systemImage: "message.fill")
                    .font(tm.typo.headline)
                    .font(.system(size: 17, weight: .semibold))
                    .frame(width: 147, height: 50)
            }
            .foregroundColor(tm.theme.systemPurple)
            .padding(0)
            .background(RoundedRectangle(cornerRadius: 8).stroke(tm.theme.systemPurple, lineWidth: 1))

            Button {
                // action
            } label: {
                Label("Profile.My.Edit", systemImage: "pencil")
                    .font(tm.typo.headline)
                    .font(.system(size: 17, weight: .semibold))
                    .frame(width: 147, height: 50)
            }
            .foregroundColor(tm.theme.systemPurple)
            .padding(0)
            .background(RoundedRectangle(cornerRadius: 8).stroke(tm.theme.systemPurple, lineWidth: 1))

            Spacer()
        }
        .padding(.top, 8)
    }

    private var friendAddButtons: some View {
        HStack(spacing: 10) {
            Spacer()

            Button {
                // action
            } label: {
                Label("Profile.Friend.Add", systemImage: "person.crop.circle.badge.plus")
                    .font(tm.typo.headline)
                    .font(.system(size: 17, weight: .semibold))
                    .frame(width: 99, height: 50)
            }
            .foregroundColor(tm.theme.systemPurple)
            .padding(0)
            .background(RoundedRectangle(cornerRadius: 8).stroke(tm.theme.systemPurple, lineWidth: 1))

            Button {
                // action
            } label: {
                Label("Profile.Friend.Block", systemImage: "nosign")
                    .font(tm.typo.headline)
                    .font(.system(size: 17, weight: .semibold))
                    .frame(width: 99, height: 50)
            }
            .foregroundColor(tm.theme.systemPurple)
            .padding(0)
            .background(RoundedRectangle(cornerRadius: 8).stroke(tm.theme.systemPurple, lineWidth: 1))

            Spacer()
        }
        .padding(.top, 8)
    }

    private var friendEditButtons: some View {
        Button {
            // action
        } label: {
            Label("Message.DirectMessage", systemImage: "message.fill")
                .font(tm.typo.headline)
                .font(.system(size: 17, weight: .semibold))
                .frame(width: 99, height: 50)
        }
        .foregroundColor(tm.theme.systemPurple)
        .background(RoundedRectangle(cornerRadius: 8).stroke(tm.theme.systemPurple, lineWidth: 1))
        .padding(.top, 8)
    }
}

struct ProfileThumbnailSection_Previews: PreviewProvider {
    static var previews: some View {
        ProfileThumbnailSection(profileType: .MY, name: "TomBoy")
    }
}
