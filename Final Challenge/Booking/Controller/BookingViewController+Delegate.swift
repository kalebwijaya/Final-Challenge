//
//  BookingViewController+Delegate.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 27/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

extension BookingViewController: BookingViewControllerDelegate {
    func getScheduleTime(scheduleTime: [ScheduleTime]) {
        countPricePerCourt(startTime: scheduleTime.first!.startTime, endTime: scheduleTime.first!.endTime, courtPrices: scheduleTime.first!.courtPrices, index: scheduleTime.first!.index)
    }
    
    func countPricePerCourt(startTime:String, endTime:String, courtPrices:[Int], index:Int){
        var totalPriceCourt = 0
        
        for price in courtPrices{
            totalPriceCourt += price
        }
        
        self.totalPricePerCourt[index] = totalPriceCourt
        
        self.bookParamDetail[index] = BookParamDetail(courtID: bookingCourt!.sportCenterDetail[index].courtID, bookStartTime: startTime, bookEndTime: endTime)
        self.totalPrice = 0
        for n in 0 ..< bookingCourt!.sportCenterDetail.count {
            self.totalPrice += self.totalPricePerCourt[n] ?? 0
        }
        
        self.totalPriceLabel.text = "Rp. " + currencyFormatter.string(from: NSNumber(value: self.totalPrice))!
    }
}

