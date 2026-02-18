//
//  SelectCountryViewModel.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

protocol SelectCountryViewModelOutput {
    var countryList: [CountryEntity] { get }
    var regionNumber: String { get }
}

protocol SelectCountryViewModelInput {
    func fetchCountryListService(countryCode: String)
    func getRegionNumber(countryCode: String)
}

public final class SelectCountryViewModel: ObservableObject {

    private let countryListFetchUseCase: CountryListFetchUseCase?
    private let countryGetRegionUseCase: CountryGetRegionUseCase?

    init(countryListFetchUseCase: CountryListFetchUseCase? = nil,
         countryGetRegionUseCase: CountryGetRegionUseCase? = nil) {
        self.countryListFetchUseCase = countryListFetchUseCase
        self.countryGetRegionUseCase = countryGetRegionUseCase
    }

    @Published var countryList = [CountryEntity]()
    @Published var regionNumber = ""

    private var bag = Set<AnyCancellable>()

    func fetchCountryListService(countryCode: String) {
        self.countryListFetchUseCase?.execute(value: countryCode)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.errorHandle(comment: "🤬failure : \(#function)", error: error)
                case .finished:
                    self.errorHandle(comment: "finished : \(#function)")
                }
            } receiveValue: { countries in
                self.countryList = countries
            }
            .store(in: &bag)
    }

    func getRegionNumber(countryCode: String) {
        self.countryGetRegionUseCase?.execute(value: countryCode)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.errorHandle(comment: "🤬failure : \(#function)", error: error)
                case .finished:
                    self.errorHandle(comment: "finished : \(#function)")
                }
            } receiveValue: { regionNumber in
                self.regionNumber = regionNumber
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
