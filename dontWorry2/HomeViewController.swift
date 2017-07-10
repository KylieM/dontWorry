//
//  HomeViewController.swift
//  dontWorry2
//
//  Created by air on 2017. 6. 2..
//  Copyright © 2017년 Kylie. All rights reserved.
//

import UIKit
import Contacts
import FSCalendar

class HomeViewController: UIViewController {
    
    @IBOutlet weak var monthlyLabel: UILabel!
    @IBOutlet weak var calendarView: UIView!
    
    @IBOutlet weak var friendsButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    @IBAction func friends(_ sender: Any) {
    }
    @IBAction func list(_ sender: Any) {
    }
    @IBAction func settings(_ sender: Any) {
    }
    
}
