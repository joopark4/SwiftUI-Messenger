//
//  PasscodePage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import LocalAuthentication

struct PasscodePage: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) var presentationMode
    @State var label = "Enter password"
    @State var pin: String = ""
    @State var isDisabled = false

    var maxDigits: Int = 4
    var handler: (String, (Bool) -> Void) -> Void = { pin, completion in
        completion(pin == "0000")
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                Text(label)

                ZStack {
                    pinDots
                    backgroundField
                }

                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
        .onAppear {
            authenticate()
        }
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
                debugLog(success)
                label = success ? "Unlocked" : "Enter password"
            }
        } else {
            debugLog("no biometrics : \(error?.localizedDescription ?? "")")
        }
    }

    private var pinDots: some View {
        HStack {
            Spacer()
            ForEach(0..<maxDigits) { index in
                Image(systemName: self.getImageName(at: index))
                    .font(.system(size: 24, weight: .thin, design: .default))
                Spacer()
            }
        }
    }

    private var backgroundField: some View {
        let boundPin = Binding<String>(get: { self.pin }, set: { newValue in
            self.pin = newValue
            self.submitPin()
        })

        return TextField("", text: boundPin, onCommit: submitPin)
            .accentColor(.clear)
            .foregroundColor(.clear)
            .keyboardType(.numberPad)
            .disabled(isDisabled)
    }

    private func submitPin() {
        guard !pin.isEmpty else { return }

        if pin.count == maxDigits {
            isDisabled = true

            handler(pin) { isSuccess in
                if isSuccess {
                    label = "Unlocked"
                } else {
                    label = "Enter password"
                    pin = ""
                    isDisabled = false
                }
            }
        }

        if pin.count > maxDigits {
            pin = String(pin.prefix(maxDigits))
            submitPin()
        }
    }

    private func getImageName(at index: Int) -> String {
        if index >= self.pin.count {
            return "circle"
        }

        return "circle.fill"
    }
}

struct PasscodePage_Previews: PreviewProvider {
    static var previews: some View {
        PasscodePage()
    }
}
