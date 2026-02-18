//
//  ChatMessagesViewModel.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

protocol ChatMessagesViewModelOutput {
    var messages: [ChatMessageEntity] { get }
}

protocol ChatMessageViewModelInput {
    func fetchMessagesList(roomId: Int64)
    func getMessage(id: String)
}

public final class ChatMessagesViewModel: ObservableObject, ChatMessageViewModelInput, ChatMessagesViewModelOutput {

    @Published var messages = [ChatMessageEntity]()
    private let chatMessagesListFetchUseCase: ChatMessagesListFetchUseCase?
    private let chatMessageGetUseCase: ChatMessageGetUseCase?
    private let chatMessageAddUseCase: ChatMessageAddUseCase?

    private var bag = Set<AnyCancellable>()

    public init(chatMessagesListFetchUseCase: ChatMessagesListFetchUseCase? = nil,
                chatMessageGetUseCase: ChatMessageGetUseCase? = nil,
                chatMessageAddUseCase: ChatMessageAddUseCase? = nil) {
        self.chatMessagesListFetchUseCase = chatMessagesListFetchUseCase
        self.chatMessageGetUseCase = chatMessageGetUseCase
        self.chatMessageAddUseCase = chatMessageAddUseCase
    }

    func fetchMessagesList(roomId: Int64) {
        self.chatMessagesListFetchUseCase?.execute(value: roomId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    self.errorHandle(comment: "🤬failure : \(#function)", error: error)
                case .finished:
                    self.errorHandle(comment: "finished : \(#function)")
                }
            }, receiveValue: { data in
                self.messages = data
            })
            .store(in: &bag)
    }

    func getMessage(id: String) {
        self.chatMessageGetUseCase?.execute(value: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    self.errorHandle(comment: "🤬failure : \(#function)", error: error)
                case .finished:
                    self.errorHandle(comment: "finished : \(#function)")
                }
            }, receiveValue: { data in
                print(data)
            })
            .store(in: &bag)
    }

    func addMessage(message: ChatMessageEntity) {
        self.chatMessageAddUseCase?.execute(value: message)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    self.errorHandle(comment: "🤬failure : \(#function)", error: error)
                case .finished:
                    self.errorHandle(comment: "finished : \(#function)")
                }
            }, receiveValue: { data in
                if data {
                    self.messages.append(message)
                }
            })
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
