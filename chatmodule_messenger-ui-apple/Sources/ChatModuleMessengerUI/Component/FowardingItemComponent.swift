//
//  FowardingItemComponent.swift
//  ChatModuleMessengerUI
//

import SwiftUI

/// Fowarding Item Component
///
/// ChatRoom > 전달
///
///
public struct FowardingItemComponent<Image: View, IconBox: View, Name: View, Bottom: View>: View {

    let image: Image
    let iconBox: IconBox
    let name: Name
    let bottom: Bottom

    public init(image: Image, iconBox: IconBox, name: Name, bottom: Bottom) {
        self.image = image
        self.iconBox = iconBox
        self.name = name
        self.bottom = bottom
    }

    public var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                image
                iconBox
            }
            name
            bottom
        }
    }
}

struct FowardingItemComponent_Previews: PreviewProvider {
    static var previews: some View {
        FowardingItemComponent(image: Image.profileImage(nil), iconBox: Image(systemName: "checkmark"), name: Text("123"), bottom: Image(systemName: "highlighter"))
    }
}
