//
//  CourtDetailsImage.swift
//  Final Challenge
//
//  Created by Steven on 11/26/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class CourtDetailsImage: Codable {
    let sportImageID, sportImageURL: String

    enum CodingKeys: String, CodingKey {
        case sportImageID = "sport_image_id"
        case sportImageURL = "sport_image_url"
    }

    init(sportImageID: String, sportImageURL: String) {
        self.sportImageID = sportImageID
        self.sportImageURL = sportImageURL
    }
}
