//
//  ProfilePage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

struct ProfilePage: View {

    @EnvironmentObject var tm: ThemeManager
    @Environment(\.presentationMode) var presentationMode

    var favorites = true

    var body: some View {
        NavigationView {
            ZStack {
                tm.theme.befamilySecondaryVariant.edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()

                    ProfileThumbnailSection(profileType: .FRIEND_EDIT, name: "New Profile")
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(tm.theme.labelColorPrimary)
                            .font(.system(size: 17, weight: .regular))
                            .font(.body)
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    if favorites {
                        Button {
                            // action
                        } label: {
                            Image(systemName: "star.circle")
                                .foregroundColor(tm.theme.labelColorPrimary)
                                .font(.system(size: 24))
                        }
                    }
                }
            }
        }
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
