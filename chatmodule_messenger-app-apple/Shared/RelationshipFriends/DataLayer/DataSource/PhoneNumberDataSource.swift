//
//  PhoneNumberDataSource.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import libPhoneNumber
import Combine

private enum FavoriteCountry: String, CaseIterable {
//    대한민국
    case KR
//    미국
    case US
//    캐나다
    case CA
//    필리핀
    case PH
//    일본
    case JP
//    인도네시아
    case ID
//    태국
    case TH
//    말레이시아
    case MY
//    베트남
    case VN
//    브라질
    case BR
//    사우디아라비아
    case SA
//    중국 본토
    case CN
//    홍콩
    case HK
//    영국
    case GB
//    오스트레일리아
    case AU
//    독일
    case DE
}

private enum ExceptCountry: String, CaseIterable {
//    북한
    case KP
}

public final actor PhoneNumberDataSource: PhoneNumberDataSourceInterface {

    public func fetchCountryList(countryCode: String) async throws -> [CountryEntity] {
        do {
            var nationalList = [CountryEntity]()

            guard let phoneUtil = NBPhoneNumberUtil.sharedInstance() else {
                throw FriendError.unknown
            }

            try nationalList = phoneUtil.getSupportedRegions().compactMap { code -> CountryEntity? in
                let code = code as? String ?? ""
                let nan = phoneUtil.isNANPACountry(code)
                guard let exPhone = phoneUtil.getNationalSignificantNumber(try phoneUtil.getExampleNumber(code)) else { return nil }
                let phoneCode = phoneUtil.getCountryCode(forRegion: code)

                let locale = NSLocale(localeIdentifier: countryCode)
                let countryName = locale.localizedString(forCountryCode: code)

                var regionNumber: String = ""
                if nan {
                    let endIdx: String.Index = exPhone.index(exPhone.startIndex, offsetBy: 2)
                    let result = String(exPhone[...endIdx])

                    if code == FavoriteCountry.US.rawValue || code == FavoriteCountry.CA.rawValue {
                        regionNumber = "+" + (phoneCode?.stringValue ?? "")
                    } else {
                        regionNumber = "+" + (phoneCode?.stringValue ?? "") + " " + result
                    }
                } else {
                    regionNumber = "+" + (phoneCode?.stringValue ?? "")
                }

                if !(ExceptCountry.allCases.filter({ $0.rawValue == code}).count > 0) {
                    return CountryEntity(countryCode: code, regionNumber: regionNumber, countryName: countryName ?? "")
                } else {
                    return nil
                }
            }

            return self.resortFavoriteCountryList(nationalList: nationalList.sorted(by: {$0.countryName < $1.countryName}))

        } catch {
            throw FriendError.unknown
        }
    }

    func resortFavoriteCountryList(nationalList: [CountryEntity]) -> [CountryEntity] {
        var resortList = nationalList
        let all = FavoriteCountry.allCases

        for favoriteCode in all.reversed() {

            if let firstIndex = resortList.firstIndex(where: { $0.countryCode == favoriteCode.rawValue}) {
                let element = resortList.remove(at: firstIndex)
                resortList.insert(element, at: 0)
            }
        }

        return resortList
    }

    public func getRegion(countryCode: String) async throws -> String {
        guard let phoneUtil = NBPhoneNumberUtil.sharedInstance() else { throw PhoenNumError.unknown  }
        return "+" + phoneUtil.getCountryCode(forRegion: countryCode).stringValue
    }

}
