//
//  addPaper_userIsDebtorViewController.swift
//  dontWorry2
//
//  Created by air on 2017. 6. 22..
//  Copyright © 2017년 Kylie. All rights reserved.
//

import UIKit
import Firebase

class addPaper_userIsDebtorViewController: UIViewController { //사용자가 채무자, 돈 갚아야함 => amount는 마이너스..?

    @IBOutlet weak var debtorLabel: UILabel!
    @IBOutlet weak var creditorLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var amountTextField: UITextField!
    
    var dbRef : DatabaseReference!
    
    var creditorName = ""
    var amount = ""
    var date = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        dbRef = Database.database().reference()
        
        creditorLabel.text = creditorName   //FriendsViewController에서 넘어옴
        
        amountTextField.text = "금액"
        
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToFriends(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func date(_ sender: Any) {
    }
    
    @IBAction func amount(_ sender: Any) {
        
        amount = amountTextField.text!
        
        self.resignFirstResponder()
    }
    
    
    @IBAction func okButton(_ sender: Any) {
        
        let data = ["borrowDueDate": date, "borrowAmount": amount]
        
        dbRef.child("user/contacts/").observe(.value, with: {(snapshot) in
            
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                
                for child in result {
                    
                    let orderID = child.key as String //autoID 값 가져옴.
                    
                    self.dbRef.child("user/contacts/\(orderID)/contactName").observe(.value, with: { (snapshot) in
                        
                        if let nameDB = snapshot.value as? String {
                            
                            if self.creditorName == nameDB {
                                
                                self.dbRef.child("user/contacts/\(orderID)").updateChildValues(data)
                            }
                        }
                    })
                }
            }
        })
    }
    
   
    func dateChanged(_ sender: UIDatePicker) {
        
        let componenets = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        
        if let day = componenets.day, let month = componenets.month, let year = componenets.year {
            
            date = "\(year)-\(month)-\(day)"
        }
    }
    
}
