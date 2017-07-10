//
//  FriendsTableViewCell.swift
//  dontWorry2
//
//  Created by air on 2017. 6. 15..
//  Copyright © 2017년 Kylie. All rights reserved.
//

import Contacts
import UIKit
import Firebase

class ContactTableViewCell: UITableViewCell {
    // outlets
    
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactPhoneLabel: UILabel!
    
    var dbRef : DatabaseReference!
    
    var count = 0
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutIfNeeded() {
        
        super.layoutIfNeeded()
    }
    
    func configureWithContactEntry(_ contact: ContactEntry) {
        
        contactNameLabel.text = contact.name
        contactPhoneLabel.text = contact.phone ?? ""
        let amount = ""
        let dueDate = ""
        
        dbRef = Database.database().reference()
        
        let data  = ["contactName": contact.name, "contactPhone": contact.phone, "lendAmount": amount, "lendDueDate": dueDate]
        
        dbRef.child("user/contacts/").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.exists() != true {
                
                self.dbRef.child("user/contacts/").childByAutoId().setValue(data)
            }
        })
    }
    
    
}
