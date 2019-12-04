//
//  CourtSearchBarDelegate.swift
//  Final Challenge
//
//  Created by Steven on 12/4/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation
import UIKit

extension CourtSearchViewController: UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        courtSearchData.removeAll()
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        courtSearchData.removeAll()
        self.tableView.reloadData()
        self.searchText = searchText
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(CourtSearchViewController.fetchData),object: nil)
        self.perform(#selector(CourtSearchViewController.fetchData),with: nil, afterDelay: 0.8)
    }
    
    @objc func fetchData(){
        getUserLocation()
        
    }
}
