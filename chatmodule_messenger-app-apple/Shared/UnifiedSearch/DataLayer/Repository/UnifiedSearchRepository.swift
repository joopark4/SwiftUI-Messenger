//
//  UnifiedSearchRepository.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

public struct UnifiedSearchRepository: UnifiedSearchRepositoryInterface {

    private let dataSource: UnifiedSearchDataSourceInterface?

    init(dataSource: UnifiedSearchDataSourceInterface? = nil) {
        self.dataSource = dataSource
    }

    public func searchResults(keyword: String) -> AnyPublisher<UnifiedSearchEntity, Error> {
        guard let dataSource = dataSource else { return Fail(error: UnifiedSearchError.unknown).eraseToAnyPublisher() }

        return Just(keyword)
            .setFailureType(to: Error.self)
            .tryAsyncMap { try await dataSource.getSearchResults(keyword: $0) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

}
