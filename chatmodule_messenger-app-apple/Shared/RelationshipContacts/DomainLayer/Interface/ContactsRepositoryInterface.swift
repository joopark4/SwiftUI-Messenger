//
//  ContactsRepositoryInterface.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

public protocol ContactsRepositoryInterface {
    func syncContacts(historyToken: Data) -> AnyPublisher<Data, Error>
}
