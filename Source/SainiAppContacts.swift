//
//  SainiAppContacts.swift
//  SainiUtils
//
//  Created by Rohit Saini on 07/06/20.
//

import Foundation
import Contacts


public func sainiFetchContacts(_ completion: ([AppContact]) -> Void) {
    var appContacts = [AppContact]()
    let store = CNContactStore()
    store.requestAccess(for: .contacts) { (granted, err) in
        if let err = err{
            log.error("Failed to request access: \(err)")/
        }
        if granted{
            log.success("Access granted")/
           
            let keys = [CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey]
            let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
            do{
                try store.enumerateContacts(with: request) { (contact, stopPointerIfYouWantToStopEnumrating) in
                    appContacts.append(AppContact(ISDcode:"", givenName: contact.givenName + " " + contact.familyName,isSelected: false, phoneNumber: contact.phoneNumbers.first?.value.stringValue ?? ""))
                }
            }
            catch let err{
                log.error("Failed to enumrate contacts: \(err)")/
            }

            
        }
        else{
            log.error("Access Denied")/
        }
        
    }
    
    completion(appContacts)
}

public struct AppContact:Codable{
    var ISDcode: String
    var givenName: String
    var isSelected: Bool
    var phoneNumber: String
    init(ISDcode: String,givenName: String,isSelected:Bool,phoneNumber:String){
        self.ISDcode = ISDcode
        self.givenName = givenName
        self.isSelected = isSelected
        self.phoneNumber = phoneNumber
    }
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        ISDcode = try values.decodeIfPresent(String.self, forKey: .ISDcode) ?? ""
         givenName = try values.decodeIfPresent(String.self, forKey: .givenName) ?? ""
         phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber) ?? ""
        isSelected = try values.decodeIfPresent(Bool.self, forKey: .isSelected) ?? false
    }
}
