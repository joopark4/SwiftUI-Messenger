//
//  FriendInvitePage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerRelationshipFriendsUI

struct FriendInvitePage: View {
    @EnvironmentObject var tm: ThemeManager
    @Environment(\.presentationMode) var presentationMode

    @State var showCopyAlert = false

    let viewModel: FriendsViewModel

    init(viewModel: FriendsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            Section(header: subTitle) {
                shareButton
                copyButton
            }
        }
        .listStyle(.plain)
        .navigationTitle(Text(self.tm.lang.localized("Friends.Invite.Title")))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(self.tm.theme.labelColorSecondary)
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .alert(isPresented: $showCopyAlert) {
            Alert(title: Text(""), message: Text(self.tm.lang.localized("Friends.Invite.Copy.Alert")))
        }
    }

    func actionShareSheet(item: String) {
        let activityVC = UIActivityViewController(activityItems: [item], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)

    }

    var subTitle: some View {
        SubTitleBar(title: self.tm.lang.localized("Friends.Invite.SubTitle"))
            .listRowInsets(EdgeInsets())
            .padding(.bottom, 16)
    }

    var shareButton: some View {
        Button(self.tm.lang.localized("Friends.Invite.Share")) {
            actionShareSheet(item: "test share")
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparatorHidden()
    }

    var copyButton: some View {
        Button(self.tm.lang.localized("Friends.Invite.Copy")) {
            UIPasteboard.general.string = "test copy"
            self.showCopyAlert.toggle()
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparatorHidden()
    }
}

#if DEBUG
struct InviteFriendPage_Previews: PreviewProvider {
    static let tm = ThemeManager()
    static var previews: some View {
        FriendInvitePage(viewModel: FriendsViewModel())
            .environmentObject(tm)
    }
}
#endif
