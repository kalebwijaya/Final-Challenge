//
//  CourtDetailsViewController.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 19/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit
import MapKit

class CourtDetailsViewController: UIViewController {
    @IBOutlet weak var imageCarousel: UIScrollView!
    @IBOutlet weak var imagePageController: UIPageControl!
    @IBOutlet weak var gradientBar: UIView!
    @IBOutlet weak var sportCenterName: UILabel!
    @IBOutlet weak var courtMinPrice: UILabel!
    @IBOutlet weak var courtStatus: UILabel!
    @IBOutlet weak var courtOpenTime: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var courtMap: MKMapView!
    @IBOutlet weak var bookNowBtn: UIButton!
    @IBOutlet weak var facilityText: UILabel!
    @IBOutlet weak var scrolVIewSubView: UIView!
    @IBOutlet weak var getDirection: UILabel!
    
    var images:[ImageSlide] = []
    var courtDetails:CourtDetailsData!
    let url = URL(string: "\(BaseURL.baseURL)api/sport-center/detail")
    var courtDetailParam: CourtDetailsParam!
    var courtDetailModel = CourtDetailsModel()
    var getSportTypeID: String?
    var getSportCenterID: String?
    let currencyFormatter = NumberFormatter()
    let loadingView = UIView()
    var loadingIndicator:LoadingIndicator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator = LoadingIndicator(loadingView: loadingView, mainView: self.view)
        getData()
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.778283298, blue: 0.4615219235, alpha: 1)
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.groupingSeparator = "."
        currencyFormatter.numberStyle = .decimal
        currencyFormatter.locale = Locale(identifier: "id_ID")
        
        self.view.sendSubviewToBack(scrolVIewSubView)
        imageCarousel.delegate = self
        setGradientBackground()
        view.bringSubviewToFront(imagePageController)
        view.bringSubviewToFront(bookNowBtn)
        setNeedsStatusBarAppearanceUpdate()
        imageCarousel.contentInsetAdjustmentBehavior = .never
        setButtonClickHandler()
        self.setAddressWhenTap()
    }
    
    func setAddressWhenTap(){
        getDirection.isUserInteractionEnabled = true
        let gestureMaps = UITapGestureRecognizer(target: self, action:  #selector(self.addressTapped))
        self.getDirection.addGestureRecognizer(gestureMaps)
    }
    
    @objc func addressTapped(){
        let lat = courtDetails.sportCenterLat
        let long = courtDetails.sportCenterLong
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.openURL(URL(string: "comgooglemaps://?q=\(lat),\(long)&directionsmode=driving&zoom=14")!)
        } else {
          print("Can't use comgooglemaps://");
        }
        
    }
    
    func setButtonClickHandler(){
        bookNowBtn.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
    }
    
    @objc func buttonHandler(sender: UIButton){
        let storyBoard = UIStoryboard(name: "Booking", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "booking") as! BookingViewController
        vc.getSportTypeID = self.getSportTypeID
        vc.getSportCenterID = self.getSportCenterID
        vc.sportCenterName = self.courtDetails.sportCenterName
        self.navigationController?.pushViewController(vc, animated: true)
        print("testing button")
    }
    
    @IBAction func phoneCallButton(_ sender: Any) {
        if let phoneURL = NSURL(string: ("tel://" + courtDetails.sportCenterPhone)) {
            UIApplication.shared.open(phoneURL as URL, options: [:], completionHandler: nil)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func getData(){
        
        guard let jsonUrl = url,
            let sportTypeID = getSportTypeID,
            let sportCenterID = getSportCenterID,
            let loadingIndicator = loadingIndicator
            else {
                return
                
        }
        loadingIndicator.showLoading()
        
        courtDetailParam = CourtDetailsParam(sportTypeID: sportTypeID, sportCenterID: sportCenterID)
    
        courtDetailModel.getData(url: jsonUrl, setParam: courtDetailParam) { (result, error) in
            
            if let result = result{
                if(result.errorCode == "200"){
                    self.courtDetails = result.data
                    DispatchQueue.main.async {
                        self.setAllData()
                    }
                }else if(result.errorCode == "400"){
                    print(result.errorMessage)
                }
            }else if let error = error {
                print(error)
            }
        }
        
        loadingIndicator.removeLoading()
        
    }
    
    func setAllData(){
        self.addImage()
        self.setupSlideScrollView(images: self.images)
        self.imagePageController.numberOfPages = self.images.count
        self.imagePageController.currentPage = 0
        
        sportCenterName.text = courtDetails.sportCenterName
        
        courtMinPrice.text = "Rp. " +  currencyFormatter.string(from: NSNumber(value: Int(self.courtDetails.sportMinPrice)!))!
        
        courtStatus.text = courtDetails.sportCenterStatus.capitalizingFirstLetter()
        if(courtDetails.sportCenterStatus == "open"){
            courtStatus.textColor = UIColor(red: 0, green: 0.77, blue: 0.55, alpha: 1)
        }else{
            courtStatus.textColor = UIColor(red: 0.98, green: 0.48, blue: 0.42, alpha: 1)
        }
        courtOpenTime.text = courtDetails.sportCenterOpenTime + " - " + courtDetails.sportCenterCloseTime
        
        generateAddress()
        let annotation = MKPointAnnotation()
        let locationCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(Double(courtDetails.sportCenterLat)!), longitude: CLLocationDegrees(Double(courtDetails.sportCenterLong)!))
        
        annotation.coordinate = locationCoordinate
        
        facilityText.text = courtDetails.sportCenterFacility
        
        courtMap.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locationCoordinate, span: span)
        courtMap.setRegion(region, animated: true)
        courtMap.isScrollEnabled = false
        setCourtMapClicked()
    }
    
    func setCourtMapClicked(){
        let locationCoordinatex = CLLocationCoordinate2D(latitude: CLLocationDegrees(Double(courtDetails.sportCenterLat)!), longitude: CLLocationDegrees(Double(courtDetails.sportCenterLong)!))
    }
    
    func generateAddress(){
        addressLabel.text = courtDetails.sportCenterAddress
        addressLabel.numberOfLines = 0
        let maximumLabelSize: CGSize = CGSize(width: 338, height: 9999)
        let expectedLabelSize: CGSize = addressLabel.sizeThatFits(maximumLabelSize)
        var newFrame: CGRect = addressLabel.frame
        newFrame.size.height = expectedLabelSize.height
        addressLabel.frame = newFrame
        addressView.frame.size.height += expectedLabelSize.height - 18
        addressLabel.centerXAnchor.constraint(equalTo: addressView.centerXAnchor).isActive = true
        addressLabel.centerYAnchor.constraint(equalTo: addressView.centerYAnchor).isActive = true
    }
    
    //moved
    func setupSlideScrollView(images : [ImageSlide]) {
        imageCarousel.frame = CGRect(x: 0, y: 0, width: imageCarousel.frame.width, height: imageCarousel.frame.height)
        imageCarousel.contentSize = CGSize(width: imageCarousel.frame.width * CGFloat(images.count), height: imageCarousel.frame.height)
        imageCarousel.isPagingEnabled = true
        
        for i in 0 ..< images.count {
            images[i].frame = CGRect(x: imageCarousel.frame.width * CGFloat(i), y: 0, width: imageCarousel.frame.width, height: imageCarousel.frame.height)
            imageCarousel.addSubview(images[i])
        }
    }
    
    //done moved
    func setGradientBackground() {
        var gradient: CAGradientLayer!
        gradient = CAGradientLayer()
        gradient.frame = gradientBar.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0, 0, 0, 1]
        gradientBar.layer.mask = gradient
    }
    
    //done moved
    func addImage(){
        for n in 0 ..< courtDetails.sportCenterImage.count {
            let slide:ImageSlide = Bundle.main.loadNibNamed("ImageSlide", owner: self, options: nil)?.first as! ImageSlide
            
            if let imageURL = URL(string: courtDetails.sportCenterImage[n].sportImageURL){
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            slide.courtImage.image = image
                        }
                    }
                }
            }
            images.append(slide)
        }
    }
}

//done moved
extension CourtDetailsViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        imagePageController.currentPage = Int(pageIndex)
        
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
