//
//  CourtListView.swift
//  Final Challenge
//
//  Created by Steven on 11/18/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

class CourtListView: UIView {

    @IBOutlet weak var userLocationAdress: UILabel!
    @IBOutlet weak var courtListTableView: UITableView!
    @IBOutlet weak var addressViewContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        courtListTableView.tableFooterView = UIView()
        setAddressContainerBorder()
        setUserLocationBorder()
    }
    
    private func setAddressContainerBorder(){
        addressViewContainer.backgroundColor = UIColor.white
        addressViewContainer.layer.shadowOpacity = 1
        addressViewContainer.layer.shadowRadius = 2
        addressViewContainer.layer.shadowColor = UIColor(named: "Black")?.cgColor
        addressViewContainer.layer.shadowOffset = CGSize(width: 3, height: 3)
        addressViewContainer.layer.cornerRadius = 10
        addressViewContainer.clipsToBounds = true
        addressViewContainer.layer.masksToBounds = true
    }
    
    private func setUserLocationBorder(){
        userLocationAdress.layer.cornerRadius = 10
        userLocationAdress.clipsToBounds = true
        userLocationAdress.backgroundColor = UIColor(named: "Black")
        userLocationAdress.layer.masksToBounds = true
        
        userLocationAdress.layer.cornerRadius = 10
        userLocationAdress.clipsToBounds = true
        userLocationAdress.layer.masksToBounds = true
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
