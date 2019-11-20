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
    
    var images:[ImageSlide] = []
    var courtDetails:CourtDetailsBooking!
    let url = URL(string: "http://10.60.50.34:3000/courtDetails")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        imageCarousel.delegate = self
        setGradientBackground()
        view.bringSubviewToFront(imagePageController)
        view.bringSubviewToFront(bookNowBtn)
        setNeedsStatusBarAppearanceUpdate()
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func getData(){
        guard let jsonUrl = url else {return}
        URLSession.shared.dataTask(with: jsonUrl) {(data,response, error) in
            guard let data = data, error == nil, response != nil else {
                print("URL Error")
                return
            }
            do {
                let result = try JSONDecoder().decode(CourtDetailsResult.self, from: data)
                if(result.errorCode == "200"){
                    self.courtDetails = result.data
                    print("JSON Get")
                    DispatchQueue.main.async {
                        self.setAllData()
                    }
                }else if(result.errorCode == "400"){
                    print(result.errorMessage)
                }
            } catch {
                print("Error After Getting JSON")
            }
        }.resume()
    }
    
    func setAllData(){
        self.addImage()
        self.setupSlideScrollView(images: self.images)
        self.imagePageController.numberOfPages = self.images.count
        self.imagePageController.currentPage = 0
        sportCenterName.text = courtDetails.sportCenterName
        let lineView = UIView(frame: CGRect(x: 16, y: sportCenterName.frame.maxY+10, width: self.view.frame.size.width-32, height: 1.0))
        lineView.layer.borderWidth = 1.0
        lineView.layer.borderColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1).cgColor
        self.view.addSubview(lineView)
        courtMinPrice.text = "Rp. " + courtDetails.sportMinPrice
        courtStatus.text = courtDetails.sportCenterStatus
        if(courtDetails.sportCenterStatus == "Open"){
            courtStatus.textColor = UIColor(red: 0, green: 0.77, blue: 0.55, alpha: 1)
        }else{
            courtStatus.textColor = UIColor(red: 0.98, green: 0.48, blue: 0.42, alpha: 1)
        }
        generateAddress()
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(Double(courtDetails.sportCenterLat)!), longitude: CLLocationDegrees(Double(courtDetails.sportCenterLong)!))
        courtMap.addAnnotation(annotation)
    }
    
    func generateAddress(){
        courtOpenTime.text = courtDetails.sportCenterOpenTime + " - " + courtDetails.sportCenterCloseTime
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
        let lineView = UIView(frame: CGRect(x: 16, y: addressView.frame.maxY+15, width: self.view.frame.size.width-32, height: 1.0))
        lineView.layer.borderWidth = 1.0
        lineView.layer.borderColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1).cgColor
        self.view.addSubview(lineView)
    }
    
    func setupSlideScrollView(images : [ImageSlide]) {
        imageCarousel.frame = CGRect(x: 0, y: 0, width: imageCarousel.frame.width, height: imageCarousel.frame.height)
        imageCarousel.contentSize = CGSize(width: imageCarousel.frame.width * CGFloat(images.count), height: imageCarousel.frame.height)
        imageCarousel.isPagingEnabled = true
        
        for i in 0 ..< images.count {
            images[i].frame = CGRect(x: imageCarousel.frame.width * CGFloat(i), y: 0, width: imageCarousel.frame.width, height: imageCarousel.frame.height)
            imageCarousel.addSubview(images[i])
        }
    }
    
    func setGradientBackground() {
        var gradient: CAGradientLayer!
        gradient = CAGradientLayer()
        gradient.frame = gradientBar.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0, 0, 0, 1]
        gradientBar.layer.mask = gradient
    }
    
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

extension CourtDetailsViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        imagePageController.currentPage = Int(pageIndex)
        
    }
}
