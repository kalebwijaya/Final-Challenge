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
    let url = "\(BaseURL.baseURL)api/book/list/"
    
    let cellIdentifier = "OrdersCollectionViewCell"
    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sudahLogin = UserDefaults.standard.bool(forKey: "sudahLogin")
        if sudahLogin == false
        {
            let storyBoard = UIStoryboard(name: "Login", bundle: nil)
            
            let vc = storyBoard.instantiateViewController(identifier: "login") as! LoginViewController
            let navController = UINavigationController(rootViewController: vc)
            
            self.navigationController?.present(navController, animated: true, completion: nil)
        }
        else{
        getData()
        collectionViewSetup()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
       let sudahLogin = UserDefaults.standard.bool(forKey: "sudahLogin")
        if sudahLogin == false
        {
            let storyBoard = UIStoryboard(name: "Login", bundle: nil)
            
            let vc = storyBoard.instantiateViewController(identifier: "login") as! LoginViewController
            let navController = UINavigationController(rootViewController: vc)
            
            self.navigationController?.present(navController, animated: true, completion: nil)
        }
            
        else
        {
        getData()
        collectionViewSetup()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupCollectionViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBookingDetails" {
            let sendData = sender as? History
            let vc = segue.destination as? OrderDetailsViewController
            vc?.bookID = sendData!.bookID
            vc?.sportCenterImageURL = sendData!.sportCenterImageURL
            print(sendData!.bookID)
        }
    }
    
    func getData(){
        let userID = UserDefaults.standard.string(forKey: "id")
        guard let jsonUrl = URL(string: url+userID!) else {return}
        
        orderModel.sendOrderRequest(url: jsonUrl){ (result, error) in
            if let result = result{
                if(result.errorCode == "200"){
                    self.history = result.data
                    DispatchQueue.main.async {
                        self.orderCollectionView.reloadData()
                    }
                }else if(result.errorCode == "400"){
                    print(result.errorMessage)
                }
            }else if let error = error {
                print(error)
            }
        }
    }
}
