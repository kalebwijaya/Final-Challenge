//
//  BrowseTableViewCell.swift
//  Final Challenge
//
//  Created by Steven on 11/18/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

class BrowseTableViewCell: UITableViewCell {

    @IBOutlet weak var sportTypeLbl: UILabel!
    @IBOutlet weak var sportImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var clippingView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        setContainerBorder()
        setClippingBorder()
    }
    private func setContainerBorder(){
        containerView.backgroundColor = UIColor.clear
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowRadius = 2
        containerView.layer.shadowColor = UIColor(named: "Orange")?.cgColor
        containerView.layer.shadowOffset = CGSize(width: 3, height: 3)
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = true
    }
    
    private func setClippingBorder(){
        clippingView.layer.cornerRadius = 10
        clippingView.clipsToBounds = true
        clippingView.backgroundColor = UIColor(named: "Red")
        clippingView.layer.masksToBounds = true
        
        sportImage.layer.cornerRadius = 10
        sportImage.clipsToBounds = true
        sportImage.layer.masksToBounds = true
        
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
