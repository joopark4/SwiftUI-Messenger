//
//  FriendAddPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerRelationshipFriendsUI

struct FriendAddPage: View {
    @EnvironmentObject var appState: AppState

    @ObservedObject var friendViewModel: FriendsViewModel
    @ObservedObject var selectCountryViewModel: SelectCountryViewModel

    @Environment(\.presentationMode) var presentationMode

    @State private var friendNameInput: String = ""
    @State private var phoneNumberInput: String = ""
    @State private var addSuccess: Bool = false
    private let inputLimit: Int = 20

    @State private var selectCountryAction: Bool = false
    @State private var defaultCountryCode: String = ""

    init(friendViewModel: FriendsViewModel, selectCountryViewModel: SelectCountryViewModel) {
        self.friendViewModel = friendViewModel
        self.selectCountryViewModel = selectCountryViewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                inputFriendName
                inputPhoneNumber

                if addSuccess {
                    addFriendInfo
                        .padding(.top, 30)
                }

                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(appState.tm.lang.localized("Friends.AddFriendByContact"))
            .navigationBarColor(backgroundColor: UIColor(appState.tm.theme.systemBackground),
                                tintColor: UIColor(appState.tm.theme.labelColorPrimary))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        if addSuccess {
                            Image(systemName: "xmark")
                                .font(appState.tm.typo.body)
                        } else {
                            Text(appState.tm.lang.localized("Common.Cancel"))
                                .font(appState.tm.typo.body)
                        }
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    if !addSuccess {
                        Button {
                            let add = FriendsAddUseCaseRequestValue(friendName: self.friendNameInput,
                                                                    phoneNumber: self.phoneNumberInput)
                            self.friendViewModel.addFriend(friendInfo: add) { result in
                                switch result {
                                case .success(let data):
                                    self.addSuccess = true
                                    print(data)
                                case .failure(let error):
                                    self.addSuccess = false
                                    print(error.localizedDescription)
                                }
                            }
                        } label: {
                            Text(appState.tm.lang.localized("Common.Ok"))
                                .font(appState.tm.typo.body)
                        }
                    }
                }
            }
        }
    }
}

extension FriendAddPage {

    private var inputFriendName: some View {
        VStack {
            SubTitleBar(title: appState.tm.lang.localized("Friends.FriendName"))
            FormField(inputText: $friendNameInput,
                      placeHoldText: appState.tm.lang.localized("Friends.FriendName"),
                      inputLimit: inputLimit,
                      disableEditing: $addSuccess)
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }

    private var inputPhoneNumber: some View {
        VStack {
            SubTitleBar(title: appState.tm.lang.localized("Contact"))
            HStack {
                VStack {
                    Button {
                        self.selectCountryAction.toggle()
                    } label: {
                        Text(selectCountryViewModel.regionNumber)
                        Image(systemName: "chevron.down")
                    }
                    .sheet(isPresented: $selectCountryAction) {
                        SelectCountryPage(selectCountryViewModel: selectCountryViewModel, selectCountryCode: $defaultCountryCode)
                    }
                    .font(appState.tm.typo.body)
                    .foregroundColor(addSuccess ? appState.tm.theme.labelColorTertiary : appState.tm.theme.labelColorPrimary)
                    .disabled(addSuccess)

                    Divider()
                }
                .frame(width: 84, height: 22, alignment: .center)
                .padding(EdgeInsets(top: -24, leading: 22, bottom: 0, trailing: 0))

                Spacer()

                FormField(inputText: $phoneNumberInput,
                          placeHoldText: appState.tm.lang.localized("Contact"),
                          inputLimit: 20,
                          caption: appState.tm.lang.localized("Contact.InputInfo"),
                          counterHidden: true,
                          disableEditing: $addSuccess)
                    .padding(0)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .onAppear {
            defaultCountryCode = self.appState.appSetting.countryCode
            selectCountryViewModel.getRegionNumber(countryCode: defaultCountryCode)
        }
    }

    private var addFriendInfo: some View {

        UserProfileCenterIconItem(model:
                                    FriendEntity(account: .init(signInId: "32", username: friendNameInput)),
                                  subTitle: appState.tm.lang.localized("Friends.AddCompletion"),
                                  iconText: appState.tm.lang.localized("Contact.AddtoPhoneContacts"),
                                  inlineContent: UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate),
                                  buttonText: appState.tm.lang.localized("Message.DirectMessage"),
                                  renameEnabled: false,
                                  onButtonClick: self.directmessageButtonSelected)
    }

    private func directmessageButtonSelected() {
        print(#function)
    }
}

struct AddFriendByContactPage_Previews: PreviewProvider {
    static var previews: some View {
        FriendAddPage(friendViewModel: FriendsViewModel(), selectCountryViewModel: SelectCountryViewModel())
            .environmentObject(AppState())
    }
}
