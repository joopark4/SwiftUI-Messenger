//
//  ChatRoomRepositoryInterface.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

public protocol ChatRoomRepositoryInterface {
    /// 대화방 생성
    func createRoom(_ value: ChatRoomCreateUseCase.Request) -> AnyPublisher<ChatRoomEntity, Error>
    /// 대화방 초대
//    func inviteRoom()
    /// 대화방 나가기
    func leaveRoom(roomId: Int64) -> AnyPublisher<Bool, Error>
    /// 대화방 목록
    func fetchRoomList() -> AnyPublisher<[ChatRoomEntity], Error>
    /// 대화방 대화 내보내기
    func exportAllMessage(roomId: Int64) -> AnyPublisher<Bool, Error>
    /// 대화방 대화 삭제
    func deleteAllMessage(roomId: Int64) -> AnyPublisher<Bool, Error>
    /// 대화방 배경화면 수정
    func modifyRoomWallpaper(_ value: ChatRoomModifyWallpaperUseCase.Request) -> AnyPublisher<Bool, Error>
    /// 대화방 알림음 수정
    func modifyRoomTextTone(_ value: ChatRoomModifyTextToneUseCase.Request) -> AnyPublisher<Bool, Error>
    /// 대화방 이름 수정
    func modifyRoomName(_ value: ChatRoomModifyRoomNameUseCase.Request) -> AnyPublisher<Bool, Error>
}
