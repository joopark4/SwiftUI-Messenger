//
//  ContactsDataSource.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import libPhoneNumber

public struct ContactsDataSource: ContactsDataSourceInterface {
    var defaultCountryCode = "KR" // 추후 가입시 선택한 region에 따라 변경

    public init() { }

    public func syncContacts(historyToken: Data) async throws -> Data {
        var newToken = Data()

        let obj = ContactChangeHistory.sharedObject()
        obj.checkChangedData(historyToken.count > 0 ? historyToken : nil) { array, token in

            let contactList = array.compactMap { contact -> ContactEntity? in
                guard let contact = contact as? [String: String] else { return nil }

                return self.contactValid(contact: contact)
            }
            newToken = token
            self.sendContactListInCore(historyToken: newToken, contactList: contactList)
        }
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
