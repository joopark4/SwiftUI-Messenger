//
//  UnifiedSearchEntity.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import ChatModuleMessengerRelationshipFriendsUI
import ChatModuleMessengerChatRoomUI

public class UnifiedSearchEntity {
    public var friends: [FriendEntity]?
    public var rooms: [ChatRoomEntity]?

    init(friends: [FriendEntity]? = nil, rooms: [ChatRoomEntity]? = nil) {
        self.friends = friends
        self.rooms = rooms
    }
}
