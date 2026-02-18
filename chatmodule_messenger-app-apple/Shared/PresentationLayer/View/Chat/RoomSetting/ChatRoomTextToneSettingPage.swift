//
//  ChatRoomTextToneSettingPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import AVKit
import ChatModuleMessengerUI
import ChatModuleMessengerChatRoomUI

enum TextToneType {
    case ting
    case chatmodule
    case lala
    case toms
    case alien
    case alpha
}

struct ChatRoomTextToneSettingPage: View {
    @EnvironmentObject var tm: ThemeManager
    @Environment(\.presentationMode) var presentationMode

    private let viewModel: ChatRoomViewModel
    @State var audioPlayer: AVAudioPlayer?
    @State var textToneType: TextToneType = .ting

    init(viewModel: ChatRoomViewModel = .init()) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            Section(header: sectionHeader(tm.lang.localized("Chat.Setting.TextTone.ChatModuleTone"))) {
                Button(action: {
                    textToneType = .ting
                    // TODO: 사운드 파일 교체 후 활성화
                    // playSound(sound: "noti_sound_001", type: "wav")
                }, label: {
                    ChatRoomTextToneItemSection(textTone: RoomTextTone(fileName: "말말"),
                                                defaultTone: true,
                                                checked: textToneType == .ting ? true : false)
                })
                .listRowInsets(EdgeInsets())
                .listRowSeparatorHidden()

                Button(action: {
                    textToneType = .chatmodule
                    // TODO: 사운드 파일 교체 후 활성화
                    // playSound(sound: "noti_sound_002", type: "wav")
                }, label: {
                    ChatRoomTextToneItemSection(textTone: RoomTextTone(fileName: "챗챗"),
                                                checked: textToneType == .chatmodule ? true : false)
                })
                .listRowInsets(EdgeInsets())
                .listRowSeparatorHidden()

                Button(action: {
                    textToneType = .lala
                }, label: {
                    ChatRoomTextToneItemSection(textTone: RoomTextTone(fileName: "쿨쿨"),
                                                checked: textToneType == .lala ? true : false)
                })
                .listRowInsets(EdgeInsets())
                .listRowSeparatorHidden()
            }

            Section(header: sectionHeader(tm.lang.localized("Chat.Setting.TextTone.SystemTone"),
                                          divider: true)) {
                Button(action: {
                    textToneType = .toms
                }, label: {
                    ChatRoomTextToneItemSection(textTone: RoomTextTone(fileName: "80s Toms"),
                                                checked: textToneType == .toms ? true : false)
                })
                .listRowInsets(EdgeInsets())
                .listRowSeparatorHidden()

                Button(action: {
                    textToneType = .alien
                }, label: {
                    ChatRoomTextToneItemSection(textTone: RoomTextTone(fileName: "Alien"),
                                                checked: textToneType == .alien ? true : false)
                })
                .listRowInsets(EdgeInsets())
                .listRowSeparatorHidden()

                Button(action: {
                    textToneType = .alpha
                }, label: {
                    ChatRoomTextToneItemSection(textTone: RoomTextTone(fileName: "Alpha"),
                                                checked: textToneType == .alpha ? true : false)
                })
                .listRowInsets(EdgeInsets())
                .listRowSeparatorHidden()
            }
        }
        .removeHeaderTopPadding()
        .listStyle(.plain)
        .navigationTitle(Text(self.tm.lang.localized("Chat.Setting.TextTone.Title")))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(self.tm.theme.labelColorSecondary)
                }
            }
        }
    }

    private func sectionHeader(_ title: String, divider: Bool = false) -> some View {
        VStack {
            if divider { Divider() }
            SubTitleBar(title: title)
                .padding(.top, 16)
        }
        .listRowInsets(EdgeInsets())

    }

    func playSound(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } catch {
                print("audio error")
            }
        }
    }
}

struct ChatRoomTextToneSettingPage_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomTextToneSettingPage()
            .environmentObject(ThemeManager())
    }
}
