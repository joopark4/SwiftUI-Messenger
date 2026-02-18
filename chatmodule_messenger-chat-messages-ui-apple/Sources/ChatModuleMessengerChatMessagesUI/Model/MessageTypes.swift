//
//  MessageTypes.swift
//  ChatModuleMessengerChatMessagesUI
//

import Foundation
import ChatModuleMessengerUI

public enum EmoticonType {
    case EMOTICON, SMILE_ME, EMOJI, FAVORITE
}

public enum FileTYpe {
    case ARCHIVE, DOCUMENT
}

public enum MessageType {
    case PREVIOUS_DATE, TEXT, MASS_TEXT, IMAGE, EMOTICON, INVITE, EXIT, VIDEO, FILE, SMILEME, SOUND 
}

public enum MessageStatus {
    case UN_SEND, SUCCESS, FAIL
}

public enum MessageFlow {
    case RECEIVED_MESSAGE, SENT_MESSAGE
}

public enum ImageType {
    case ORIGINAL, THUMBNAIL
}

public enum MediaInputType {
    case ALBUM
    case CAMERA
    case GIFT
    case FREE_CALL
    case REMIT_MONEY
    case MUSIC
    case CALENDER
    case MAP
    case CAPTURED
    case VOICE_REC
    case CONTACTS
    case FILE
    case LINK
}

public enum ChatRoomBottomSectionType {
    case NONE
    case SERVICE
    case MEDIA
    case EMOTICON
    case HASTAG
}

public enum PayloadType {
    case LINK
    case IMAGE(id: String, extensionInfo: String, images: [ImageInfo])
    case VIDEO
    case TEXT(text: String)
    case EMOTICON(itemId: String)
    case MASS_TEXT
    case INVITE(invtee:  [AccountInfo])
    case EXIT(exit: AccountInfo)
    case AUDIO
    case EMOTICON_SMILE_ME
}

//public enum Payload {
//    case EmoticonPayload(itemId: String)
//    case ImagePayload(id: String, extensionInfo: String, images: [ImageInfo])
//    case TextPayload(text: String)
//    case InvitePayload(invtee:  [AccountInfo])
//    case ExitPayload(exit: AccountInfo)
//}

public enum ParticipantStatus {
    case REINVITE_CHATROOM, LET_CHATROOM, INVITED_CHATROOM, NONE
}
