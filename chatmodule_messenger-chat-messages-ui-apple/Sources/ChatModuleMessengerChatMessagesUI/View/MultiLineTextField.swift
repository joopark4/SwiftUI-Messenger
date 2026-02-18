//
//  MultiLineTextField.swift
//  ChatModuleMessengerChatMessagesUI
//

import SwiftUI
import ChatModuleMessengerUI

public enum MultiLineTextFieldSize: CGFloat {
    case MIN_HEIGHT = 37 // 1줄
    case MAX_HEIGHT = 118 // 5줄
}

struct MultiLineTextField: UIViewRepresentable {
    @EnvironmentObject var tm: ThemeManager
    @Binding var text: String
    @Binding var height: CGFloat
    let isDisabled: Bool

    init(text: Binding<String>,
                height: Binding<CGFloat>,
                isDisabled: Bool = false) {
        _text = text
        _height = height
        self.isDisabled = isDisabled
    }

    func makeCoordinator() -> MultiLineTextField.Coordinator {
        return MultiLineTextField.Coordinator(text: $text, height: $height)
    }

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.text = text
        view.font = .systemFont(ofSize: 17)
        view.textColor = UIColor(isDisabled ? tm.theme.labelColorTertiary :
                                    tm.theme.labelColorPrimary)
        view.backgroundColor = .clear
        view.delegate = context.coordinator

        view.isEditable = !isDisabled
        view.isUserInteractionEnabled = true
        view.isScrollEnabled = true

        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
    }

    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String
        @Binding var height: CGFloat

        init(text: Binding<String>, height: Binding<CGFloat>) {
            _text = text
            _height = height
        }

        func textViewDidBeginEditing(_ textView: UITextView) {

        }

        func textViewDidChange(_ textView: UITextView) {
            text = textView.text
            if textView.contentSize.height < MultiLineTextFieldSize.MIN_HEIGHT.rawValue {
                height = MultiLineTextFieldSize.MIN_HEIGHT.rawValue
            } else if textView.contentSize.height > MultiLineTextFieldSize.MAX_HEIGHT.rawValue {
                height = MultiLineTextFieldSize.MAX_HEIGHT.rawValue
            } else {
                height = textView.contentSize.height
            }
        }
    }
}

#if DEBUG
struct MultiLineTextField_Previews: PreviewProvider {
    @State static var previewText = "Some text"
    @State static var previewHeight: CGFloat = 37

    static var previews: some View {
        MultiLineTextField(text: $previewText, height: $previewHeight)
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
