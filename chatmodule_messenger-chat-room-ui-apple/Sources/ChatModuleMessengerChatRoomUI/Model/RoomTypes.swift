//
//  RoomTypes.swift
//  ChatModuleMessengerChatRoomUI
//

import Foundation


public enum RoomType {
    case SINGLE, MULTI
}

public enum RoomChatExportType {
    case ALL, TEXT
}

public enum RoomChatExportStatus {
    case SCHEDULED, EXPOTING, DONE, NO_DATA, FAILED
}

public enum RoomBackgroundType {
    case COLOR, PHOTO, ILLUSTRATION
}


/// 아직 정의되지 않아 임의로 만든 타입들

public enum RoomArchiveContentsType {
    case FILE, LINK, ALBUM
}

public enum RoomArchivePageType {
    case LOCAL, DRIVE
}

public enum DriveMode {
    case All, Important, User
}
