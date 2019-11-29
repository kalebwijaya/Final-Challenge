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
    
    let loadingView = UIView()
    var loadingIndicator:LoadingIndicator?

    var searchController: UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator = LoadingIndicator(loadingView: loadingView, mainView: self.view)
        setNavigation()
        setUserPermissionLocation()
        
    }
    
    private func setNavigation(){
        
        self.title = "Courts"
        
        navigationController?.navigationBar.prefersLargeTitles = false
       
        //setSearchBar()
    }
    
    
    
    private func setSearchBar(){
        
        let storyboard = UIStoryboard(name: "CourtSearch", bundle: nil)
        let courtSearchTable = storyboard.instantiateViewController(identifier: "courtSearch") as! CourtSearchViewController
        courtSearchTable.sportTypeID = getSportTypeID
        
        searchController = UISearchController(searchResultsController: courtSearchTable)
        //searchController?.searchBar.delegate = courtSearchTable
        searchController?.searchResultsUpdater = courtSearchTable
        
        let searchBar = searchController?.searchBar
        
        searchBar?.sizeToFit()
        searchBar?.placeholder = "Search Sport Center Name"

        searchController?.searchBar.showsCancelButton = false
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        navigationItem.searchController = searchController
        
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
        self.navigationItem.backBarButtonItem?.title = "Court Category"
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
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        getUserLocation()
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
                    self.addressName = address
                    self.courtListView.courtListTableView.reloadData()
                    self.loadingIndicator!.removeLoading()
                }
            }
           
        }
    }

}
