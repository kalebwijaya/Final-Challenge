//
//  OrdersViewController.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 15/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

class OrdersViewController: UIViewController {
    
    @IBOutlet weak var orderCollectionView: UICollectionView!
    
    var history = [History]()
    let orderModel = OrderModel()
    let url = URL(string: "http://10.60.50.34:3000/history")
    
    let cellIdentifier = "OrdersCollectionViewCell"
    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        collectionViewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupCollectionViewCell()
    }
    
    func getData(){
        guard let jsonUrl = url else {return}
        URLSession.shared.dataTask(with: jsonUrl) {(data,response, error) in
            guard let data = data, error == nil, response != nil else {
                print("URL Error")
                return
            }
            do {
                let result = try JSONDecoder().decode(HistoryResult.self, from: data)
                if(result.errorCode == "200"){
                    self.history = result.data
                    print("JSON Get")
                    DispatchQueue.main.async {
                        self.orderCollectionView.reloadData()
                    }
                }else if(result.errorCode == "400"){
                    print(result.errorMessage)
                }
            } catch {
                print("Error After Getting JSON")
            }
        }.resume()
    }
}
