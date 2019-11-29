//
//  CourtListViewController+TableView.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 29/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

extension CourtListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let address = addressName else { return "" }
        return address
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textAlignment = NSTextAlignment.left
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getCourtData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courtListCell") as! CourtListTableViewCell
        
        let textChangeColor: NSAttributedString = "From Rp. \( currencyFormatter.string(from: NSNumber(value: Int(getCourtData[indexPath.row].sportMinPrice)!))! )".attributedStringWithColor(["From"], color: UIColor.black)
        
        cell.sportCenterName.text = getCourtData[indexPath.row].sportCenterName
        
        cell.sportCenterStartPrice.attributedText = textChangeColor
        
        //count distance from user location to sport center

        guard let getLongitude = Double(getCourtData[indexPath.row].sportCenterLong) , let getLatitude = Double(getCourtData[indexPath.row].sportCenterLat) else {
            return cell
        }
        
        self.courtListModel.fetchImage(imageURL: getCourtData[indexPath.row].sportCenterImageURL) { (data) in
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                cell.sportCenterImage.image = image
            }
        }
        
        cell.sportCenterDistance.text = "\(String(format: "%.2f", getCourtData[indexPath.row].sportCenterDistance)) km Away"
        
        cell.sportCenterImage.image = UIImage(named: "court_category")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let getLongitude = Double(getCourtData[indexPath.row].sportCenterLong) , let getLatitude = Double(getCourtData[indexPath.row].sportCenterLat) else {
            return
        }
        
        let getSportCenterID = getCourtData[indexPath.row].sportCenterID
        let getDistance = "\(String(format: "%.2f", getCourtData[indexPath.row].sportCenterDistance)) km Away"
        
        let storyboard = UIStoryboard(name: "BookingCourtDetails", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "courtDetails") as! CourtDetailsViewController
        
        guard let sportTypeID = self.sportTypeID else{
            return
        }
        vc.getSportTypeID = sportTypeID
        vc.getSportCenterID = "\(getCourtData[indexPath.row].sportCenterID)"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        
        //set value
    }
    
    
}
