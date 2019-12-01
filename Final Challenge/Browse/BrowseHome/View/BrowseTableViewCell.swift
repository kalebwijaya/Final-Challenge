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
    @IBOutlet weak var textBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        setContainerBorder()
        setClippingBorder()
        setBlurTextBackground()
    }
    private func setContainerBorder(){
        containerView.backgroundColor = UIColor.clear
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowRadius = 10
        containerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = true
    }
    
    private func setClippingBorder(){
        clippingView.layer.cornerRadius = 8
        clippingView.clipsToBounds = true
        clippingView.backgroundColor = UIColor(named: "Red")
        clippingView.layer.masksToBounds = true
        
        sportImage.layer.cornerRadius = 8
        sportImage.clipsToBounds = true
        sportImage.layer.masksToBounds = true
        
    }
    
    private func setBlurTextBackground(){
        textBackground.backgroundColor = UIColor(red: 1, green: 0.65, blue: 0.39, alpha: 1)
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
