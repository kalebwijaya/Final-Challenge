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
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.585175693, green: 0.5851898789, blue: 0.5851822495, alpha: 1)
        layer.cornerRadius = 4
        
    }

}
