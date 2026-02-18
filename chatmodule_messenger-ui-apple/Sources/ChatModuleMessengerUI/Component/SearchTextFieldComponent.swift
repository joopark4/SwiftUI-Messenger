//
//  SearchTextFieldComponent.swift
//  ChatModuleMessengerUI
//

import Foundation
import SwiftUI
import Combine


/// Search TextField
///
/// Customize components > search text field
///
///
/// Usage:
///
///       SearchTextFieldComponent(inputString: .constant(""), placeHoldText: "search",
///                                leadingImage: Image(systemName: "magnifyingglass")
///                                   .font(.system(size: 17))
///                                   .foregroundColor(Color.gray)
///                                   .padding(.leading, 8),
///                                clearButton: Image(systemName: "xmark.circle.fill")
///                                   .foregroundColor(Color.gray)
///                                   .padding(.trailing, 16),
///                                cancelButton: Button(action: {
///
///                                 }, label: {
///                                 Text("취소")
///                                 .foregroundColor(Color.purple)
///                                 .padding(.horizontal, 18.5)
///                                 }))
///
public struct SearchTextFieldComponent<LeadingImage: View, ClearButton: View, CancelButton: View>: View {
    @EnvironmentObject var tm: ThemeManager
    
    @Binding var inputString: String
    private let placeHoldText: String
    private let leadingImage: LeadingImage
    private let clearButton: ClearButton
    private let cancelButton: CancelButton
    
    
    /// Search TextField
    /// - Parameters:
    ///   - inputString: input string to bind
    ///   - placeHoldText: placehold text
    ///   - leadingImage: leading imaeg area
    ///   - clearButton: clear area
    ///   - cancelButton: cancle area
    public init(inputString: Binding<String>, placeHoldText: String, leadingImage: LeadingImage, clearButton: ClearButton, cancelButton: CancelButton) {
        _inputString = inputString
        self.placeHoldText = placeHoldText
        self.leadingImage = leadingImage
        self.clearButton = clearButton
        self.cancelButton = cancelButton
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            HStack {
                leadingImage
                
                TextField(placeHoldText, text: $inputString)
                
                clearButton
            }
            .frame(height: 44)
            .background(tm.theme.fillColorTertiary)
            .cornerRadius(8)
            .padding(.leading, 16)
            
            cancelButton
        }
        .frame(height: 56)
    }
    
}


#if DEBUG
struct SearchTextFieldComponent_Previews: PreviewProvider {

    static var previews: some View {
        SearchTextFieldComponent(inputString: .constant(""), placeHoldText: "search",
                                 leadingImage: Image(systemName: "magnifyingglass")
                                    .font(.system(size: 17))
                                    .foregroundColor(Color.gray)
                                    .padding(.leading, 8),
                                 clearButton: Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(Color.gray)
                                    .padding(.trailing, 16),
                                 cancelButton: Button(action: {
            
        }, label: {
            Text("취소")
                .foregroundColor(Color.purple)
                .padding(.horizontal, 18.5)
        }))
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
