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
    
    @IBOutlet weak var sportCenterImage: UIImageView!
    @IBOutlet weak var sportCenterName: UILabel!
    @IBOutlet weak var bookDate: UILabel!
    @IBOutlet weak var bookCode: UILabel!
    @IBOutlet weak var totalCourt: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var totalPriceView: UIView!
    @IBOutlet weak var firstCourt: UILabel!
    @IBOutlet weak var firstCourtTotalPrice: UILabel!
    @IBOutlet weak var firstCourtPrice: UILabel!
    
    var orderDetails:OrderDetails!
    let url = URL(string: "http://10.60.40.42:3000/bookingDetails")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
        guard let jsonUrl = url else {return}
        URLSession.shared.dataTask(with: jsonUrl) {(data,response, error) in
            guard let data = data, error == nil, response != nil else {
                print("URL Error")
                return
            }
            do {
                let result = try JSONDecoder().decode(OrderDetailsResult.self, from: data)
                if(result.errorCode == "200"){
                    self.orderDetails = result.data
                    self.setData()
                    print("JSON Get")
                }else if(result.errorCode == "400"){
                    print(result.errorMessage)
                }
            } catch {
                print("Error After Getting JSON")
            }
        }.resume()
    }
    
    func setData(){
        DispatchQueue.main.async {
            let hours = self.calculationCourtTime(index: 0)
            var courtTotalPrice:Int = 0
            var totalPrice:Int = 0
            let currencyFormatter = NumberFormatter()
            currencyFormatter.usesGroupingSeparator = true
            currencyFormatter.groupingSeparator = "."
            currencyFormatter.numberStyle = .decimal
            currencyFormatter.locale = Locale(identifier: "id_ID")
            
            self.sportCenterName.text = self.orderDetails.sportCenterName
            self.bookDate.text = self.orderDetails.bookDate
            self.bookCode.text = "Kode Booking : " + self.orderDetails.bookCode
            self.totalCourt.text = "Jumlah Lapangan : " + self.orderDetails.totalCourt
            
            self.firstCourt.text = self.orderDetails.courtData[0].courtName
            self.firstCourtPrice.text = "\(hours) hour(s) @ Rp." + self.orderDetails.courtData[0].courtPrice
            let courtPrice = self.orderDetails.courtData[0].courtPrice.replacingOccurrences(of: ".", with: "")
            courtTotalPrice = Int(courtPrice)! * hours
            self.firstCourtTotalPrice.text = "Rp. " + currencyFormatter.string(from: NSNumber(value: courtTotalPrice))!
            totalPrice += courtTotalPrice
            
            if(self.orderDetails.courtData.count > 1){
                for index in 1 ..< self.orderDetails.courtData.count {
                    totalPrice += self.moreThanOneCourt(index: index)
                }
            }
            
            self.totalPrice.text = "Rp. " + currencyFormatter.string(from: NSNumber(value: totalPrice))!
        }
        
        if let imageURL = URL(string: orderDetails.sportCenterImageURL){
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
    
    func moreThanOneCourt(index:Int) -> Int{
        let frameY = index > 1 ? (Int(firstCourt.frame.origin.x) + 252 + (40*index)) : Int(firstCourt.frame.maxY) + 23
        orderView.frame = CGRect(x: 20, y:108, width: 374, height: Int(orderView.frame.height)+(32))
        totalPriceView.frame = CGRect(x: 0, y: Int(totalPriceView.frame.maxY)-17, width: 374, height: 56)
        
        let courtName = UILabel()
        courtName.frame = CGRect(x: 16, y: frameY, width: 172, height: 18)
        courtName.textColor = .black
        courtName.text = orderDetails.courtData[index].courtName
        courtName.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        courtName.sizeToFit()
        orderView.addSubview(courtName)
        
        let hours = self.calculationCourtTime(index: index)
        let courtPrice = UILabel()
        courtPrice.frame = CGRect(x: 16, y: frameY+20, width: 96, height: 13)
        courtPrice.textColor = .black
        courtPrice.text = "\(hours) hour(s) @ Rp." + self.orderDetails.courtData[index].courtPrice
        courtPrice.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        courtPrice.sizeToFit()
        orderView.addSubview(courtPrice)
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.groupingSeparator = "."
        currencyFormatter.numberStyle = .decimal
        currencyFormatter.locale = Locale(identifier: "id_ID")
        let courtTotalPrice = UILabel()
        courtTotalPrice.frame = CGRect(x: 277, y: frameY, width: 83, height: 20)
        courtTotalPrice.textColor = .black
        let courtTotalString = self.orderDetails.courtData[index].courtPrice.replacingOccurrences(of: ".", with: "")
        let courtTotalPriceInt = Int(courtTotalString)! * hours
        courtTotalPrice.text = "Rp. " + currencyFormatter.string(from: NSNumber(value: courtTotalPriceInt))!
        courtTotalPrice.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        courtTotalPrice.sizeToFit()
        orderView.addSubview(courtTotalPrice)
        
        return courtTotalPriceInt
    }

}
