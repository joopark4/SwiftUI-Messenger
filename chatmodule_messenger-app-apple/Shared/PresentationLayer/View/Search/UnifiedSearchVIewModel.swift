//
//  UnifiedSearchVIewModel.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import SwiftUI
import Combine

public class UnifiedSearchViewModel: ObservableObject {
    @Published var searchResults: UnifiedSearchEntity?

    private let unifiedSearchGetResultsUseCase: UnifiedSearchGetResultsUseCase?
    private var bag = Set<AnyCancellable>()

    public init(unifiedSearchGetResultsUseCase: UnifiedSearchGetResultsUseCase? = nil) {
        self.unifiedSearchGetResultsUseCase = unifiedSearchGetResultsUseCase
    }

    func getSearchResults(keyword: String) {
        self.unifiedSearchGetResultsUseCase?.execute(value: keyword)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.errorHandle(comment: "🤬failure : \(#function)", error: error)
                case .finished:
                    self.errorHandle(comment: "finished : \(#function)")
                }
            } receiveValue: { data in
                self.searchResults = data
            }
            .store(in: &bag)
    }

    private func errorHandle(comment: String, error: Error? = nil) {

        guard let err = error else {
            print("\(comment)")
            return
        }

        print("\(comment) --- \(err)")
    }

}
