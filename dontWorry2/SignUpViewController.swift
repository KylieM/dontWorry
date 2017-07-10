//
//  SignUpViewController.swift
//  dontWorry2
//
//  Created by air on 2017. 6. 2..
//  Copyright © 2017년 Kylie. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    var dbRef : DatabaseReference!
    var count = 0
    
    var nameFlag = false
    var phoneFlag = false
    var passwordFlag = false
    var agreeFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbRef = Database.database().reference()
        
        checkFlag()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func name(_ sender: Any) {

        if let text = nameTextField.text, !text.isEmpty
        {
            nameFlag = true
        }
        self.resignFirstResponder()
        
        checkFlag()
    }
   
    @IBAction func phone(_ sender: Any) {
        
        if let text = phoneTextField.text, !text.isEmpty
        {
            phoneFlag = true
        }
        self.resignFirstResponder()
        
        checkFlag()
    }
    
    @IBAction func password(_ sender: Any) {
        
        if let text = passwordTextField.text, !text.isEmpty
        {
            passwordFlag = true
        }
        self.resignFirstResponder()
        
        checkFlag()
    }
    
    @IBAction func previous(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func agree(_ sender: Any) {
        
        let alert = UIAlertController(title: "개인정보 수집 및 활용 동의", message: "돈워리는 당신의 이름, 핸드폰번호와 주소록을 이용할 것입니다. 동의하시나요?", preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: "동의합니다", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(dismissButton)
        self.present(alert, animated: true, completion: nil)
        
        agreeFlag = true
        
        checkFlag()
    }
    

    @IBAction func signUp(_ sender: Any) {
        
        if agreeFlag == true {
            
            let nameData = ["name": nameTextField.text!]
            dbRef.child("user").setValue(nameData)
            
            let phone: Int = Int(phoneTextField.text!)!
            let phoneData = ["phone": phone]
            dbRef.child("user").updateChildValues(phoneData)
            
            let password: Int = Int(passwordTextField.text!)!
            let passwordData = ["password": password]
            dbRef.child("user").updateChildValues(passwordData)
    }
        /*if agreeFlag == true {
            count += 1
            
            let nameData = ["name": nameTextField.text!]
            dbRef.child("user/" + String(count)).setValue(nameData)
            
            let phone: Int = Int(phoneTextField.text!)!
            let phoneData = ["phone": phone]
            dbRef.child("user/" + String(count)).updateChildValues(phoneData)
            
            let password: Int = Int(passwordTextField.text!)!
            let passwordData = ["password": password]
            dbRef.child("user/" + String(count)).updateChildValues(passwordData)
        }*/
    }
    
    func checkFlag() {
        
        if nameFlag == false && phoneFlag == false && passwordFlag == false && agreeFlag == false {
            
            signUpButton.isEnabled = false
            signUpButton.alpha = 0.3
        }
        else if nameFlag == true && phoneFlag == true && passwordFlag == true && agreeFlag == true {
            
            signUpButton.isEnabled = true
            signUpButton.alpha = 1.0
        }
    }
    
    

}

