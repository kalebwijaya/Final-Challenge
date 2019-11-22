//
//  CourtTableViewCell.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 22/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

class CourtTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countentView: UIView!
    @IBOutlet weak var courtName: UILabel!
    @IBOutlet weak var courtDayPrice: UILabel!
    @IBOutlet weak var courtNightPrice: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var courtDetails: UILabel!
    
    var courts = [BookingCourtDetails]()
    let cellIdentifier = "TimeViewCell"
    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewSetup()
    }
    
    override func layoutSubviews() {
        setupCollectionViewCell()
    }
    
    
}

extension CourtTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionViewSetup(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func setupCollectionViewCell(){
        if collectionViewFlowLayout == nil{
            let numberOfItemRow:CGFloat = 4
            let lineSpacing:CGFloat = 13
            let interItemSpacing:CGFloat = 13
            
            let width = (collectionView.frame.width - (numberOfItemRow - 1) * interItemSpacing) / numberOfItemRow
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            
            collectionViewFlowLayout.itemSize = CGSize(width: width - 26, height: 32)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 13, left: 0, bottom: 0, right: 0)
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! TimeViewCell
        
        return cell
    }
    
}
