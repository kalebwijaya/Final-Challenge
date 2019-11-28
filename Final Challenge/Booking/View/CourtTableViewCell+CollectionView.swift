//
//  CourtTableViewCell+CollectionView.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 28/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

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
        cell.backgroundColor = .clear
        cell.isUserInteractionEnabled = true
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
                let cell = collectionView.cellForItem(at: IndexPath(row: n, section: indexPath.section))
                if(!checkIfTimeUnavailTime(currentTime: totalTime[n])){
                    cell?.backgroundColor = .clear
                    cell?.isUserInteractionEnabled = true
                }
            }
            starIndex = indexPath.row
            // untuk index belakangnya
                outerLoopBack: for index in stride(from: starIndex, through: 0, by: -1) {
                    // ngitung mundur ke belakang
                    for unavailableIndex in 0 ..< unavailableTime.count {
                        //buat ngecheck klu cell belakang staert itu unavail atau nggak
                        if (totalTime[index] == unavailableTime[unavailableIndex]) {
                            //dissable semua cell dibelakangnya
                            for getUnavailableIndex in stride(from: index, through: 0, by: -1) {
                                print(getUnavailableIndex)
                                let cell = collectionView.cellForItem(at: IndexPath(row: getUnavailableIndex, section: indexPath.section))
                                cell?.isUserInteractionEnabled = false
                                cell?.alpha = 0.5
                            }
                            break outerLoopBack
                        }
                    }
                }
                outerLoopFront: for index in starIndex ..< totalTime.count {
                    for unavailableIndex in 0 ..< unavailableTime.count {
                        //buat ngecheck klu cell belakang staert itu unavail atau nggak
                        if (totalTime[index] == unavailableTime[unavailableIndex]) {
                            //dissable semua cell dibelakangnya
                            for getUnavailableIndex in index ..< totalTime.count {
                                print(getUnavailableIndex)
                                let cell = collectionView.cellForItem(at: IndexPath(row: getUnavailableIndex, section: indexPath.section))
                                cell?.isUserInteractionEnabled = false
                                cell?.alpha = 0.5
                            }
                            break outerLoopFront
                        }
                    }
                }
            let cell = collectionView.cellForItem(at: indexPath)
            
            cell?.backgroundColor = #colorLiteral(red: 1, green: 0.778283298, blue: 0.4615219235, alpha: 1)
            startTime = totalTime[starIndex]
            firstTap = false
            
        }else{
            for index in 0 ..< totalTime.count {
                let cell = collectionView.cellForItem(at: IndexPath(row: index, section: indexPath.section))
                for n in 0 ..< unavailableTime.count{
                    cell?.alpha = 1
                    if(totalTime[index] == unavailableTime[n]){
                        cell?.isUserInteractionEnabled = false
                        cell?.backgroundColor = #colorLiteral(red: 0.585175693, green: 0.5851898789, blue: 0.5851822495, alpha: 1)
                        break
                    }else{
                        cell?.backgroundColor = .clear
                        cell?.isUserInteractionEnabled = true
                    }
                }
            }
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
            starIndex = 0
            endIndex = 0
            
            delegate?.getScheduleTime(scheduleTime: [ScheduleTime(startTime: startTime, endTime: endTime, index : self.index)])
        }
    }
    
    
    
}
