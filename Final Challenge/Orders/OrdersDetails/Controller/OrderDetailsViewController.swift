//
//  OrderDetailsViewController.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 18/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
// 

import UIKit

class OrderDetailsViewController: UIViewController {
    
    @IBOutlet weak var orderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sportCenterImage: UIImageView!
    @IBOutlet weak var sportCenterName: UILabel!
    @IBOutlet weak var bookDate: UILabel!
    @IBOutlet weak var bookCode: UILabel!
    @IBOutlet weak var totalCourt: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var totalPriceView: UIView!
    @IBOutlet weak var statusImage: UIImageView!
    
    let currencyFormatter = NumberFormatter()
    var orderDetails:OrderDetailsData!
    let url = "\(BaseURL.baseURL)api/book/detail/"
    var bookID = ""
    var sportCenterImageURL = ""
    let orderDetailsModel = OrderDetailsModel()
    var totalPriceInt:Int = 0
    var totalCourtBooked = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.groupingSeparator = "."
        currencyFormatter.numberStyle = .decimal
        currencyFormatter.locale = Locale(identifier: "id_ID")
        
        setupView()
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    func setupView(){
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.totalPriceView.frame
        rectShape.position = self.totalPriceView.center
        rectShape.path = UIBezierPath(roundedRect: self.totalPriceView.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 8, height: 8)).cgPath
        totalPriceView.layer.mask = rectShape
        
        orderView.backgroundColor = .white
        orderView.layer.cornerRadius = 8
        orderView.layer.shadowOffset = CGSize(width: 0, height: 3)
        orderView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        orderView.layer.shadowOpacity = 1
        orderView.layer.shadowRadius = 10
    }
    
    func getData(){
        guard let jsonUrl = URL(string: url+bookID) else {return}
        
        orderDetailsModel.sendOrderRequest(url: jsonUrl){
            (result, error) in
            if let result = result{
                if(result.errorCode == "200"){
                    self.orderDetails = result.data
                    self.setData()
                }else if(result.errorCode == "400"){
                    print(result.errorMessage)
                }
            }else if let error = error {
                print(error)
            }
        }
    }
    
    func setData(){
        DispatchQueue.main.async {
            self.totalCourtBooked = self.orderDetails.courtData.count
            self.sportCenterName.text = self.orderDetails.sportCenterName
            self.bookDate.text = self.orderDetails.bookDate
            self.bookCode.text = "Kode Booking : " + self.orderDetails.bookCode
            self.totalCourt.text = "Jumlah Lapangan : " + self.orderDetails.totalCourt
            
            self.tableView.reloadData()
            
            self.totalPrice.text = "Rp. " + self.currencyFormatter.string(from: NSNumber(value: self.totalPriceInt))!
            
            if(self.orderDetails.bookStatus == "Waiting List"){
                self.statusImage.image = #imageLiteral(resourceName: "waitingStamp")
            }else if(self.orderDetails.bookStatus == "Done" || self.orderDetails.bookStatus == "Confirmed"){
                self.statusImage.image = #imageLiteral(resourceName: "bookedStamp")
            }else{
                self.statusImage.image = #imageLiteral(resourceName: "calncelledStamp")
            }
        }
        
        if let imageURL = URL(string: sportCenterImageURL){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.sportCenterImage.image = image
                    }
                }
            }
        }
        
    }
    
    func calculationCourtTime(index:Int) -> Int{
        let startTime = orderDetails.courtData[index].bookStartTime.prefix(2)
        let endTime = orderDetails.courtData[index].bookEndTime.prefix(2)
        let hours = Int(endTime)! - Int(startTime)!
        return Int(hours)
    }

}
