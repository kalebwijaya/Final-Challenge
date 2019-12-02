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
    var courtPrices:[Int] = []
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
    var nightTime:Int = 0
    var dayTime:Int = 0
    var bookingDataDetails:BookingCourtDetails!
    
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
        self.totalTime.removeAll()
        for _ in 0 ... totalTime {
            let timeString = "\(time)".count == 1 ? ("0" + "\(time)"+":00") : "\(time)" + ":00"
            self.totalTime.append(timeString)
            time += 1
        }
        let totalLine = ceil(Double(totalTime) / 3)
        collectionViewHeight = Int(totalLine * 43)
        collectionView.frame = CGRect(x: 32, y: 93, width: 362, height: collectionViewHeight)
        frame = CGRect(x: 0, y: 0, width: 414, height: 109 + collectionViewHeight)
        self.unavailableTime = unavailableTime
        
        collectionView.reloadData()
        return 109 + collectionViewHeight
    }
    
    func checkIfTimeUnavailTime(currentTime:String) -> Bool{
        for unAvail in unavailableTime{
            if(currentTime == unAvail){
                return true
            }
        }
        return false
    }
    
}


