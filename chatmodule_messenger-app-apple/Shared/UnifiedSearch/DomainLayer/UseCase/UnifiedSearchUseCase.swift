//
//  UnifiedSearchUseCase.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

protocol UnifiedSearchBaseUseCase {
    associatedtype RequestValue
    associatedtype ResponseValue

    var repository: UnifiedSearchRepositoryInterface { get }

    init(repository: UnifiedSearchRepositoryInterface)

    func execute(value: RequestValue) -> ResponseValue
}

public struct UnifiedSearchGetResultsUseCase: UnifiedSearchBaseUseCase {

    typealias RequestValue = String
    typealias ResponseValue = AnyPublisher<UnifiedSearchEntity, Error>
    let repository: UnifiedSearchRepositoryInterface

    init(repository: UnifiedSearchRepositoryInterface) {
        self.repository = repository
    }

    func execute(value: String) -> AnyPublisher<UnifiedSearchEntity, Error> {
        self.repository.searchResults(keyword: value)
    }
}
