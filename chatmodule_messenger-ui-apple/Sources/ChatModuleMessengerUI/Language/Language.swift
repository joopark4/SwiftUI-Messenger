//
//  Language.swift
//  ChatModuleMessengerUI
//

import Foundation

/// 다국어 처리를 위한 struct
public struct Language {
    /// Language.Types
    ///
    /// korea(default), english, ...
    ///
    /// 추가되는 언어에 따라 type 추가 필요
    public enum Types: String {
        case english = "en"
        case korea = "ko"
    }

    /// localized 함수 포맷 (key) -> value
    public typealias LocalizedFunc = (String) -> String
    private var localizedFunc = [LocalizedFunc]()

    /// 사용할 언어 타입
    public var types: Types

    /// create Language
    /// - Parameter types: 언어 타입 (기본값 .korea)
    public init(types: Types = .korea) {
        self.types = types
        self.localizedFunc.append(localizedCommon)
    }

    /// localizedFunc를 순회하며 key에 해당하는 String을 가져온다
    /// - Parameter key: Localizable.strings 에 정의된 key
    /// - Returns:키에 해당하는 string 반환, 매칭되는 key가 없으면 key 반환
    public func localized(_ key: String) -> String {
        var val = key
        for localFunc in self.localizedFunc {
            val = localFunc(key)
            if val != key { break }
        }
        return val
    }

    /// 모듈별 localize 함수를 주입시켜 준다
    /// - Parameter localizedFun: localized 함수
    public mutating func appendLocalizedFunc(_ localizedFun: @escaping LocalizedFunc) {
        self.localizedFunc.append(localizedFun)
    }

    /// 모듈별 localize 함수를 주입시켜 준다
    /// - Parameter localizedFuncs: localized 함수 배열
    public mutating func appendLocalizedFunc(contentsOf localizedFuncs: [LocalizedFunc]) {
        self.localizedFunc.append(contentsOf: localizedFuncs)
    }

    fileprivate func localizedCommon(_ key: String) -> String {
        if let path = Bundle.module.path(forResource: self.types.rawValue, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return NSLocalizedString(key, bundle: bundle, value: key, comment: "")
        } else {
            return key
        }
    }
}
