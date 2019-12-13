//
//  ProfileHeaderTableViewCell.swift
//  Final Challenge
//
//  Created by Steven on 12/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

class ProfileHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userNameLbl.numberOfLines = 0
        userNameLbl.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        userNameLbl.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
