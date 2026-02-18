//
//  PhoneNumberTest.swift
//  ChatModuleMessengerAppApple
//

import XCTest
import libPhoneNumber
@testable import ChatModuleMessengerAppApple

class PhoneNumberTest: XCTestCase {
    private let defaultCountryCode = "KR"
    private var mockPhoneNumber = [
        PhoneNumber(number: "010-1234-5678", targetCountryCode: 82,
                    targetNationalNumber: 1012345678, targetPhoneNumberType: .MOBILE),
        PhoneNumber(number: "01011112222", targetCountryCode: 82,
                    targetNationalNumber: 1011112222, targetPhoneNumberType: .MOBILE),
        PhoneNumber(number: "02-1111-2222", targetCountryCode: 82,
                    targetNationalNumber: 211112222, targetPhoneNumberType: .FIXED_LINE),
        PhoneNumber(number: "02-1111-2222", targetCountryCode: 82,
                    targetNationalNumber: 211112222, targetPhoneNumberType: .FIXED_LINE),
        PhoneNumber(number: "031-1111-2222", targetCountryCode: 82,
                    targetNationalNumber: 3111112222, targetPhoneNumberType: .FIXED_LINE),
        PhoneNumber(number: "+8201012345678", targetCountryCode: 82,
                    targetNationalNumber: 1012345678, targetPhoneNumberType: .MOBILE),
        PhoneNumber(number: "82 10-1234-5678", targetCountryCode: 82,
                    targetNationalNumber: 1012345678, targetPhoneNumberType: .MOBILE),
        PhoneNumber(number: "+1 425-555-0100", targetCountryCode: 1,
                    targetNationalNumber: 4255550100, targetPhoneNumberType: .FIXED_LINE_OR_MOBILE),
        PhoneNumber(number: "+14255550100", targetCountryCode: 1,
                    targetNationalNumber: 4255550100, targetPhoneNumberType: .FIXED_LINE_OR_MOBILE),
        PhoneNumber(number: "+44 7944 505952", targetCountryCode: 44,
                    targetNationalNumber: 7944505952, targetPhoneNumberType: .MOBILE),
        PhoneNumber(number: "+447944505952", targetCountryCode: 44,
                    targetNationalNumber: 7944505952, targetPhoneNumberType: .MOBILE),
        PhoneNumber(number: "+44 7944 505952", targetCountryCode: 44,
                    targetNationalNumber: 7944505952, targetPhoneNumberType: .MOBILE),
        PhoneNumber(number: "+86 137 1234 5678", targetCountryCode: 86,
                    targetNationalNumber: 13712345678, targetPhoneNumberType: .MOBILE),
        PhoneNumber(number: "+8613712345678", targetCountryCode: 86,
                    targetNationalNumber: 13712345678, targetPhoneNumberType: .MOBILE),
        PhoneNumber(number: "++86 10 1234 5678", targetCountryCode: 86,
                    targetNationalNumber: 1012345678, targetPhoneNumberType: .FIXED_LINE)
    ]

    func testParsePhoneNumber() {
        guard let phoneUtil = NBPhoneNumberUtil.sharedInstance() else { return }
        mockPhoneNumber.forEach { number in
            if let phoneNumber = try? phoneUtil.parse(number.number, defaultRegion: self.defaultCountryCode) {
                print("\(phoneNumber)")
                XCTAssertTrue(phoneNumber.countryCode.intValue == number.targetCountryCode)
                XCTAssertTrue(phoneNumber.nationalNumber.int64Value == number.targetNationalNumber)
            }

        }
    }

    func testPossibleNumberForType() {
        guard let phoneUtil = NBPhoneNumberUtil.sharedInstance() else { return }
        mockPhoneNumber.forEach { number in
            if let phoneNumber = try? phoneUtil.parse(number.number, defaultRegion: self.defaultCountryCode) {
                print("\(phoneNumber)")
                XCTAssertTrue(phoneUtil.getNumberType(phoneNumber) == number.targetPhoneNumberType)
            }

        }
    }

    func testE164FormatPhoneNumber() {
        guard let phoneUtil = NBPhoneNumberUtil.sharedInstance() else { return }
        mockPhoneNumber.forEach { number in
            if let phoneNumber = try? phoneUtil.parse(number.number, defaultRegion: self.defaultCountryCode) {
                print("\(phoneNumber)")
                let convertNumber = try? phoneUtil.format(phoneNumber, numberFormat: .E164)
                XCTAssertTrue(convertNumber == number.get164Format())
            }

        }
    }
}

class PhoneNumber {
    var number: String
    var targetCountryCode: Int
    var targetNationalNumber: Int64
    var targetPhoneNumberType: NBEPhoneNumberType

    init(number: String, targetCountryCode: Int, targetNationalNumber: Int64, targetPhoneNumberType: NBEPhoneNumberType) {
        self.number = number
        self.targetCountryCode = targetCountryCode
        self.targetNationalNumber = targetNationalNumber
        self.targetPhoneNumberType = targetPhoneNumberType
    }

}

extension PhoneNumber {
    func get164Format() -> String {
        return "+" + String(self.targetCountryCode) + String(self.targetNationalNumber)
    }
}
