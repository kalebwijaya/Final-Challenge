//
//  ProfileBodyTableViewCell.swift
//  Final Challenge
//
//  Created by Steven on 12/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

class ProfileBodyTableViewCell: UITableViewCell {

    @IBOutlet weak var bodyTitleTypeLbl: UILabel!
    @IBOutlet weak var bodyInput: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bodyInput.borderStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
