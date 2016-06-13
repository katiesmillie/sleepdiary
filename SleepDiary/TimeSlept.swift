//
//  TimeSlept.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/13/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import Foundation

public let minutesInHour = 60

public struct TimeSlept {
    
    let totalMinutes: Int
    
    init(totalMinutes: Int) {
        self.totalMinutes = totalMinutes
    }
    
    var hours: Int {
        return totalMinutes / minutesInHour
    }
    
    var minutesRemaning: Int {
        return totalMinutes % minutesInHour
    }
    
}
