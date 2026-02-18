//
//  FormField.swift
//  ChatModuleMessengerUI
//

import SwiftUI
import Combine

/// FormField
///
/// customize components > form-field
///
///
public struct FormField: View {

    @EnvironmentObject var tm: ThemeManager

    @Binding private var inputText: String
    @Binding private var disableEditing: Bool

    private let inputLimit: Int
    private let placeHoldText: String
    private let caption: String
    private let counterHidden: Bool

    ////// create FormField
    /// - Parameters:
    ///   - inputText: input text binding
    ///   - placeHoldText: place holed text
    ///   - inputLimit: max text count
    ///   - caption: caption info text
    ///   - counterHidden: counter info text hidden (default: false)
    public init(inputText: Binding<String>, placeHoldText: String = "", inputLimit: Int, caption: String = "", counterHidden: Bool = false, disableEditing: Binding<Bool>? = nil) {
        _inputText = inputText
        self.placeHoldText = placeHoldText
        self.inputLimit = inputLimit
        self.caption = caption
        self.counterHidden = counterHidden
        _disableEditing = disableEditing ?? .constant(false)
    }

    public var body: some View {
        VStack {
            HStack {
                textField

                Spacer()

                if inputText.count > 0 {
                    clearButton
                }
            }

            Divider()

            Caption(caption: caption, counter: inputText.count, maxCount: inputLimit, counterHidden: counterHidden)
                .disabled(self.disableEditing)
        }
        .padding(.leading, 16)
    }
}

extension FormField {

    private var textField: some View {
        TextField(placeHoldText, text: $inputText)
            .onReceive(Just(inputText)) { _ in
                limitText(inputLimit)
            }
            .textFieldStyle(.plain)
            .foregroundColor((self.disableEditing) ? tm.theme.labelColorTertiary : tm.theme.labelColorPrimary)
            .disabled(self.disableEditing)
    }

    private var clearButton: some View {
        Button(action: {
            self.inputText.removeAll()
        }, label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(tm.theme.systemGray)
        })
        .frame(width: 17, height: 17)
        .padding(.trailing, 16)
    }

    private func limitText(_ upper: Int) {
        if inputText.count > upper {
            inputText = String(inputText.prefix(upper))
        }
    }
}

#if DEBUG
struct FormField_Previews: PreviewProvider {
    static let tm = ThemeManager(theme: Theme(types: .basic),
                          lang: Language(types: .english),
                          typo: Typography(types: .basic))

    static var previews: some View {
        VStack {
            FormField(inputText: .constant("2345"), placeHoldText: "친구 이름", inputLimit: 35, disableEditing: .constant(false))
                .environmentObject(tm)
            FormField(inputText: .constant("2345"), placeHoldText: "친구 이름", inputLimit: 35)
                .environmentObject(tm)
        }
    }
}
#endif
