//
//  AppSettings.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import SwiftUI

/// AppStorageKey
///
/// - lastTab : 마지막으로 선택한 탭
///
private enum AppStorageKey: String {
    /// 마지막으로 선택한 탭
    case lastTab
    /// History Token
    case historyToken
    /// 국가 코드
    case countryCode

    /// 친구 목록 확장
    case expandNewFriends
    case expandUpdatedFriends
    case expandFavoriteFriends
    case expandRecommendedFriends
    case expandFriends
}

public class AppSettings: ObservableObject {
    // App Group 으로 저장소 변경시 아래와 같이 선언
    // @AppStorage("key", store: UserDefaults(suiteName: "group.yourapp.com"))

    @AppStorage(AppStorageKey.lastTab.rawValue)
    public var lastTab = HomeTabs.friends

    @AppStorage(AppStorageKey.historyToken.rawValue)
    public var historyToken: Data = Data()

    @AppStorage(AppStorageKey.countryCode.rawValue)
    public var countryCode = "KR"

    @AppStorage(AppStorageKey.expandNewFriends.rawValue)
    public var expandNewFriends = true

    @AppStorage(AppStorageKey.expandUpdatedFriends.rawValue)
    public var expandUpdatedFriends = true

    @AppStorage(AppStorageKey.expandFavoriteFriends.rawValue)
    public var expandFavoriteFriends = true

    @AppStorage(AppStorageKey.expandRecommendedFriends.rawValue)
    public var expandRecommendedFriends = true

    @AppStorage(AppStorageKey.expandFriends.rawValue)
    public var expandFriends = true

    public init() {}
}
