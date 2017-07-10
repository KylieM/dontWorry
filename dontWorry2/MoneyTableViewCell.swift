//
//  MoneyTableViewCell.swift
//  dontWorry2
//
//  Created by air on 2017. 7. 7..
//  Copyright © 2017년 Kylie. All rights reserved.
//

import UIKit
import Firebase

class MoneyTableViewCell: UITableViewCell {

    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    var dbRef : DatabaseReference!
    
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
    
    
    
    
    
    
    
    
    
    
    
}
