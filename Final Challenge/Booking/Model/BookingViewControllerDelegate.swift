//
//  BookingViewControllerDelegate.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 27/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

struct ScheduleTime {
    let startTime: String
    let endTime: String
    let index : Int
}

protocol BookingViewControllerDelegate {
    func getScheduleTime(scheduleTime: [ScheduleTime])
}
