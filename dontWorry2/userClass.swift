//
//  userClass.swift
//  dontWorry2
//
//  Created by air on 2017. 6. 9..
//  Copyright © 2017년 Kylie. All rights reserved.
//

import Foundation
import Firebase

class User {
    
    // MARK: Properties
    
    var nameInUserClass: String
    var phoneInUserClass: String
    var passwordInUserClasss: String
    
    // MARK: Initializers
    
    init(name : String, phone: String, password: String) {
        
        self.nameInUserClass = name
        self.phoneInUserClass = phone
        self.passwordInUserClasss = password
    }
    
    init?(snapshot: DataSnapshot) {
        
        guard
            let nameDB = snapshot.childSnapshot(forPath: "name").value as? String,
            let phoneDB = snapshot.childSnapshot(forPath: "phone").value as? String,
            let passwordDB = snapshot.childSnapshot(forPath: "password").value as? String
            else { return nil }
        
        self.nameInUserClass = nameDB
        self.phoneInUserClass = phoneDB
        self.passwordInUserClasss = passwordDB
    }
}
