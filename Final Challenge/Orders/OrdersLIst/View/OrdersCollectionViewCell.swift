//
//  OrdersCollectionViewCell.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 18/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

class OrdersCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var courtImage: UIImageView!
    @IBOutlet weak var courtName: UILabel!
    @IBOutlet weak var dateOrder: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var orderStatus: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 10
        clipsToBounds = false
        layer.masksToBounds = false
    }

}
