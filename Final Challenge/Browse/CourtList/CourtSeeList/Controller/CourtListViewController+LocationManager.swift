//
//  CourtListViewController+LocationManager.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 29/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit
import CoreLocation

extension CourtListViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            self.latitude = "\(location.coordinate.latitude)"
            self.longitude = "\(location.coordinate.longitude)"
            print(self.latitude as Any)
            DispatchQueue.main.async {
                self.initialization()
                self.setAddressName()
            }
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedWhenInUse || status == .authorizedAlways){
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}

