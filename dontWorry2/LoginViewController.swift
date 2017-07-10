//
//  LoginViewController.swift
//  dontWorry2
//
//  Created by air on 2017. 6. 2..
//  Copyright © 2017년 Kylie. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    var dbRef : DatabaseReference!
    
    var phoneFlag = false
    var passwordFlag = false

    var phoneNumber = ""
    var passWord = ""
    
    var phoneNumberCheck = ""
    var passwordCheck = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dbRef = Database.database().reference()
        
        self.checkFlag()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func phone(_ sender: Any) {
        
        if let text = phoneTextField.text, !text.isEmpty {
            
            self.phoneFlag = true
        }
        self.resignFirstResponder()
        
        phoneNumber = phoneTextField.text!
        
        self.checkFlag()
    }
    
    @IBAction func password(_ sender: Any) {
        
        if let text = passwordTextField.text, !text.isEmpty {
            
            self.passwordFlag = true
        }
        self.resignFirstResponder()
        
        passWord = passwordTextField.text!
        
        self.checkFlag()
    }
    
    
    @IBAction func previous(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func login(_ sender: Any) {
        
        dbRef.child("user/phone").observeSingleEvent(of: .value, with: {(snapshot) in
            
            if let phoneDB = snapshot.value as? Int {
                
                self.phoneNumberCheck = "\(phoneDB)"
                
                self.dbRef.child("user/password").observeSingleEvent(of: .value, with: {(snapshot) in
                    
                    if let passwordDB = snapshot.value as? Int {
                        self.passwordCheck = "\(passwordDB)"
                        
                        if self.phoneNumberCheck == self.phoneNumber && self.passwordCheck == self.passWord {
                        
                            self.performSegue(withIdentifier: "goHome", sender: self)
                        }
                        else if self.phoneNumberCheck != self.phoneNumber && self.passwordCheck == self.passWord {
                
                            let alert = UIAlertController(title: "로그인 실패", message: "핸드폰 번호를 확인하세요", preferredStyle: .alert)
                            let dismissButton = UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
                            alert.addAction(dismissButton)
                            self.present(alert, animated: true, completion: nil)
                        }
                        else if self.phoneNumberCheck == self.phoneNumber && self.passwordCheck != self.passWord {
                
                            let alert = UIAlertController(title: "로그인 실패", message: "비밀번호를 확인하세요", preferredStyle: .alert)
                            let dismissButton = UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
                            alert.addAction(dismissButton)
                            self.present(alert, animated: true, completion: nil)
                        }
                        else if self.phoneNumberCheck != self.phoneNumber && self.passwordCheck != self.passWord {
            
                            let alert = UIAlertController(title: "로그인 실패", message: "핸드폰 번호와 비밀번호를 확인하세요", preferredStyle: .alert)
                            let dismissButton = UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
                            alert.addAction(dismissButton)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                })
            }
        })
    }
    
    
    func checkFlag() {
        
        if phoneFlag == false && passwordFlag == false {
            
            loginButton.isEnabled = false
            loginButton.alpha = 0.3
        }
        else if phoneFlag == true && passwordFlag == true {
            
            loginButton.isEnabled = true
            loginButton.alpha = 1.0
        }
    }
    

}
