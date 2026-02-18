//
//  SelectCountryPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import Combine

struct SelectCountryPage: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var appState: AppState
    @StateObject var searchBar: SearchBar = SearchBar()
    @ObservedObject var selectCountryViewModel: SelectCountryViewModel

    @Binding var selectCountryCode: String

    init(selectCountryViewModel: SelectCountryViewModel, selectCountryCode: Binding<String>) {
        self.selectCountryViewModel = selectCountryViewModel
        self._selectCountryCode = selectCountryCode
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(selectCountryViewModel.countryList.filter {
                    searchBar.text.isEmpty ||
                    $0.countryName.localizedStandardContains(searchBar.text) ||
                    $0.regionNumber.localizedStandardContains(searchBar.text)}, id: \.countryCode) { country in

                    Button(action: {
                        self.selectCountryViewModel.regionNumber = country.regionNumber
                        selectCountryCode = country.countryCode
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        // TODO: figma에 listitem2로 변경해야함
                        HStack {
                            Text(country.countryName)
                            Spacer()
                            Text(country.regionNumber)
                                .font(appState.tm.typo.body)
                                .foregroundColor(self.selectCountryCode == country.countryCode ?
                                                 appState.tm.theme.systemPurple : appState.tm.theme.labelColorSecondary)
                        }
                    })
                    .listRowSeparatorHidden()
                }
            }
            .listStyle(.plain)
            .add(searchBar, hideSearchBarWenScroll: false)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    closeButton
                }

                ToolbarItem(placement: .principal) {
                    Text(self.appState.tm.lang.localized("Contact.SelectCountry"))
                        .font(self.appState.tm.typo.title3)
                }
            }
            .onAppear {
                selectCountryViewModel.fetchCountryListService(countryCode: appState.appSetting.countryCode)
            }
        }
    }

    private var closeButton: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark")
                .foregroundColor(self.appState.tm.theme.labelColorPrimary)
        }
    }
}

 #if DEBUG
 struct SelectContryPage_Previews: PreviewProvider {
    static var previews: some View {
        SelectCountryPage(selectCountryViewModel: SelectCountryViewModel(), selectCountryCode: .constant("KR"))
            .environmentObject(AppState())
    }
 }
 #endif
