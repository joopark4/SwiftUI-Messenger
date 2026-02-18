//
//  ServiceItem.swift
//  ChatModuleMessengerUI
//

import SwiftUI

/// Service Item
///
/// Customize components > Service Item
///
///
/// Usage:
///
///     let icon = Image(systemName: "trash")
///     let subTitle = Text("쓰레기")
///     ServiceItemComponent(icon: icon, subTitle: subTitle)
///
public struct ServiceItemComponent<Icon: View, SubTitle: View>: View {
    var icon: Icon
    var subTitle: SubTitle
    
    /// Service Item
    /// - Parameters:
    ///   - icon: icon area
    ///   - subTitle: title area
    public init(icon: Icon, subTitle: SubTitle) {
        self.icon = icon
        self.subTitle = subTitle
    }
    
    public var body: some View {
        VStack {
            self.icon
            self.subTitle
        }
    }
}

#if DEBUG
struct ServiceItemComponent_Previews: PreviewProvider {
    static var previews: some View {
        let icon = Image(systemName: "trash")
        let subTitle = Text("쓰레기")
        ServiceItemComponent(icon: icon, subTitle: subTitle)
            .previewLayout(.sizeThatFits)
    }
}
#endif
