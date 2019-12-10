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
        guard let address = addressName else { return ""
        }
        return address
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let address = addressName else { return
        }
        
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
//        header.textLabel?.textAlignment = NSTextAlignment.center
        header.textLabel?.center.x = view.center.x
        
        let setAlignment = NSMutableParagraphStyle()
        setAlignment.alignment = .center
        
        let frontString =
            NSMutableAttributedString(string: "" , attributes: [.paragraphStyle: setAlignment])

        let backString =   NSAttributedString(string: "     \(address)",attributes: [.paragraphStyle: setAlignment])
        
        let locationAttachment = NSTextAttachment()
        locationAttachment.image = UIImage(named: "IconLocationKecil")

        let locationString = NSAttributedString(attachment: locationAttachment)


        frontString.append(locationString)
        frontString.append(backString)
        

        // draw the result in a label
        header.textLabel?.attributedText = frontString
        
//        header.textLabel?.attributedText.
        
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

        
        self.courtListModel.getImage(imageURL: getCourtData[indexPath.row].sportCenterImageURL) { (data) in
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                cell.sportCenterImage.image = image
            }
        }
        
        cell.sportCenterDistance.text = "\(String(format: "%.2f", getCourtData[indexPath.row].sportCenterDistance)) km away"
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
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
