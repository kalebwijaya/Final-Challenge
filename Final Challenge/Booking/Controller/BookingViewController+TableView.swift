//
//  BookingViewController+TableView.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 27/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

extension BookingViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let totalCourt = bookingCourt?.sportCenterDetail.count else {
            return 0
        }
        return totalCourt
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CourtTableViewCell
        cell.courtName.text = bookingCourt!.sportCenterDetail[indexPath.row].courtName
        cell.courtDayPrice.text = "Day Price Rp. "+bookingCourt!.sportCenterDetail[indexPath.row].courtPriceDay
        cell.courtNightPrice.text = "Night Price Rp. "+bookingCourt!.sportCenterDetail[indexPath.row].courtPriceNight
        cell.courtId = bookingCourt!.sportCenterDetail[indexPath.row].courtID
        cell.courtDetails.text = "Day Time : " + bookingCourt!.sportCenterOpenTime + " - " + bookingCourt!.sportCenterNightTime + "  Night Time : " + bookingCourt!.sportCenterNightTime + " - " + bookingCourt!.sportCenterClosedTime
        cell.index = indexPath.row
        cell.delegate = self
        self.tableCellHeight = cell.getTotalTime(totalTime: calcTotalTime(), startTime: bookingCourt!.sportCenterOpenTime, unavailableTime: bookingCourt!.sportCenterDetail[indexPath.row].courtUnavailableTime)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(tableCellHeight)
    }
    
}
