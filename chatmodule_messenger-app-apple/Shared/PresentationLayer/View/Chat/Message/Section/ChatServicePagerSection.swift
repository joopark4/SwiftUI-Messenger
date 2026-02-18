//
//  ChatServicePagerSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerChatMessagesUI
import ChatModuleMessengerUI

struct ChatServicePagerSection: View {
    @EnvironmentObject var tm: ThemeManager
    @State var index = 0
    private var selectService: (MediaInputType) -> Void

    init(selectService: @escaping (MediaInputType) -> Void) {
        self.selectService = selectService
    }

    var body: some View {
        LazyHStack {
            VStack(spacing: 0) {
                Spacer()

                indicator

                Spacer()

                TabView(selection: $index) {
                    tab1
                        .tag(0)
                    tab2
                        .tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .frame(width: UIScreen.main.bounds.size.width)

        }
        .background(tm.theme.systemBackgroundSecondary)
    }

    private var indicator: some View {
        HStack {
            Circle()
                .frame(width: 8, height: 8)
                .foregroundColor(index == 0 ? tm.theme.labelColorPrimary : tm.theme.labelColorTertiary)

            Circle()
                .frame(width: 8, height: 8)
                .foregroundColor(index == 1 ? tm.theme.labelColorPrimary : tm.theme.labelColorTertiary)
        }
        .frame(height: 24)
    }

    private var tab1: some View {
        VStack(spacing: 24) {
            HStack {

                Spacer()

                Button {
                    selectService(.ALBUM)
                } label: {
                    ChatServiceItemSection(mediaInputInfo: .ALBUM, iconBackgroundColor: tm.theme.systemGreen)
                }

                Spacer()

                Button {
                    selectService(.CAMERA)
                } label: {
                    ChatServiceItemSection(mediaInputInfo: .CAMERA, iconBackgroundColor: tm.theme.systemBlue)
                }

                Spacer()

                Button {
                    selectService(.VOICE_REC)
                } label: {
                    ChatServiceItemSection(mediaInputInfo: .VOICE_REC, iconBackgroundColor: tm.theme.systemOrange)
                }

                Spacer()

                Button {
                    selectService(.CONTACTS)
                } label: {
                    ChatServiceItemSection(mediaInputInfo: .CONTACTS, iconBackgroundColor: tm.theme.systemBlue)
                }

                Spacer()
            }

            HStack {

                Spacer()

                Button {
                    selectService(.MUSIC)
                } label: {
                    ChatServiceItemSection(mediaInputInfo: .MUSIC, iconBackgroundColor: tm.theme.systemTeal)
                }

                Spacer()

                Button {
                    selectService(.CAPTURED)
                } label: {
                    ChatServiceItemSection(mediaInputInfo: .CAPTURED, iconBackgroundColor: tm.theme.systemGreen)
                }

                Spacer()

                Button {
                    selectService(.FILE)
                } label: {
                    ChatServiceItemSection(mediaInputInfo: .FILE, iconBackgroundColor: tm.theme.systemIndigo)
                }

                Spacer()

                Button {
                    selectService(.CALENDER)
                } label: {
                    ChatServiceItemSection(mediaInputInfo: .CALENDER, iconBackgroundColor: tm.theme.systemGray)
                }

                Spacer()

            }
        }
        .padding(.horizontal, 20)
    }

    private var tab2: some View {
        VStack(spacing: 24) {
            HStack {

                Spacer()

                Button {} label: {
                    ChatServiceItemSection(mediaInputInfo: .ALBUM, iconBackgroundColor: tm.theme.systemGreen)
                }

                Spacer()

                Button {} label: {
                    ChatServiceItemSection(mediaInputInfo: .CAMERA, iconBackgroundColor: tm.theme.systemBlue)
                }

                Spacer()

                Button {} label: {
                    ChatServiceItemSection(mediaInputInfo: .VOICE_REC, iconBackgroundColor: tm.theme.systemOrange)
                }

                Spacer()

                Button {} label: {
                    ChatServiceItemSection(mediaInputInfo: .CONTACTS, iconBackgroundColor: tm.theme.systemBlue)
                }

                Spacer()
            }

            HStack {

                Spacer()

                Button {} label: {
                    ChatServiceItemSection(mediaInputInfo: .MUSIC, iconBackgroundColor: tm.theme.systemTeal)
                }

                Spacer()

                Button {} label: {
                    ChatServiceItemSection(mediaInputInfo: .CAPTURED, iconBackgroundColor: tm.theme.systemGreen)
                }

                Spacer()

                Button {} label: {
                    ChatServiceItemSection(mediaInputInfo: .FILE, iconBackgroundColor: tm.theme.systemIndigo)
                }

                Spacer()

                Button {} label: {
                    ChatServiceItemSection(mediaInputInfo: .CALENDER, iconBackgroundColor: tm.theme.systemGray)
                }

                Spacer()

            }
        }
        .padding(.horizontal, 20)
    }
}

#if DEBUG
struct ChatServicePagerSection_Previews: PreviewProvider {
    static var previews: some View {
        ChatServicePagerSection(selectService: { _ in

        })
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
