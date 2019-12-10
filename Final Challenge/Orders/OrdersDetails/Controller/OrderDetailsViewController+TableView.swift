//
//  OrderDetailsViewController+TableView.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 10/12/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

extension OrderDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalCourtBooked
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.courtName.text = orderDetails.courtData[indexPath.row].courtName
        let price = orderDetails.courtData[indexPath.row].courtPrice
        let priceFormat = currencyFormatter.string(from: NSNumber(value: Int(price)!))!
        cell.courtPrice.text = "Rp. " + priceFormat
        cell.courtDetails.text = "\(calculationCourtTime(index: indexPath.row)) hour(s) @ \(priceFormat)"
        
        totalPriceInt += Int(price)!
        
        return cell
    }
    
    
}
