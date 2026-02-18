//
//  ContactsMockDataSource.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import libPhoneNumber

public struct ContactsMockDataSource: ContactsDataSourceInterface {
    var defaultCountryCode = "KR" // 추후 가입시 선택한 region에 따라 변경

    public init() { }

    public func syncContacts(historyToken: Data) async throws -> Data {
        let newToken = Data()

        let array: [[String: String]] = [
            ["name": "kkk1", "contact_id": "kkk1", "type": "C", "phone_id": "kkk1", "number": "01011111111"],
            ["name": "", "contact_id": "kkk2", "type": "C", "phone_id": "kkk2", "number": "01011111112"],
            ["name": "kkk3", "contact_id": "kkk3", "type": "C", "phone_id": "kkk3", "number": ""],
            ["name": "kkk4", "contact_id": "kkk4", "type": "C", "phone_id": "kkk4", "number": "821011111114"],
            ["name": "kkk5", "contact_id": "kkk5", "type": "C", "phone_id": "kkk5", "number": "+821011111115"],
            ["name": "kkk6", "contact_id": "kkk6", "type": "C", "phone_id": "kkk6", "number": "010 1111 1116"],
            ["name": "kkk7", "contact_id": "kkk7", "type": "C", "phone_id": "kkk7", "number": "010-1111-1117"]
        ]

        let contactList = array.compactMap { contact -> ContactEntity? in
            return self.contactValid(contact: contact)
        }

        self.sendContactListInCore(historyToken: newToken, contactList: contactList)

        return newToken
    }

    public func contactValid(contact: [String: String]) -> ContactEntity? {
        let phoneNumber = contact["number"] ?? ""
        let contactName = contact["name"] ?? ""

        if phoneNumber.isEmpty || contactName.isEmpty {
            return nil
        }

        guard let phoneUtil = NBPhoneNumberUtil.sharedInstance() else { return nil }

        do {
            let nbPhoneNumber: NBPhoneNumber = try phoneUtil.parse(phoneNumber, defaultRegion: defaultCountryCode)

            if !(phoneUtil.getNumberType(nbPhoneNumber) == .MOBILE || phoneUtil.getNumberType(nbPhoneNumber) == .FIXED_LINE_OR_MOBILE) {
                return nil
            }

            let formattedPhoneNumber: String = try phoneUtil.format(nbPhoneNumber, numberFormat: .E164)

            return ContactEntity(name: contactName,
                                 number: formattedPhoneNumber,
                                 contact_id: contact["contact_id"] ?? "",
                                 phone_id: contact["phone_id"] ?? "",
                                 type: contact["type"] ?? "")

        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }

    }

    func sendContactListInCore(historyToken: Data, contactList: [ContactEntity]) {
        let jsonEncoder = JSONEncoder()
        do {

            let encoded = try jsonEncoder.encode(ContactToJson(synchronized_at: String(decoding: historyToken, as: UTF8.self),
                                                               sync_data: contactList))
            print(String(data: encoded, encoding: .utf8) ?? "")

        } catch let error as NSError {
            print(error.localizedDescription)
        }

    }

}
