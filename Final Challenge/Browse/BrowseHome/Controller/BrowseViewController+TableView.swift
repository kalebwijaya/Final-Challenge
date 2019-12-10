//
//  BrowseViewController+TableView.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 29/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

extension BrowseViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return browseData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "browseCell") as! BrowseTableViewCell
        cell.sportTypeLbl.text = browseData[indexPath.row].sportTypeName
        self.browseModel.getImage(imageURL: browseData[indexPath.row].sportTypeImage) { (data) in
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                cell.sportImage.image = image
            }
        }
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let getID = browseData[indexPath.row].sportTypeID
        let storyboard = UIStoryboard(name: "CourtList", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "courtList") as! CourtListViewController
        vc.getSportTypeID = getID
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

extension BrowseViewController: UITableViewDelegate{
    
}

