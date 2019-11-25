//
//  CourtSearchParam.swift
//  Final Challenge
//
//  Created by Steven on 11/21/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class CourtSearchParam: Codable{
    var sportCenterName: String
    var sportTypeID: Int
    
    enum CodingKeys: String , CodingKey {
        case sportCenterName = "sport_center_name"
        case sportTypeID = "sport_type_id"
    }
    
    init(sportCenterName: String, sportTypeID: Int) {
        self.sportCenterName = sportCenterName
        self.sportTypeID = sportTypeID
    }
}
