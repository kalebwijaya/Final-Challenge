//
//  CourtListViewController.swift
//  Final Challenge
//
//  Created by Steven on 11/18/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit
import CoreLocation


class CourtListViewController: UIViewController {

    var getSportTypeID: Int?
    
    @IBOutlet var courtListView: CourtListView!
    let locationManager = CLLocationManager()
    
    var longitude: String?
    var latitude: String?
    var courtListModel = CourtListModel()
    let getCourtListUrl = URL(string: "\(BaseURL.baseURL)api/sport-center/list-courts")

    var getUserData: CourtListParam!
    var getCourtData = [CourtListData]()
    var getSportID: String?
    var sportTypeID: String?
    var addressName :String?
    let currencyFormatter = NumberFormatter()
    let loadingView = UIView()
    var loadingIndicator:LoadingIndicator?

    var searchController: UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator = LoadingIndicator(loadingView: loadingView, mainView: self.view)
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.groupingSeparator = "."
        
        currencyFormatter.numberStyle = .decimal
        currencyFormatter.locale = Locale(identifier: "id_ID")
        setNavigation()
        setUserPermissionLocation()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let index = self.courtListView.courtListTableView.indexPathForSelectedRow {
            self.courtListView.courtListTableView.deselectRow(at: index, animated: false)
        }
    }
    
    
    private func setNavigation(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        //self.title = "Courts"
        
        setSearchBar()
    }
    
    
    
    private func setSearchBar(){
        
        let storyboard = UIStoryboard(name: "CourtSearch", bundle: nil)
        let courtSearchTable = storyboard.instantiateViewController(identifier: "courtSearch") as! CourtSearchViewController
        courtSearchTable.sportTypeID = getSportTypeID
        courtSearchTable.nav = self.navigationController
        searchController = UISearchController(searchResultsController: courtSearchTable)
        searchController?.searchBar.delegate = courtSearchTable
        
        let searchBar = searchController?.searchBar
        
        searchBar?.sizeToFit()
        searchBar?.placeholder = "Search Sport Center Name"
        
        searchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
                
    }
    
    private func getData(userData : CourtListParam){
        guard let getURL = getCourtListUrl  else{
            return
        }
        
        
        courtListModel.fetchData(url: getURL, getUserData: getUserData) { (responses, error) in
            if let response = responses {
                if (response.errorCode == "200"){
                    self.getSportID = response.sportTypeID
                    self.getCourtData = response.data
                    self.sportTypeID = response.sportTypeID

                    DispatchQueue.main.async {
                        self.courtListView.courtListTableView.reloadData()
                    }
                    
                }else if (response.errorCode == "400"){
                    print(response.errorMessage)
                }
                
            }else if let error = error{
                print(error)
            }
        }
        
    }
    
    func initialization(){
        courtListView.courtListTableView.register(UINib(nibName: "CourtListTableViewCell", bundle: nil), forCellReuseIdentifier: "courtListCell")
        
        courtListView.courtListTableView.delegate = self
        courtListView.courtListTableView.dataSource = self
        guard let sportID = getSportTypeID, let longitude = longitude, let latitude = latitude else{
            return
        }
        
        getUserData = CourtListParam(sportTypeID: sportID, userLatitude: latitude, userLongitude: longitude)
        getData(userData: getUserData)
        
        
    }

    private func setUserPermissionLocation(){
        guard let loadingIndicator = loadingIndicator else {
            return
        }
        loadingIndicator.showLoading()
        locationManager.delegate = self
        getUserLocation()
    }
    
    private func getUserLocation(){
        
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
    
    public func getSportCenterDistance(sportLongitude: Double , sportLatitude: Double) -> Double {
        
        guard let latitude = latitude , let longitude = longitude else{
            return 0.0
        }
        
        let userCoordinate = CLLocation(latitude: Double(latitude)!, longitude: Double(longitude)!)
        
        let sportCoordinte = CLLocation(latitude: sportLatitude, longitude: sportLongitude)
        
        let distanceInMeters = userCoordinate.distance(from: sportCoordinte)
        
        return distanceInMeters
    }
    
    public func setAddressName(){
        var center: CLLocationCoordinate2D = CLLocationCoordinate2D()
        
        guard let longitude = longitude , let latitude = latitude else{
            return
        }
        
        let lat = Double(latitude)
        let long = Double(longitude)
        
        let geoCoder: CLGeocoder = CLGeocoder()
        
        center.latitude = lat!
        center.longitude = long!
        
        let loc: CLLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
        
        geoCoder.reverseGeocodeLocation(loc) { (placemarks, error) in
            
            guard let placemark = placemarks else {
                return
            }
            
            if (error != nil){
                print(error!.localizedDescription)
            }
            
            let pm = placemark as [CLPlacemark]
            
            if pm.count > 0 {
                let pm = placemark[0]
                print("placemark \(pm)")
                if pm.name != nil{
                    guard let address = pm.name else{
                        return
                    }
                    let range = address.rangeOfCharacter(from: NSCharacterSet.letters)
                    if  range != nil{
                        self.addressName = address
                    }else{
                        self.addressName = "Near You"
                    }
                    self.courtListView.courtListTableView.reloadData()
                    
                    guard let loadingIndicator = self.loadingIndicator else{
                        return
                    }
                   loadingIndicator.removeLoading()
                    
                }
            }
           
        }
    }

}


