//
//  CourtListView.swift
//  Final Challenge
//
//  Created by Steven on 11/18/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

class CourtListView: UIView {

    @IBOutlet weak var courtListTableView: UITableView!

    override func awakeFromNib() {
        super.awakeFromNib()
        courtListTableView.tableFooterView = UIView()
       
        
    }
    
}
