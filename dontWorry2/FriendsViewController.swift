//
//  FriendsViewController.swift
//  dontWorry2
//
//  Created by air on 2017. 6. 2..
//  Copyright © 2017년 Kylie. All rights reserved.
//

import UIKit
import Contacts
import MessageUI
import Firebase

class FriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var friendsTableView: UITableView!
    @IBOutlet weak var noContractsLabel: UILabel!
    
    var dbRef : DatabaseReference!
    
    var contactStore = CNContactStore()
    var contacts = [ContactEntry]()
    
    var contactName = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        dbRef = Database.database().reference()
        
        friendsTableView.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        friendsTableView.isHidden = true
        noContractsLabel.isHidden = false
        noContractsLabel.text = "Retrieving contacts..."
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        requestAccessToContacts { (success) in
            if success {
                
                self.retrieveContacts({ (success, contacts) in
                    
                    self.friendsTableView.isHidden = !success
                    self.noContractsLabel.isHidden = success
                    if success && (contacts?.count)! > 0 {
                        
                        self.contacts = contacts!
                        self.friendsTableView.reloadData()
                    } else {
                        
                        self.noContractsLabel.text = "Unable to get contacts..."
                    }
                })
            }
        }
    }
    
    
    func requestAccessToContacts(_ completion: @escaping (_ success: Bool) -> Void) {
        
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        
        switch authorizationStatus {
            
        case .authorized: completion(true) // authorized previously
        case .denied, .notDetermined: // needs to ask for authorization
            self.contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (accessGranted, error) -> Void in
                
                completion(accessGranted)
            })
        default: // not authorized.
            completion(false)
        }
    }
    
    func retrieveContacts(_ completion: (_ success: Bool, _ contacts: [ContactEntry]?) -> Void) {
        
        var contacts = [ContactEntry]()
        
        do {
            let contactsFetchRequest = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactImageDataKey as CNKeyDescriptor, CNContactImageDataAvailableKey as CNKeyDescriptor, CNContactPhoneNumbersKey as CNKeyDescriptor, CNContactEmailAddressesKey as CNKeyDescriptor])
            
            try contactStore.enumerateContacts(with: contactsFetchRequest, usingBlock: { (cnContact, error) in
                
                if let contact = ContactEntry(cnContact: cnContact) {
                    
                    contacts.append(contact)
                }
            })
            
            completion(true, contacts)
        } catch {
            
            completion(false, nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: AnyObject) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    // UITableViewDataSource && Delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contacts.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : ContactTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as! ContactTableViewCell
        
        let entry = contacts[(indexPath as NSIndexPath).row]

        cell.configureWithContactEntry(entry)
        cell.layoutIfNeeded()
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let optionMenu = UIAlertController(title: "옵션", message: "", preferredStyle: .actionSheet)
        
        let credit = UIAlertAction(title: "신용등급", style: .default, handler: {
            (alert : UIAlertAction) -> Void in
        })
        let add = UIAlertAction(title: "각서추가", style: .default, handler: {
            (alert : UIAlertAction) -> Void in
            
            let indexPath = tableView.indexPathForSelectedRow
            let cell = tableView.cellForRow(at: indexPath!) as? ContactTableViewCell
            
            let receiverName = cell?.contactNameLabel.text ?? ""
            
            self.contactName = receiverName
            
            let choiceMenu = UIAlertController(title: "\(self.contactName)", message: "\(self.contactName) 은/는 채무자인가요 채권자인가요?", preferredStyle: .actionSheet)
            let Action1 = UIAlertAction(title: "채무자", style: .default, handler: {(alert: UIAlertAction) -> Void in //사용자는 채권자

                self.performSegue(withIdentifier: "addPaper_userIsCreditor", sender: self)                
            })
            let Action2 = UIAlertAction(title: "채권자", style: .default, handler: {(alert: UIAlertAction) -> Void in
            
                self.performSegue(withIdentifier: "addPaper_userIsDebtor", sender: self)
            })
            let Cancel = UIAlertAction(title: "취소", style: .cancel, handler: {(alert: UIAlertAction) -> Void in})
            
            choiceMenu.addAction(Action1)
            choiceMenu.addAction(Action2)
            choiceMenu.addAction(Cancel)
            
            self.present(choiceMenu, animated: true, completion: nil)
            
            //self.performSegue(withIdentifier: "addPaper", sender: self)
        })
        let alarm = UIAlertAction(title: "독촉문자 보내기", style: .default, handler: {
            (alert : UIAlertAction) -> Void in
            
            
            //문자보내기
            if MFMessageComposeViewController.canSendText(){
                
                let msg : MFMessageComposeViewController = MFMessageComposeViewController()
                
                
                let indexPath = tableView.indexPathForSelectedRow
                let cell = tableView.cellForRow(at: indexPath!) as? ContactTableViewCell
                
                let receiverName = cell?.contactNameLabel.text ?? ""
                let receiverPhone = cell?.contactPhoneLabel.text ?? ""
                
                
                self.dbRef.child("user/contacts/").observe(.value, with: {(snapshot) in //receiver 정보 가져오기
                    
                    if let result = snapshot.children.allObjects as? [DataSnapshot] {
                        
                        for child in result {
                            
                            //let autoID = child.key as String //autoID 값 가져옴
                            
                            let receiverNameDB = child.childSnapshot(forPath: "contactName").value! as! String
                            let amountDB = child.childSnapshot(forPath: "lendAmount").value! as! String
                            let dueDateDB = child.childSnapshot(forPath: "lendDueDate").value! as! String
                            
                            if receiverNameDB == receiverName {
                                
                                msg.recipients = [receiverPhone]
                                msg.body = "\(receiverName)씨 \(dueDateDB) 까지 \(amountDB)원 갚으세요!"
                                msg.messageComposeDelegate = self
                                self.present(msg, animated:true, completion:nil)
                            }
                        }
                    }
                })
                
                
            }
            else {
                let alert = UIAlertController(title: "독촉 실패", message: "문자보내기를 지원하지 않는 기기입니다.", preferredStyle: .alert)
                let dismissButton = UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
                alert.addAction(dismissButton)
                self.present(alert, animated: true, completion: nil)
            }
        })
        
        let Cancel = UIAlertAction(title: "취소", style: .cancel, handler: {
            (alert : UIAlertAction) -> Void in
            
        })
        
        optionMenu.addAction(credit)
        optionMenu.addAction(add)
        optionMenu.addAction(alarm)
        optionMenu.addAction(Cancel)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        switch (result.rawValue) {
            
        case MessageComposeResult.cancelled.rawValue:
            print("Message was cancelled")
            controller.dismiss(animated: true, completion: nil)
            
        case MessageComposeResult.failed.rawValue:
            print("Message failed")
            controller.dismiss(animated: true, completion: nil)
            
        case MessageComposeResult.sent.rawValue:
            print("Message was sent")
            controller.dismiss(animated: false, completion: nil)
            
        default:
            break
        }
    }
    
    

    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
            
            switch identifier {
                
            case "addPaper_userIsCreditor":
                let destination = segue.destination as! addPaperViewController
                destination.debtorName = self.contactName
                
            case "addPaper_userIsDebtor":
                let destination = segue.destination as! addPaper_userIsDebtorViewController
                destination.creditorName = self.contactName
                
            default :
                print("Hey")
            }
        }
    }
    
    
    
    
}
