//
//  UnifiedSearchRepositoryInterface.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

public protocol UnifiedSearchRepositoryInterface {
    func searchResults(keyword: String) -> AnyPublisher<UnifiedSearchEntity, Error>
}
