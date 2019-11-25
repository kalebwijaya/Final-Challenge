//
//  TimeViewCell.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 22/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

class TimeViewCell: UICollectionViewCell {

    @IBOutlet weak var time: UILabel!
    
    var timeString:String = ""
    var price:Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
