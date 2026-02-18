//
//  ContactServiceUseCase.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

protocol ContactsBaseUseCase {
    associatedtype RequestValue
    associatedtype ResponseValue

    var repository: ContactsRepositoryInterface { get }

    init(repository: ContactsRepositoryInterface)

    func execute(value: RequestValue) -> ResponseValue
}

public struct ContactsListFetchUseCase: ContactsBaseUseCase {
    typealias RequestValue = Data
    typealias ResponseValue = AnyPublisher<Data, Error>
    let repository: ContactsRepositoryInterface

    func execute(value: Data) -> AnyPublisher<Data, Error> {
        return repository.syncContacts(historyToken: value)
    }

}
