//
//  UnifiedSearchPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI

public enum UnifiedSearchType: Int, CaseIterable {
    case ALL
    case FRIEND
    case CHAT
    case SETTING
}

public struct UnifiedSearchPage: View {
    @EnvironmentObject var tm: ThemeManager
    @State var inputText: String = ""
    @ObservedObject var viewModel: UnifiedSearchViewModel
    @State var unifiedSearchType = UnifiedSearchType.ALL

    init(viewModel: UnifiedSearchViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ZStack {

            tm.theme.fillColorTertiary
                .ignoresSafeArea(.all)

            VStack(spacing: 16) {

                UnifiedSearchBarSection(inputString: $inputText)

                if viewModel.searchResults != nil {

                    UnifiedSearchResultTabBarSection(unifiedSearchType: $unifiedSearchType)

                    ScrollView {
                        switch unifiedSearchType {
                        case .ALL:
                            VStack(spacing: 16) {
                                if let friends = viewModel.searchResults?.friends {
                                    UnifiedSearchResultFriendSection(friends: friends, unifiedSearchType: $unifiedSearchType)
                                }

                                if let rooms = viewModel.searchResults?.rooms {
                                    UnifiedSearchResultChatRoomSection(rooms: rooms, unifiedSearchType: $unifiedSearchType)
                                }

                                UnifiedSearchResultSettingsSection()

                                Spacer()
                            }
                        case .FRIEND:
                            if let friends = viewModel.searchResults?.friends {
                                UnifiedSearchResultFriendListSection(friends: friends)
                            } else {
                                EmptyView()
                            }

                        case .CHAT:
                            if let rooms = viewModel.searchResults?.rooms {
                                UnifiedSearchResultChatRoomListSection(rooms: rooms, allRooms: true, unifiedSearchType: $unifiedSearchType)
                                    .cornerRadius(8)
                                    .padding(.horizontal, 8)
                            } else {
                                EmptyView()
                            }
                            EmptyView()
                        case .SETTING:
                            UnifiedSearchResultSettingsListSection()
                                .cornerRadius(8)
                                .padding(.horizontal, 8)
                        }
                    }

                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            RecentSearchesSection()

                            KeywordPanelSection()

                            EmoticonStyleSection()

                            Spacer()
                        }
                    }
                }
            }.onChange(of: inputText) { text in
                if text.isEmpty {
                    viewModel.searchResults = nil
                    self.unifiedSearchType = .ALL
                } else {
                    self.viewModel.getSearchResults(keyword: text)
                }
            }
        }
    }
}

#if DEBUG
struct UnifiedSearchPage_Previews: PreviewProvider {
    static var previews: some View {
        UnifiedSearchPage(viewModel: UnifiedSearchViewModel())
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
