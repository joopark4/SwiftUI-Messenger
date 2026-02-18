//
//  ChatInfoTextComponent.swift
//  ChatModuleMessengerUI
//

import SwiftUI

/// Chat Info Text Component
///
/// Customize components > chat info text
///
///
/// Usage:
///
///     ChatInfoTextComponent {
///         Text("2025년 02월 18일")
///     }
///
public struct ChatInfoTextComponent<Content>: View where Content: View {
    @EnvironmentObject var tm: ThemeManager
    let content: () -> Content

    /// Create ChatInfoTextComponent
    /// - Parameter content: content
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        content()
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(tm.theme.labelColorTertiary)
            .cornerRadius(20)
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

#if DEBUG
struct ChatInfoTextComponent_Previews: PreviewProvider {
    static var previews: some View {
        ChatInfoTextComponent {
            Text("2025년 02월 18일")
                .font(.caption)
                .foregroundColor(.white)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(ThemeManager())
    }
}
#endif
