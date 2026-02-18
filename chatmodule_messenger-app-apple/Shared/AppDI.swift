//
//  AppDI.swift
//  ChatModuleMessengerAppApple
//

import Foundation

enum PHASE {
    case DEV, REAL
}

public struct AppEnviroment {
    let phase: PHASE = .DEV
}

public class AppDI: AppDIInterface {

    static let shared = AppDI(appEnvironment: AppEnviroment())

    private let appEnvironment: AppEnviroment

    private init(appEnvironment: AppEnviroment) {
        self.appEnvironment = appEnvironment
    }

    // MARK: - Friends
    private lazy var friendsRepository: FriendsRepository = {
        let friendsDataSource: FriendsDataSourceInterface
        let phoneNumberDataSource: PhoneNumberDataSourceInterface

        switch appEnvironment.phase {
        case .DEV:
            friendsDataSource = FriendsMockDataSource()
            phoneNumberDataSource = PhoneNumberDataSource()
        default:
            friendsDataSource = FriendsMockDataSource()
            phoneNumberDataSource = PhoneNumberDataSource()
        }

        return FriendsRepository(friendDataSource: friendsDataSource,
                                 phoenNumberDataSource: phoneNumberDataSource)
    }()

    public lazy var friendsViewModel: FriendsViewModel = {
        return FriendsViewModel(friendsListFetchUseCase: FriendsListFetchUseCase(repository: friendsRepository),
                                friendsAddUseCase: FriendsAddUseCase(repository: friendsRepository),
                                friendsModifierUseCase: FriendsModifierUseCase(repository: friendsRepository))
    }()

    public lazy var countryViewModel: SelectCountryViewModel = {
        return SelectCountryViewModel(countryListFetchUseCase: CountryListFetchUseCase(repository: friendsRepository),
                                      countryGetRegionUseCase: CountryGetRegionUseCase(repository: friendsRepository))
    }()

    public lazy var friendsSelectionViewModel: FriendsSelectionViewModel = {
        return .init(friendsListFetchUseCase: .init(repository: friendsRepository))
    }()

    // MARK: - Contacts
    private lazy var contactsRepository: ContactsRepository = {
        let dataSource: ContactsDataSourceInterface

        switch appEnvironment.phase {
        case.DEV:
            dataSource = ContactsMockDataSource()
        default:
            dataSource = ContactsDataSource()
        }

        return ContactsRepository(dataSource: dataSource)
    }()

    public lazy var contactsViewModel: ContactsViewModel = {
        return ContactsViewModel(contactsListFetchUseCase: ContactsListFetchUseCase(repository: contactsRepository))
    }()

    // MARK: - Messages
    private lazy var messagesRepository: ChatMessageRepository = {
        let dataSource: ChatMessagesDatasourceInterface

        switch appEnvironment.phase {
        case.DEV:
            dataSource = ChatMessagesMockDatasource()
        default:
            dataSource = ChatMessagesMockDatasource()
        }

        return ChatMessageRepository(messagesDataSource: dataSource)
    }()

    public lazy var chatMessagesViewModel: ChatMessagesViewModel = {
        return ChatMessagesViewModel(chatMessagesListFetchUseCase: ChatMessagesListFetchUseCase(repository: messagesRepository),
                                     chatMessageGetUseCase: ChatMessageGetUseCase(repository: messagesRepository),
                                     chatMessageAddUseCase: ChatMessageAddUseCase(repository: messagesRepository))
    }()

    // MARK: - ChatRoom
    private lazy var chatRoomRepository: ChatRoomRepository = {
        let dataSource: ChatRoomDataSourceInterface

        switch appEnvironment.phase {
        case.DEV:
            dataSource = ChatRoomMockDataSource()
        default:
            dataSource = ChatRoomMockDataSource()
        }

        return ChatRoomRepository(dataSource: dataSource)
    }()

    public lazy var chatRoomListViewModel: ChatRoomListViewModel = {
        return ChatRoomListViewModel(fetchListUsecase: ChatRoomFetchListUseCase(repository: chatRoomRepository),
                                     createRoomUsecase: ChatRoomCreateUseCase(repository: chatRoomRepository))
    }()

    private lazy var chatRoomViewModel: ChatRoomViewModel = {
        return .init(modifyRoomNameUsecase: .init(repository: chatRoomRepository),
                     modifyWallpaperUsecase: .init(repository: chatRoomRepository),
                     modifyTextToneUsecase: .init(repository: chatRoomRepository),
                     exportMessageUsecase: .init(repository: chatRoomRepository),
                     deleteMessageUsecase: .init(repository: chatRoomRepository),
                     leaveRoomUsecase: .init(repository: chatRoomRepository))
    }()

    public func chatRoomViewModel(room: ChatRoomEntity) -> ChatRoomViewModel {
        let vm = chatRoomViewModel
        vm.room = room
        return vm
    }

    // MARK: - UnifiedSearch

    private lazy var unifiedSearchRepository: UnifiedSearchRepository = {
        let unifiedSearchDataSource: UnifiedSearchDataSourceInterface

        switch appEnvironment.phase {
        case .DEV:
            unifiedSearchDataSource = UnifiedSearchMockDataSource()
        default:
            unifiedSearchDataSource = UnifiedSearchMockDataSource()
        }

        return UnifiedSearchRepository(dataSource: unifiedSearchDataSource)
    }()

    public lazy var unifiedSearchViewModel: UnifiedSearchViewModel = {

        return UnifiedSearchViewModel(unifiedSearchGetResultsUseCase: UnifiedSearchGetResultsUseCase(repository: unifiedSearchRepository))
    }()
}
