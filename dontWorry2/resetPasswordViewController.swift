//
//  resetPasswordViewController.swift
//  dontWorry2
//
//  Created by air on 2017. 7. 4..
//  Copyright © 2017년 Kylie. All rights reserved.
//

import UIKit
import Firebase

class resetPasswordViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var textLabel: UILabel!
    
    var dbRef : DatabaseReference!
    
    var password = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dbRef = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func input(_ sender: Any) {
        
        self.resignFirstResponder()
    }
    
    
    @IBAction func okButton(_ sender: Any) {
        
        password = Int(passwordTextField.text!)!

        let passwordData = ["password": password]
        self.dbRef.child("user").updateChildValues(passwordData)
    }
    
    

}
