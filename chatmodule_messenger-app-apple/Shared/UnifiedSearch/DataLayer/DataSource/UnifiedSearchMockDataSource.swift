//
//  UnifiedSearchMockDataSource.swift
//  ChatModuleMessengerAppApple
//

import Foundation

public final actor UnifiedSearchMockDataSource: UnifiedSearchDataSourceInterface {
    var friendMockDatas = [FriendEntity](
        [FriendEntity(account: .init(signInId: "0", username: "김개똥")),
         FriendEntity(account: .init(signInId: "1", username: "미코딩")),
         FriendEntity(account: .init(signInId: "2", username: "코로나")),
         FriendEntity(account: .init(signInId: "3", username: "김신")),
         FriendEntity(account: .init(signInId: "4", username: "미노리")),
         FriendEntity(account: .init(signInId: "5", username: "비오")),
         FriendEntity(account: .init(signInId: "6", username: "유상무"))]
    )

    var chatRoommockData: [ChatRoomEntity] = [
        ChatRoomEntity(roomId: 0,
                       isFavorite: true,
                       isNotReceiveNotification: true,
                       unreadCount: 1,
                       lastMessage: "blahblahblah",
                       lastMessageDate: "2025. 02. 22",
                       memberCount: 3,
                       roomName: "Name1, Name2, Name3, Name4"),
        ChatRoomEntity(roomId: 1,
                       isNotReceiveNotification: true,
                       unreadCount: 9999,
                       lastMessage: "blahblahblah",
                       lastMessageDate: "2025. 02. 09",
                       memberCount: 2,
                       roomName: "홍길동01"),
        ChatRoomEntity(roomId: 2,
                       unreadCount: 3,
                       lastMessage: "blahblahblah",
                       lastMessageDate: "2025. 02. 09",
                       memberCount: 4,
                       roomName: "Name1, Name2, Name3, Name4"),
        ChatRoomEntity(roomId: 3,
                       unreadCount: 2,
                       lastMessage: "dfeefefw",
                       lastMessageDate: "2025. 02. 09",
                       memberCount: 2,
                       roomName: "Name1, Name2")
    ]

    public init() {

    }

    public func getSearchResults(keyword: String) async throws -> UnifiedSearchEntity {

        return UnifiedSearchEntity(friends: friendMockDatas.isEmpty ? nil : friendMockDatas,
                                   rooms: chatRoommockData.isEmpty ? nil : chatRoommockData)
    }
}
