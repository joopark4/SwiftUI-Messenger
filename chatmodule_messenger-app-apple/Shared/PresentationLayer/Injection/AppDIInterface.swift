//
//  AppDIInterface.swift
//  ChatModuleMessengerAppApple
//

import Foundation

public protocol AppDIInterface {
    var friendsViewModel: FriendsViewModel { get }

    var contactsViewModel: ContactsViewModel { get }

    var countryViewModel: SelectCountryViewModel { get }

    var friendsSelectionViewModel: FriendsSelectionViewModel { get }

    var chatRoomListViewModel: ChatRoomListViewModel { get }

    var chatMessagesViewModel: ChatMessagesViewModel { get }

    var unifiedSearchViewModel: UnifiedSearchViewModel { get }

    func chatRoomViewModel(room: ChatRoomEntity) -> ChatRoomViewModel
}
