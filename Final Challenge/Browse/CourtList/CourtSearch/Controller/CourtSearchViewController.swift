//
//  CourtSearchViewController.swift
//  Final Challenge
//
//  Created by Steven on 11/19/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit
import CoreLocation

class CourtSearchViewController: UITableViewController {

    var courtSearchData = [CourtSearchData]()
    var longitude: String?
    var latitude: String?
    var courtSearchModel = CourtSearchModel()
    var url = URL(string: "\(BaseURL.baseURL)api/sport-center/search")
    var sportTypeID: Int?
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        initialization()
    }
    
    private func initialization(){
        tableView.register(UINib(nibName: "CourtListTableViewCell", bundle: nil), forCellReuseIdentifier:  "courtListCell")
        setUserLocation()
    }
    
    private func setUserLocation(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    private func getUserLocation(){
        let status = CLLocationManager.authorizationStatus()
        
        if (status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()) {
            //show alert nanti
            return
        }
        
        if (status == .notDetermined){
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestLocation()
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return courtSearchData.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "CourtDetails", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "courtDetails")
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courtListCell", for: indexPath) as! CourtListTableViewCell
        
        cell.sportCenterName.text = courtSearchData[indexPath.row].sportCenterName
        let textChangeColor: NSAttributedString = "from \(courtSearchData[indexPath.row].sportCenterName)".attributedStringWithColor(["from"], color: UIColor.black)
        
        cell.sportCenterStartPrice.attributedText = textChangeColor
        
        //count distance from user location to sport center

        guard let getLongitude = Double(courtSearchData[indexPath.row].sportCenterLong) , let getLatitude = Double(courtSearchData[indexPath.row].sportCenterLat) else {
            return cell
        }
        
        cell.sportCenterDistance.text = "\(getSportCenterDistance(sportLongitude: getLongitude, sportLatitude: getLatitude)) km Away"
        
        print("\(getSportCenterDistance(sportLongitude: getLongitude, sportLatitude: getLatitude)) km Away")
        
        cell.sportCenterImage.image = UIImage(named: "sport_center_image")
        
        

        return cell
    }
    
    public func getSportCenterDistance(sportLongitude: Double , sportLatitude: Double) -> Double {
        
        guard let latitude = latitude , let longitude = longitude else{
            return 0.0
        }
        
        let userCoordinate = CLLocation(latitude: Double(latitude)!, longitude: Double(longitude)!)
        
        let sportCoordinte = CLLocation(latitude: sportLatitude, longitude: sportLongitude)
        
        let distanceInMeters = userCoordinate.distance(from: sportCoordinte)
        
        return distanceInMeters
    }
    
    public func getSearchData(getParam : CourtSearchParam){
        guard let jsonUrl = url else {
            return
        }
        courtSearchModel.fetchData(url: jsonUrl, getUserData: getParam) { (responses, error) in
            if let response = responses {
                if (response.errorCode == "200"){
                    self.courtSearchData = response.data
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }else if (response.errorCode == "400") {
                    print(response.errorMessage)
                }
            }else if let error = error {
                print(error)
            }
        }
    }

    
}

extension CourtSearchViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchTxt = searchController.searchBar.text else{
            return
        }
        
        getUserLocation()
        guard let searchText = searchController.searchBar.text, let sportTypeID = sportTypeID else {
            return
        }
        
        let dataParam = CourtSearchParam(sportCenterName: searchText, sportTypeID: sportTypeID)
        getSearchData(getParam: dataParam)
        
        
    }
    
}

extension CourtSearchViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            self.latitude = "\(location.coordinate.latitude)"
            self.longitude = "\(location.coordinate.longitude)"
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedWhenInUse || status == .authorizedAlways){
            
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
