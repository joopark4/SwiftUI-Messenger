//
//  ChatRoomViewModel.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

protocol ChatRoomViewModelOutput {
    var room: ChatRoomEntity { get set }
}

protocol ChatRoomViewModelInput {
    func modifyRoomName(name: String, completion: (() -> Void)?)
    func modifyRoomWallpaper(wallpaper: String)
    func modifyRoomTextTone(textTone: String)
    func deleteAllMessage()
    func exportAllMessage()
    func leaveChatRoom(completion: (() -> Void)?)
}

public final class ChatRoomViewModel: ObservableObject, ChatRoomViewModelInput, ChatRoomViewModelOutput {

    private var bag = Set<AnyCancellable>()

    @Published var room: ChatRoomEntity = .init(roomId: 0)

    private let modifyRoomNameUsecase: ChatRoomModifyRoomNameUseCase?
    private let modifyWallpaperUsecase: ChatRoomModifyWallpaperUseCase?
    private let modifyTextToneUsecase: ChatRoomModifyTextToneUseCase?
    private let exportMessageUsecase: ChatRoomExportMessageUseCase?
    private let deleteMessageUsecase: ChatRoomDeleteMessageUseCase?
    private let leaveRoomUsecase: ChatRoomLeaveUseCase?

    public init(modifyRoomNameUsecase: ChatRoomModifyRoomNameUseCase? = nil,
                modifyWallpaperUsecase: ChatRoomModifyWallpaperUseCase? = nil,
                modifyTextToneUsecase: ChatRoomModifyTextToneUseCase? = nil,
                exportMessageUsecase: ChatRoomExportMessageUseCase? = nil,
                deleteMessageUsecase: ChatRoomDeleteMessageUseCase? = nil,
                leaveRoomUsecase: ChatRoomLeaveUseCase? = nil) {
        self.modifyRoomNameUsecase = modifyRoomNameUsecase
        self.modifyWallpaperUsecase = modifyWallpaperUsecase
        self.modifyTextToneUsecase = modifyTextToneUsecase
        self.exportMessageUsecase = exportMessageUsecase
        self.deleteMessageUsecase = deleteMessageUsecase
        self.leaveRoomUsecase = leaveRoomUsecase
    }

    func modifyRoomName(name: String, completion: (() -> Void)? = nil) {
        self.modifyRoomNameUsecase?.execute(.init(roomId: self.room.roomId, roomName: name))
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.errorHandle(comment: "🤬failure : \(#function)", error: error)
                case .finished:
                    self.errorHandle(comment: "finished : \(#function)")
                }
                completion?()
            } receiveValue: { success in
                debugLog(success)
                if success {
                    self.room.roomName = name
                }
            }
            .store(in: &bag)
    }

    func modifyRoomWallpaper(wallpaper: String) {
        self.modifyWallpaperUsecase?.execute(.init(roomId: self.room.roomId, wallpaper: wallpaper))
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.errorHandle(comment: "🤬failure : \(#function)", error: error)
                case .finished:
                    self.errorHandle(comment: "finished : \(#function)")
                }
            } receiveValue: { success in
                debugLog(success)
            }
            .store(in: &bag)
    }

    func modifyRoomTextTone(textTone: String) {
        self.modifyTextToneUsecase?.execute(.init(roomId: self.room.roomId, textTone: textTone))
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.errorHandle(comment: "🤬failure : \(#function)", error: error)
                case .finished:
                    self.errorHandle(comment: "finished : \(#function)")
                }
            } receiveValue: { success in
                debugLog(success)
            }
            .store(in: &bag)
    }

    func deleteAllMessage() {
        self.deleteMessageUsecase?.execute(self.room.roomId)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.errorHandle(comment: "🤬failure : \(#function)", error: error)
                case .finished:
                    self.errorHandle(comment: "finished : \(#function)")
                }
            } receiveValue: { success in
                debugLog(success)
            }
            .store(in: &bag)
    }

    func exportAllMessage() {
        self.exportMessageUsecase?.execute(self.room.roomId)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.errorHandle(comment: "🤬failure : \(#function)", error: error)
                case .finished:
                    self.errorHandle(comment: "finished : \(#function)")
                }
            } receiveValue: { success in
                debugLog(success)
            }
            .store(in: &bag)
    }

    func leaveChatRoom(completion: (() -> Void)? = nil) {
        self.leaveRoomUsecase?.execute(self.room.roomId)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.errorHandle(comment: "🤬failure : \(#function)", error: error)
                case .finished:
                    self.errorHandle(comment: "finished : \(#function)")
                }
                completion?()
            } receiveValue: { success in
                debugLog(success)
            }
            .store(in: &bag)
    }

    private func errorHandle(comment: String, error: Error? = nil) {
        guard let err = error else {
            print("\(comment)")
            return
        }

        print("\(comment) --- \(err)")
    }
}
