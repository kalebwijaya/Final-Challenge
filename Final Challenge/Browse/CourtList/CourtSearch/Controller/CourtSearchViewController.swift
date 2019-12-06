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
    var nav: UINavigationController!
    var latitude: String?
    var courtSearchModel = CourtSearchModel()
    var url = URL(string: "\(BaseURL.baseURL)api/sport-center/search")
    var sportTypeID: Int?
    var searchText: String?
    let locationManager = CLLocationManager()
    let currencyFormatter = NumberFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        initialization()
    }
    
    private func initialization(){
        
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.groupingSeparator = "."
        
        self.tableView.tableFooterView = UIView()
        
        currencyFormatter.numberStyle = .decimal
        currencyFormatter.locale = Locale(identifier: "id_ID")
    
        tableView.register(UINib(nibName: "CourtListTableViewCell", bundle: nil), forCellReuseIdentifier:  "courtListCell")
        courtSearchData.removeAll()
        self.tableView.reloadData()
        setUserLocation()
    }
    
    private func setUserLocation(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
        navigationItem.hidesBackButton = true
    }
    
    public func getUserLocation(){
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
        
        let storyboard = UIStoryboard(name: "BookingCourtDetails", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "courtDetails") as! CourtDetailsViewController
        
        guard let sportTypeID = self.sportTypeID else{
            return
        }
        vc.getSportTypeID = "\(sportTypeID)"
        vc.getSportCenterID = "\(courtSearchData[indexPath.row].sportCenterID)"
        vc.hidesBottomBarWhenPushed = true
        
        nav.pushViewController(vc, animated: true)
        
        self.dismiss(animated: false, completion: nil)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courtListCell", for: indexPath) as! CourtListTableViewCell
        
        cell.sportCenterName.text = courtSearchData[indexPath.row].sportCenterName
        
        let textChangeColor: NSAttributedString = "From Rp. \( currencyFormatter.string(from: NSNumber(value: Int(courtSearchData[indexPath.row].courtMinPrice)!))! )".attributedStringWithColor(["From"], color: UIColor.black)
        
        cell.sportCenterStartPrice.attributedText = textChangeColor
        
        //count distance from user location to sport center


        
        cell.sportCenterDistance.text = "\(String(format: "%.2f", courtSearchData[indexPath.row].sportCenterDistance)) km Away"
        
        self.courtSearchModel.getImage(imageURL: courtSearchData[indexPath.row].sportCenterImageURL) { (data) in
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                cell.sportCenterImage.image = image
            }
        }

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
        courtSearchData.removeAll()
        self.tableView.reloadData()
        guard let jsonUrl = url else {
            return
        }
        print(getParam.sportCenterName)
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





