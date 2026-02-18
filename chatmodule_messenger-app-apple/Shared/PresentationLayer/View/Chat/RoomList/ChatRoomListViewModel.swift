//
//  ChatRoomListViewModel.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

protocol ChatRoomListViewModelOutput {
    var rooms: [ChatRoomEntity] { get }
}

protocol ChatRoomListViewModelInput {
    func fetchChatRoomList()
    func createChatRoom(roomName: String, completion: ((Result<ChatRoomEntity, Error>) -> Void)?)
}

public final class ChatRoomListViewModel: ObservableObject, ChatRoomListViewModelInput, ChatRoomListViewModelOutput {
    @Published var rooms = [ChatRoomEntity]()

    private let fetchListUsecase: ChatRoomFetchListUseCase?
    private let createRoomUsecase: ChatRoomCreateUseCase?

    private var bag = Set<AnyCancellable>()

    public init(fetchListUsecase: ChatRoomFetchListUseCase? = nil,
                createRoomUsecase: ChatRoomCreateUseCase? = nil) {
        self.fetchListUsecase = fetchListUsecase
        self.createRoomUsecase = createRoomUsecase
    }

    func fetchChatRoomList() {
        self.fetchListUsecase?.execute(())
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.errorHandle(comment: "🤬failure : \(#function)", error: error)
                case .finished:
                    self.errorHandle(comment: "finished : \(#function)")
                }
            } receiveValue: { data in
                self.rooms = data
            }
            .store(in: &bag)
    }

    func createChatRoom(roomName: String, completion: ((Result<ChatRoomEntity, Error>) -> Void)? = nil) {
        self.createRoomUsecase?.execute(.init(roomName: roomName))
            .sink { result in
                switch result {
                case .failure(let error):
                    self.errorHandle(comment: "🤬failure : \(#function)", error: error)
                    completion?(.failure(error))
                case .finished:
                    self.errorHandle(comment: "finished : \(#function)")
                }
            } receiveValue: { room in
                self.rooms.removeAll { $0.roomId == room.roomId }
                self.rooms.append(room)
                completion?(.success(room))
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
