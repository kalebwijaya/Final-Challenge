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
    var index = 0
    var collectionViewHeight:Int = 0
    var unavailableTime:[String] = []
    
    var delegate: BookingViewControllerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewSetup()
    }
    
    override func layoutSubviews() {
        setupCollectionViewCell()
    }
    
    func getTotalTime(totalTime:Int, startTime:String, unavailableTime:[String]) -> Int{
        var time = Int(startTime.prefix(2))!
        for _ in 0 ... totalTime {
            let timeString = "\(time)".count == 1 ? ("0" + "\(time)"+":00") : "\(time)" + ":00"
            self.totalTime.append(timeString)
            time += 1
        }
        let totalLine = ceil(Double(totalTime) / 4)
        collectionViewHeight = Int(totalLine * 42)
        collectionView.frame = CGRect(x: 32, y: 93, width: 362, height: collectionViewHeight)
        frame = CGRect(x: 0, y: 0, width: 414, height: 109 + collectionViewHeight)
        self.unavailableTime = unavailableTime
        collectionView.reloadData()
        return 109 + collectionViewHeight
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
            let numberOfItemRow:CGFloat = 3.5
            let lineSpacing:CGFloat = 10
            let interItemSpacing:CGFloat = 10
            
            let width = (collectionView.frame.width - (numberOfItemRow-1) * interItemSpacing) / numberOfItemRow
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            
            collectionViewFlowLayout.itemSize = CGSize(width: width - 20, height: 32)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
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
        for n in 0 ..< unavailableTime.count{
            if(totalTime[indexPath.row] == unavailableTime[n]){
                cell.isUserInteractionEnabled = false
                cell.backgroundColor = #colorLiteral(red: 0.585175693, green: 0.5851898789, blue: 0.5851822495, alpha: 1)
                break
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(firstTap){
            for n in 0 ..< totalTime.count {
                let cell = collectionView.cellForItem(at: IndexPath(row: n, section: indexPath.section) )
                cell?.backgroundColor = .clear
            }
            let cell = collectionView.cellForItem(at: indexPath)
            starIndex = indexPath.row
            cell?.backgroundColor = #colorLiteral(red: 1, green: 0.778283298, blue: 0.4615219235, alpha: 1)
            startTime = totalTime[starIndex]
            firstTap = false
        }else{
            endIndex = indexPath.row
            if(endIndex > starIndex){
                for n in starIndex ... endIndex {
                    let cell = collectionView.cellForItem(at: IndexPath(row: n, section: indexPath.section) )
                    cell?.backgroundColor = #colorLiteral(red: 1, green: 0.778283298, blue: 0.4615219235, alpha: 1)
                }
            }else{
                for n in endIndex ... starIndex {
                    let cell = collectionView.cellForItem(at: IndexPath(row: n, section: indexPath.section) )
                    cell?.backgroundColor = #colorLiteral(red: 1, green: 0.778283298, blue: 0.4615219235, alpha: 1)
                }
            }
            endTime = totalTime[endIndex]
            firstTap = true
            delegate?.getScheduleTime(scheduleTime: [ScheduleTime(startTime: startTime, endTime: endTime, index : self.index)])
        }
    }
    
    
    
}

