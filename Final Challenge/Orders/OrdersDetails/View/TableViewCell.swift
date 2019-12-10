//
//  TableViewCell.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 10/12/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var courtName: UILabel!
    @IBOutlet weak var courtPrice: UILabel!
    @IBOutlet weak var courtDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
