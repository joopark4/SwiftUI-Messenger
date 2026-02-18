//
//  PhoneNumberDataSourceInterface.swift
//  ChatModuleMessengerAppApple
//

import Foundation

public protocol PhoneNumberDataSourceInterface {
    func fetchCountryList(countryCode: String) async throws -> [CountryEntity]
    func getRegion(countryCode: String) async throws -> String
}
