//
//  ProfileTableViewDelegate.swift
//  Final Challenge
//
//  Created by Steven on 12/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation
import UIKit

extension ProfileViewController: UITableViewDelegate{
    
}

extension ProfileViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let profileStoragedData = profileStoragedData else{
//            return 0
//        }
        
        return profileStoragedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
//        guard let profileStoragedData = profileStoragedData else {
//            return UITableViewCell()
//        }
        
        if let dataType = profileStoragedData[indexPath.row] as? (String) {
            
            let setCell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! ProfileHeaderTableViewCell
            
            setCell.userNameLbl.text = dataType
            
            cell = setCell
            
        }else if let dataType = profileStoragedData[indexPath.row] as? (key: String, value: String){
            
            let setCell = tableView.dequeueReusableCell(withIdentifier: "bodyCell") as! ProfileBodyTableViewCell
            
            setCell.bodyTitleTypeLbl.text = dataType.key
            setCell.bodyInput.text = dataType.value
            
            cell = setCell
            
        }
        
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
