//
//  ChatWallpaperImageItemSection.swift
//  ChatModuleMessengerChatRoomUI
//

import SwiftUI
import ChatModuleMessengerUI

/// Chat Wallpaper Image Item Section
///
/// Chat Prototype > Messenger 대화 - 대화방 설정 - 배경화면 색상배경, 배경화면 일러스트 배경
///
///
/// Usage :
///
///       ChatWallpaperImageItemSection(color: .blue,
///                                     checked: checkStatus,
///                                     onCheckChanged: onCheckStatus(check:))
///
/// or
///
///       ChatWallpaperImageItemSection(image: uiimage,
///                                     checked: checkStatus,
///                                     onCheckChanged: onCheckStatus(check:))
///
public struct ChatWallpaperImageItemSection: View {
    @EnvironmentObject var tm: ThemeManager

    var image: UIImage?
    var color: Color?
    @State var checked: Bool
    var onCheckChanged: ((Bool) -> Void)?

    /// Selection Image Background
    /// - Parameters:
    ///   - image: Background Image
    ///   - checked: check status
    ///   - onCheckChanged: click event
    public init(image: UIImage?, checked: Bool, onCheckChanged: ((Bool) -> Void)? = nil) {
        self.image = image
        _checked = State(initialValue: checked)
        self.onCheckChanged = onCheckChanged
    }

    /// Selection Color Background
    /// - Parameters:
    ///   - color: Background Image
    ///   - checked: check status
    ///   - onCheckChanged: click event
    public init(color: Color?, checked: Bool, onCheckChanged: ((Bool) -> Void)? = nil) {
        self.color = color
        _checked = State(initialValue: checked)
        self.onCheckChanged = onCheckChanged
    }

    public var body: some View {
        Button {
            self.checked.toggle()
            self.onCheckChanged?(checked)
        } label: {
            ZStack(alignment: .topTrailing) {

                if let image = image {
                    Image.profileImage(image)
                        .resizable()
                }

                if let color = color {
                    color
                }

                if checked {
                    checkedImage
                }
            }
        }
    }

    private var checkedImage: some View {
        Image(systemName: "checkmark.circle.fill")
            .foregroundColor(tm.theme.systemPurple)
            .frame(width: 28, height: 28)
    }
}

#if DEBUG
struct ChatWallpaperImageItemSection_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ChatWallpaperImageItemSection(color: .blue, checked: true, onCheckChanged: nil)
            ChatWallpaperImageItemSection(image: UIImage(systemName: "arrowshape.zigzag.forward"), checked: false, onCheckChanged: nil)
        }
    }
}
#endif
