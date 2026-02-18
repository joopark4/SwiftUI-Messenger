//
//  ContactsDataSourceInterface.swift
//  ChatModuleMessengerAppApple
//

import Foundation

public protocol ContactsDataSourceInterface {

    func syncContacts(historyToken: Data) async throws -> Data
}
