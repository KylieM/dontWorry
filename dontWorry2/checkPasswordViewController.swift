//
//  checkPasswordViewController.swift
//  dontWorry2
//
//  Created by air on 2017. 7. 4..
//  Copyright © 2017년 Kylie. All rights reserved.
//

import UIKit
import Firebase

class checkPasswordViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var stateLabel: UILabel!
    
    var dbRef : DatabaseReference!
    
    var password = "" //입력한 password
    var passwordCheck = "" //DB에서 가져온 password 데이터
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dbRef = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func inputPassword(_ sender: Any) {
        
        self.resignFirstResponder()
    }

    @IBAction func okButton(_ sender: Any) {
        
        self.dbRef.child("user/password").observeSingleEvent(of: .value, with: {(snapshot) in
            
            if let passwordDB = snapshot.value as? Int {
                
                self.password = self.passwordTextField.text!
                self.passwordCheck = "\(passwordDB)"
                print(self.passwordCheck)
                print(self.password)
                
                if self.passwordCheck == self.password {
                    
                    self.performSegue(withIdentifier: "moveNew", sender: self)
                }
                else if self.passwordCheck != self.password {
                    
                    self.stateLabel.text = "비밀번호를 확인하세요!"
                }
            }
        })
    }


}
