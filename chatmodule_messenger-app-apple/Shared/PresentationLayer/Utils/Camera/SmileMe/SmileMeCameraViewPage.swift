//
//  SmileMeCameraViewPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI

struct SmileMeCameraViewPage: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) var presentationMode

    @State var infoAction = false
    @State var saveAction = false

    var body: some View {
        NavigationView {
            SmilemeCameraView { url in
                debugLog(url)
                self.saveAction.toggle()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarColor(backgroundColor: UIColor(appState.tm.theme.systemBackground),
                                tintColor: UIColor(appState.tm.theme.labelColorPrimary))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(self.appState.tm.theme.labelColorPrimary)
                    }
                }

                ToolbarItem(placement: .primaryAction) {
                    Button {
                        self.infoAction.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(self.appState.tm.theme.labelColorPrimary)
                    }
                    .alert(isPresented: $infoAction) {
                        Alert(title: Text(""),
                              message: Text(appState.tm.lang.localized("SmileMe.Info")),
                              dismissButton: .cancel(Text(appState.tm.lang.localized("Common.Ok"))))
                    }
                }
            }
        }
        .alert(isPresented: $saveAction) {
            Alert(title: Text(""),
                  message: Text(appState.tm.lang.localized("SmileMe.Preview.Saved")),
                  dismissButton: .cancel(Text(appState.tm.lang.localized("Common.Ok")), action: {
            }))
        }
    }
}

struct SmileMeCameraViewPage_Previews: PreviewProvider {
    static var previews: some View {
        SmileMeCameraViewPage()
            .environmentObject(AppState())
    }
}
