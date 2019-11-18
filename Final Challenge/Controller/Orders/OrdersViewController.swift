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
    let url = URL(string: "http://10.60.40.42:3000/history")
    
    let cellIdentifier = "OrdersCollectionViewCell"
    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        collectionViewSetup()
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

extension OrdersViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionViewSetup(){
        orderCollectionView.delegate = self
        orderCollectionView.dataSource = self
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        orderCollectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func setupCollectionViewCell(){
        if collectionViewFlowLayout == nil{
            let numberOfItemRow:CGFloat = 1
            let lineSpacing:CGFloat = 20
            let interItemSpacing:CGFloat = 20
            
            let width = (orderCollectionView.frame.width - (numberOfItemRow - 1) * interItemSpacing) / numberOfItemRow
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            
            collectionViewFlowLayout.itemSize = CGSize(width: width - 40, height: 125)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            
            orderCollectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        history.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! OrdersCollectionViewCell
        
        cell.courtName.text = history[indexPath.row].sportCenterName
        cell.dateOrder.text = history[indexPath.row].bookDate
        cell.totalPrice.text = "Rp. " + history[indexPath.row].totalPayment
        cell.orderStatus.text = history[indexPath.row].statusTypeName
        if(cell.orderStatus.text == "Waiting List"){
            cell.orderStatus.textColor = UIColor(red: 1, green: 0.73, blue: 0.39, alpha: 1)
        }else if(cell.orderStatus.text == "Done"){
            cell.orderStatus.textColor = UIColor(red: 0, green: 0.77, blue: 0.55, alpha: 1)
        }else{
            cell.orderStatus.textColor = UIColor(red: 0.98, green: 0.48, blue: 0.42, alpha: 1)
        }
        
        if let imageURL = URL(string: history[indexPath.row].sportCenterImageURL){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.courtImage.image = image
                    }
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toBookingDetails", sender: self)
    }
    
}
