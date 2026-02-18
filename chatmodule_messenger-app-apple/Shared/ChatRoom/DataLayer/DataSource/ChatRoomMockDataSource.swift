//
//  ChatRoomMockDataSource.swift
//  ChatModuleMessengerAppApple
//

import Foundation

public final actor ChatRoomMockDataSource {
    var mockData: [ChatRoomEntity] = [
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
                       roomName: "Name1, Name2, Name3, Name4")
    ]
}

extension ChatRoomMockDataSource: ChatRoomDataSourceInterface {
    public func createRoom(_ value: ChatRoomCreateUseCase.Request) async throws -> ChatRoomEntity {
        let addData = ChatRoomEntity(roomId: Int64((self.mockData.last?.roomId ?? 0) + 1),
                                     lastMessageDate: "2025. 03. 10",
                                     memberCount: 5,
                                     roomName: value.roomName)
        self.mockData.append(addData)
        return addData
    }

    public func fetchRoomList() async throws -> [ChatRoomEntity] {
        return self.mockData
    }

    public func leaveRoom(roomId: Int64) async throws -> Bool {
        if let idx = self.mockData.firstIndex(where: { $0.roomId == roomId }) {
            self.mockData.remove(at: idx)
            return true
        }

        return false
    }

    public func exportAllMessage(roomId: Int64) async throws -> Bool {
        return true
    }

    public func deleteAllMessage(roomId: Int64) async throws -> Bool {
        return true
    }

    public func modifyRoomWallpaper(_ value: ChatRoomModifyWallpaperUseCase.Request) async throws -> Bool {
        return true
    }

    public func modifyRoomTextTone(_ value: ChatRoomModifyTextToneUseCase.Request) async throws -> Bool {
        return true
    }

    public func modifyRoomName(_ value: ChatRoomModifyRoomNameUseCase.Request) async throws -> Bool {
        if let idx = self.mockData.firstIndex(where: {$0.roomId == value.roomId}) {
            var data = self.mockData.remove(at: idx)
            data.roomName = value.roomName
            self.mockData.insert(data, at: idx)
            return true
        }
        return false
    }
}
