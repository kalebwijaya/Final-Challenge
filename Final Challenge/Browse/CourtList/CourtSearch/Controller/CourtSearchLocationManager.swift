//
//  CourtSearchLocationManager.swift
//  Final Challenge
//
//  Created by Steven on 12/4/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

extension CourtSearchViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            self.latitude = "\(location.coordinate.latitude)"
            self.longitude = "\(location.coordinate.longitude)"
            
            
            guard let sportTypeID = sportTypeID,let searchText = searchText , let latitude = self.latitude, let longitude = self.longitude else {
                return
            }
            
            let dataParam = CourtSearchParam(sportCenterName: searchText, sportTypeID: sportTypeID,latitude: latitude,longitude: longitude )
            getSearchData(getParam: dataParam)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedWhenInUse || status == .authorizedAlways){
            
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
