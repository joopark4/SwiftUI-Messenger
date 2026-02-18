//
//  ChatRoomDataSourceInterface.swift
//  ChatModuleMessengerAppApple
//

import Foundation

public protocol ChatRoomDataSourceInterface {
    func createRoom(_ value: ChatRoomCreateUseCase.Request) async throws -> ChatRoomEntity
    func fetchRoomList() async throws -> [ChatRoomEntity]
    func leaveRoom(roomId: Int64) async throws -> Bool
    func exportAllMessage(roomId: Int64) async throws -> Bool
    func deleteAllMessage(roomId: Int64) async throws -> Bool
    func modifyRoomWallpaper(_ value: ChatRoomModifyWallpaperUseCase.Request) async throws -> Bool
    func modifyRoomTextTone(_ value: ChatRoomModifyTextToneUseCase.Request) async throws -> Bool
    func modifyRoomName(_ value: ChatRoomModifyRoomNameUseCase.Request) async throws -> Bool
}
