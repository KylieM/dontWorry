//
//  contactEntry.swift
//  dontWorry2
//
//  Created by air on 2017. 6. 15..
//  Copyright © 2017년 Kylie. All rights reserved.
//

import UIKit
import AddressBook
import Contacts

class ContactEntry: NSObject {
    var name: String!
    var phone: String?
    
    init(name: String, phone: String?) {
        self.name = name
        self.phone = phone
    }
    
    init?(cnContact: CNContact) {
        // name
        if !cnContact.isKeyAvailable(CNContactGivenNameKey) && !cnContact.isKeyAvailable(CNContactFamilyNameKey) { return nil }
        self.name = (cnContact.givenName + " " + cnContact.familyName).trimmingCharacters(in: CharacterSet.whitespaces)
        
        // phone
        if cnContact.isKeyAvailable(CNContactPhoneNumbersKey) {
            if cnContact.phoneNumbers.count > 0 {
                let phone = cnContact.phoneNumbers.first?.value
                self.phone = phone?.stringValue
            }
        }
    }
}

