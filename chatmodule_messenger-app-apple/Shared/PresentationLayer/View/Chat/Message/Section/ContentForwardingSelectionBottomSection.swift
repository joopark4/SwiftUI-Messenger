//
//  ContentForwardingSelectionBottomSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerChatMessagesUI

struct ContentForwardingSelectionBottomSection: View {

    @EnvironmentObject var tm: ThemeManager

    @State private var checkedButtonDisable: Bool = false
    @State private var searchText: String = ""
    @State private var messageText: String = ""
    @State private var currentTabIndex: Int = 0
    @State private var searchPlacehold: String = ""
    @State private var searchEnable: Bool = false
    @State private var searchResultNotFound: Bool = false
    @State private var messageInputEnable: Bool = false
    @State private var sendEnable: Bool = false

    @Binding private var forwardingModalAction: Bool
    @Binding private var forwardingFullAction: Bool
    @State private var cancelButtonHeight: CGFloat = 100

    @ObservedObject private var keyboardResponder = KeyboardResponder()

    init(forwardingModalAction: Binding<Bool>, forwardingFullAction: Binding<Bool>) {
        _forwardingModalAction = forwardingModalAction
        _forwardingFullAction = forwardingFullAction
    }

    var body: some View {
        VStack(spacing: 0) {

            titleBarView

            if searchResultNotFound {
                VStack {
                    Text(tm.lang.localized("Search.Result.NotFound"))
                        .font(tm.typo.subheadline)
                        .font(.system(size: 14))
                }
                .frame(height: 169)
            } else {
                ContentForwardingSelectionTabSection(selectTabItem: $currentTabIndex, hiddenCheckFriendList: .constant(false))
            }

            if messageInputEnable {
                Divider()
                TextField(tm.lang.localized("Message.Input"), text: $messageText)
                    .modifier(ClearButton(text: $messageText))
                    .textFieldStyle(.plain)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            }

            VStack {
                Button {
                    forwardingModalAction = false
                } label: {
                    Text(getSendButtonText())
                        .font(tm.typo.headline)
                        .font(.system(size: 17))
                        .frame(minWidth: 100, maxWidth: .infinity, minHeight: cancelButtonHeight)
                }
                .foregroundColor(sendEnable ? tm.theme.background : tm.theme.labelColorPrimary)
                .background(sendEnable ? tm.theme.systemPurple : tm.theme.systemGray5)
            }
        }
        .background(tm.theme.systemBackground)
        .onChange(of: keyboardResponder.currentHeight) { height in
            if height == 0 {
                cancelButtonHeight = 100
            } else {
                cancelButtonHeight = 66
            }
        }
    }

    private var titleBarView: some View {
        HStack(spacing: 0) {
            if searchEnable {
                TextField(getCurrentTabSearchPlacehold(), text: $searchText)
                    .modifier(ClearButton(text: $searchText))
                    .textFieldStyle(.roundedBorder)
                    .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 11))

                Button {
                    self.cancel()
                } label: {
                    Image(systemName: "xmark")
                        .font(tm.typo.callout)
                        .font(.system(size: 16))
                        .foregroundColor(tm.theme.labelColorPrimary)
                }
                .padding(.trailing, 11)

            } else {
                ZStack {
                    Text("PassOn")
                        .font(tm.typo.headline)
                        .font(.system(size: 17))
                        .foregroundColor(tm.theme.labelColorPrimary)

                    HStack {
                        Spacer()
                        Button {
                            searchEnable = true
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .font(tm.typo.body)
                                .font(.system(size: 17))
                                .foregroundColor(tm.theme.labelColorPrimary)
                        }
                        .padding(.trailing, 9)

                        Button {
                            // action
                            self.cancel()
                            forwardingModalAction = false
                            forwardingFullAction = true
                        } label: {
                            Image(systemName: "list.bullet")
                                .font(tm.typo.body)
                                .font(.system(size: 17))
                                .foregroundColor(tm.theme.labelColorPrimary)
                        }
                        .padding(.trailing, 9)
                    }
                }
                .frame(height: 48)
            }
        }
    }
}

extension ContentForwardingSelectionBottomSection {
    private func getCurrentTabSearchPlacehold() -> String {
        switch currentTabIndex {
        case 0:
            return tm.lang.localized("Search.FriendName")

        default:
            return tm.lang.localized("Search.RoomName")
        }
    }

    private func getSendButtonText() -> String {
        if sendEnable {
            return tm.lang.localized("Common.Send")
        } else {
            return tm.lang.localized("Common.Cancel")
        }
    }

    private func cancel() {
        searchEnable = false
        messageInputEnable = false
        searchResultNotFound = false
        searchText = ""
        messageText = ""
    }
}

#if DEBUG
struct ContentForwardingSelectionBottomSection_Previews: PreviewProvider {
    static var previews: some View {
        ContentForwardingSelectionBottomSection(forwardingModalAction: .constant(false), forwardingFullAction: .constant(false))
            .environmentObject(ThemeManager())
    }
}
#endif

struct ClearButton: ViewModifier {
    @Binding var text: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content

            if !text.isEmpty {
                Button {
                    self.text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color(UIColor.opaqueSeparator))
                }
                .padding(.trailing, 4)
            }
        }
    }
}
