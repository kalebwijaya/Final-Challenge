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
        //setAddressContainerBorder()
        setUserLocationBorder()
    }
    
    private func setAddressContainerBorder(){
        addressViewContainer.layer.cornerRadius = 10
        addressViewContainer.layer.shadowColor = UIColor.gray.cgColor
        addressViewContainer.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        addressViewContainer.layer.shadowRadius = 0.5
        addressViewContainer.layer.shadowOpacity = 0.7

//        addressViewContainer.backgroundColor = UIColor.clear
//        addressViewContainer.layer.shadowOpacity = 1
//        addressViewContainer.layer.shadowRadius = 2
//        addressViewContainer.layer.shadowColor = UIColor(named: "Black")?.cgColor
//        addressViewContainer.layer.shadowOffset = CGSize(width: 3, height: 3)
//        addressViewContainer.layer.cornerRadius = 10
//        addressViewContainer.clipsToBounds = true
//        addressViewContainer.layer.masksToBounds = true
    }
    
    private func setUserLocationBorder(){
        
        userLocationAdress.layer.cornerRadius = 10
        userLocationAdress.clipsToBounds = true
        userLocationAdress.layer.masksToBounds = true
    
    }
}
