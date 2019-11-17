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
    
    var orderDetails:OrderDetails!
    let url = URL(string: "http://localhost:3000/bookingDetails")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getData()
    }
    
    func setupView(){
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
                self.orderDetails = result.data
                print("JSON Get")
                self.setData()
            } catch {
                print("Error After Getting JSON")
            }
        }.resume()
    }
    
    func setData(){
        DispatchQueue.main.async {
            self.sportCenterName.text = self.orderDetails.sportCenterName
            self.bookDate.text = self.orderDetails.bookDate
            self.bookCode.text = "Kode Booking : " + self.orderDetails.bookCode
            self.totalCourt.text = "Jumlah Lapangan : " + self.orderDetails.totalCourt
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

}
