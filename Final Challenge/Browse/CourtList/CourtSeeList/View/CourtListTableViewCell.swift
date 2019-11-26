//
//  CourtListTableViewCell.swift
//  Final Challenge
//
//  Created by Steven on 11/19/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

class CourtListTableViewCell: UITableViewCell {

    @IBOutlet weak var sportCenterImage: UIImageView!
    @IBOutlet weak var sportCenterName: UILabel!
    @IBOutlet weak var sportCenterStartPrice: UILabel!
    @IBOutlet weak var sportCenterDistance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sportCenterName.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        sportCenterStartPrice.textColor = #colorLiteral(red: 0.9957345128, green: 0.7349595428, blue: 0.385543257, alpha: 1)
        
        setSportImageBorder()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setSportImageBorder(){
        sportCenterImage.layer.cornerRadius = 5
        sportCenterImage.clipsToBounds = true
        sportCenterImage.layer.masksToBounds = true
    }
    
}

extension String {
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }

        guard let characterSpacing = characterSpacing else {return attributedString}

        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }
}
