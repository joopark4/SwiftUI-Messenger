//
//  AccountInfo.swift
//  ChatModuleMessengerUI
//

import Foundation

public struct AccountInfo: Identifiable {
    public var id: Int64 {
        get { Int64(signInId) ?? 0 }
    }
    
    public let signInId: String
    public let phoneNumber: String?
    public let username: String
    public let birthday: Int
    public let profileUrl: String?
    public let description: String?
    public let profileBackgroundUrl: String?

    public init(signInId: String,
                phoneNumber: String? = nil,
                username: String,
                birthday: Int = 0,
                profileUrl: String? = nil,
                description: String? = nil,
                profileBackgroundUrl: String? = nil) {
        self.signInId = signInId
        self.phoneNumber = phoneNumber
        self.username = username
        self.birthday = birthday
        self.profileUrl = profileUrl
        self.description = description
        self.profileBackgroundUrl = profileBackgroundUrl
    }
}
