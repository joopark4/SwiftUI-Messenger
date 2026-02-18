//
//  FriendInfo.swift
//  ChatModuleMessengerRelationshipFriendsUI
//

import Foundation
import ChatModuleMessengerUI

public struct FriendInfo: Identifiable {
    public var id: Int64 {
        get { Int64(account.signInId) ?? 0 }
    }
    
    public var account: AccountInfo
    /// 친구가 설정한 이름
    public var name: String
    public var statusType: FriendStatusType
    
    public init(account: AccountInfo = .init(signInId: "-1", username: "Unknown"),
                name: String? = nil,
                statusType: FriendStatusType = .NONE) {
        self.account = account
        self.name = name ?? account.username
        self.statusType = statusType
    }
}
