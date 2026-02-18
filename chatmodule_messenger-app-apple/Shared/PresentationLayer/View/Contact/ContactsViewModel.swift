//
//  ContactsViewModel.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

public final class ContactsViewModel {

    private let contactsListFetchUseCase: ContactsListFetchUseCase?

    private var bag = Set<AnyCancellable>()

    public init(contactsListFetchUseCase: ContactsListFetchUseCase? = nil) {
        self.contactsListFetchUseCase = contactsListFetchUseCase
    }

    func fetchContactsList(historyToken: Data, completion: @escaping (Data) -> Void) {

        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in

            if let error = error {
                self.errorHandle(comment: "contact grant error \(error) : \(#function)")
                return
            }

            if granted {
                self.contactsListFetchUseCase?.execute(value: historyToken)
                    .sink { result in
                        switch result {
                        case .failure(let error):
                            self.errorHandle(comment: "🤬failure : \(#function)", error: error)
                        case .finished:
                            self.errorHandle(comment: "finished : \(#function)")
                        }
                    } receiveValue: { token in
                        completion(token)
                    }
                    .store(in: &self.bag)
            } else {
                self.errorHandle(comment: "contact grant fail : \(#function)")
            }

        }
    }

    private func errorHandle(comment: String, error: Error? = nil) {

        guard let err = error else {
            print("\(comment)")
            return
        }

        print("\(comment) --- \(err)")
    }

}
