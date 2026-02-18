//
//  ContactsRepository.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

public struct ContactsRepository: ContactsRepositoryInterface {
    private let dataSource: ContactsDataSourceInterface

    init(dataSource: ContactsDataSourceInterface) {
        self.dataSource = dataSource
    }

    public func syncContacts(historyToken: Data) -> AnyPublisher<Data, Error> {
        return Just(historyToken)
            .setFailureType(to: Error.self)
            .tryAsyncMap { try await self.dataSource.syncContacts(historyToken: $0) }
            .eraseToAnyPublisher()
    }

}
