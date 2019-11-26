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
    
    var courtId:String = ""
    var totalTime:[String] = []
    let cellIdentifier = "TimeViewCell"
    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    var firstTap:Bool = true
    var starIndex:Int = 0
    var endIndex:Int = 0
    var startTime = ""
    var endTime = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewSetup()
    }
    
    override func layoutSubviews() {
        setupCollectionViewCell()
    }
    
    func getTotalTime(totalTime:Int, startTime:String){
        var time = Int(startTime.prefix(2))!
        for _ in 0 ..< totalTime {
            let timeString = "\(time)".count == 1 ? ("0" + "\(time)") : "\(time)" + ":00"
            self.totalTime.append(timeString)
            time += 1
        }
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
        return totalTime.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! TimeViewCell
        cell.timeString = totalTime[indexPath.row]
        cell.time.text = totalTime[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(firstTap){
            let cell = collectionView.cellForItem(at: indexPath)
            starIndex = indexPath.row
            cell?.backgroundColor = #colorLiteral(red: 1, green: 0.778283298, blue: 0.4615219235, alpha: 1)
            firstTap = false
        }else{
            endIndex = indexPath.row
            for n in starIndex ... endIndex {
                let cell = collectionView.cellForItem(at: IndexPath(row: n, section: indexPath.section) )
                cell?.backgroundColor = #colorLiteral(red: 1, green: 0.778283298, blue: 0.4615219235, alpha: 1)
            }
            firstTap = true
        }
    }
    
}

