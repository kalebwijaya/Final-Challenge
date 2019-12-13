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
    var loadingIndicator:LoadingIndicator?
    let loadingView = UIView()
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
        
        loadingIndicator = LoadingIndicator(loadingView: loadingView, mainView: self.view)
        
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
        guard let loadingIndicator = loadingIndicator else{
            return
        }
        loadingIndicator.showLoading()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
        navigationItem.hidesBackButton = true
    }
    
    public func getUserLocation(){
        if CLLocationManager.locationServicesEnabled(){
            switch CLLocationManager.authorizationStatus() {
            case .restricted, .denied:
                locationAlertDialog()
            case .authorizedAlways, .authorizedWhenInUse :
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                return
            @unknown default:
                break
            }
        }else {
            locationAlertDialog()
        }
        
    }
    
    public func locationAlertDialog(){
        let alert = UIAlertController(title: "You need to turn on your location", message: "We need your location to show nearby courts.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
        
        let settingAction = UIAlertAction(title: NSLocalizedString("Setting", comment: ""), style: .default) { (UIAlertAction) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)! as URL, options: [:], completionHandler: nil)
        }
        alert.addAction(settingAction)
        alert.addAction(cancelAction)
        self.present(alert,animated: true, completion: nil)
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
        guard let loadingIndicator = loadingIndicator else {
            return
        }
        
        loadingIndicator.removeLoading()
        
        guard let jsonUrl = url else {
            return print("data not found")
        }
        
        courtSearchData.removeAll()
        self.tableView.reloadData()
        
        courtSearchModel.fetchData(url: jsonUrl, getUserData: getParam) { (responses, error) in
            if let response = responses {
                if (response.errorCode == "200"){
                    self.courtSearchData = response.data
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }else if (response.errorCode == "400") {
                    print("ni jalan")
                    print(response.errorMessage)
                }
            }else if let error = error {
                print("ni jalan")
                print(error)
            }
        }
        
        
    }

    
}





