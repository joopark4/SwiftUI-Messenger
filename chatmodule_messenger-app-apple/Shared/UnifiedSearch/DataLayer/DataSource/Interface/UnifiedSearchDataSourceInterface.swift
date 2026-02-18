//
//  UnifiedSearchDataSourceInterface.swift
//  ChatModuleMessengerAppApple
//

import Foundation

public protocol UnifiedSearchDataSourceInterface {
    func getSearchResults(keyword: String) async throws -> UnifiedSearchEntity
}
