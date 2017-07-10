//
//  SettingsViewController.swift
//  dontWorry2
//
//  Created by air on 2017. 6. 2..
//  Copyright © 2017년 Kylie. All rights reserved.
//

import UIKit
import Contacts
import Firebase

class SettingsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var dbRef : DatabaseReference!
    
    var userName = ""
    var userPhone = ""
    var userPass = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        dbRef = Database.database().reference()
        
        dbRef.child("user/name").observeSingleEvent(of: .value, with: {(snapshot) in
            
            if let nameDB = snapshot.value as? String {
                
                self.userName = "\(nameDB)"
                self.nameLabel.text = self.userName
                
                self.dbRef.child("user/phone").observeSingleEvent(of: .value, with: {(snapshot) in
                    
                    if let phoneDB = snapshot.value as? Int {
                        
                        self.userPhone = "\(phoneDB)"
                        self.phoneLabel.text = self.userPhone
                    }
                })
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func settingAlarm(_ sender: Any) {
        
        let optionMenu = UIAlertController(title: "알람 설정", message: "키거나 끄세요!", preferredStyle: .actionSheet)
        
        let on = UIAlertAction(title: "알람 켜기", style: .default, handler: {
            (alert : UIAlertAction) -> Void in
            
            
            
            
            
        })
        
        let off = UIAlertAction(title: "알람 끄기", style: .default, handler: {
            (alert : UIAlertAction) -> Void in
            
            
            
            
            
        })
        
        let Cancel = UIAlertAction(title: "취소", style: .cancel, handler: {(alert : UIAlertAction) -> Void in})
        
        optionMenu.addAction(on)
        optionMenu.addAction(off)
        optionMenu.addAction(Cancel)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    
    @IBAction func setPass(_ sender: Any) {
    }
    
    @IBAction func resign(_ sender: Any) {
        
        let optionMenu = UIAlertController(title: "계정 탈퇴", message: "정말 돈워리를 탈퇴하실건가요?", preferredStyle: .actionSheet)
        
        let resign = UIAlertAction(title: "탈퇴합니다", style: .default, handler: {(alert : UIAlertAction) -> Void in
            
            Database.database().reference().child("user").removeValue(completionBlock: { (error, refer) in })
        })
        
        let Cancel = UIAlertAction(title: "취소", style: .cancel, handler: {(alert : UIAlertAction) -> Void in })
        
        optionMenu.addAction(resign)
        optionMenu.addAction(Cancel)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    

}
