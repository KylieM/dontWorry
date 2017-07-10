//
//  MoneyViewController.swift
//  dontWorry2
//
//  Created by air on 2017. 6. 2..
//  Copyright © 2017년 Kylie. All rights reserved.
//

import UIKit
import Firebase

class MoneyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var goGraphButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var dbRef : DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dbRef = Database.database().reference()
        
        tableView.register(UINib(nibName: "MoneyTableViewCell", bundle: nil), forCellReuseIdentifier: "MoneyTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    

}
