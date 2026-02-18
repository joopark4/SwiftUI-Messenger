//
//  ContactEntity.swift
//  ChatModuleMessengerAppApple
//

import Foundation

public struct ContactEntity: Codable {
    var name: String
    var number: String
    var contact_id: String
    var phone_id: String
    var type: String
}

public struct ContactToJson: Codable {
    var synchronized_at: String
    var sync_data: [ContactEntity]

}
