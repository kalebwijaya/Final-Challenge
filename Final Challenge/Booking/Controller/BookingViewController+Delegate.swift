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
        countPricePerCourt(startTime: scheduleTime.first!.startTime, endTime: scheduleTime.first!.endTime, index: scheduleTime.first!.index)
    }
    
    func countPricePerCourt(startTime:String, endTime:String, index:Int){
        var totalPriceCourt = 0
        let start = Int(startTime.prefix(2))!
        let end = Int(endTime.prefix(2))!
        let nightTime = Int(bookingCourt!.sportCenterNightTime.prefix(2))!
        if(start > nightTime && end > nightTime){
            totalPriceCourt = (abs(start-end)) * Int(bookingCourt!.sportCenterDetail[index].courtPriceNight)!
        }else{
            totalPriceCourt = (abs(start-end)) * Int(bookingCourt!.sportCenterDetail[index].courtPriceDay)!
        }
        self.totalPricePerCourt[index] = totalPriceCourt
        self.bookParamDetail[index] = BookParamDetail(courtID: bookingCourt!.sportCenterDetail[index].courtID, bookStartTime: startTime, bookEndTime: endTime)
        self.totalPrice = 0
        for n in 0 ..< bookingCourt!.sportCenterDetail.count {
            self.totalPrice += self.totalPricePerCourt[n] ?? 0
        }
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.groupingSeparator = "."
        currencyFormatter.numberStyle = .decimal
        currencyFormatter.locale = Locale(identifier: "id_ID")
        self.totalPriceLabel.text = "Rp. " + currencyFormatter.string(from: NSNumber(value: self.totalPrice))!
    }
}
