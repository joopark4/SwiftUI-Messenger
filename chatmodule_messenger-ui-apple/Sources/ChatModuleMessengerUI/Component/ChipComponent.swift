//
//  ChipComponent.swift
//  ChatModuleMessengerUI
//

import SwiftUI

/// Chip
///
/// customize components > Chip
///
///
/// Usage:
///
///
///     ChipComponent(profile: Image(systemName: "person.fill")
///                                  .frame(width: 18, height: 18),
///                                title: Text("body text"),
///                                deleteButton: Button(action: {}, label: {
///                                  Image(systemName: "xmark")
///                              }))
///
///
public struct ChipComponent<Profile: View, Title: View, DeleteButton: View>: View {
    @EnvironmentObject var tm: ThemeManager
    
    private let profile: Profile
    private let title: Title
    private let deleteButton: DeleteButton
    
    
    /// Create Chip
    ///
    /// - Parameters:
    ///   - profile: profile area
    ///   - title: title area
    ///   - deleteButton: button area
    public init (profile: Profile, title: Title, deleteButton: DeleteButton) {
        self.profile = profile
        self.title = title
        self.deleteButton = deleteButton
    }
    
    public var body: some View {
        HStack {
            HStack(spacing: 4) {
                profile
                
                title
                
                deleteButton
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            
        }
        .background(tm.theme.fillColorPrimary)
        .cornerRadius(14)
    }
}

#if DEBUG
struct ChipComponent_Previews: PreviewProvider {
    static var previews: some View {
        ChipComponent(profile: Image(systemName: "person.fill")
                        .frame(width: 18, height: 18),
                      title: Text("body text"),
                      deleteButton: Button(action: {}, label: {
                        Image(systemName: "xmark")
                    }))
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
