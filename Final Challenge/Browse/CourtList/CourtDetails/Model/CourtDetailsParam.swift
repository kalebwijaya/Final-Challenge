//
//  CourtDetailsParam.swift
//  Final Challenge
//
//  Created by Steven on 11/26/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class CourtDetailsParam: Codable{
    
    let sportTypeID,sportCenterID: String
    
    enum CodingKeys: String, CodingKey {
        case sportTypeID = "sport_type_id"
        case sportCenterID = "sport_center_id"
    }
    
    init(sportTypeID: String , sportCenterID: String) {
        self.sportTypeID = sportTypeID
        self.sportCenterID = sportCenterID
    }
}
