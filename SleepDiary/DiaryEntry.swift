//
//  DiaryEntry.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/9/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import Foundation

public struct DiaryEntry {
    
    let date: NSDate?
    let timeSlept: TimeSlept?
    let bedtimeMood: Mood.MoodRating?
    let wakeUpMood: Mood.MoodRating?
    let habits: [Habit]?
    let notes: String?
    
    public init(date: NSDate? = nil, timeSlept: TimeSlept? = nil , bedtimeMood: Mood.MoodRating? = nil, wakeUpMood: Mood.MoodRating? = nil, habits: [Habit]? = nil, notes: String? = nil) {
        self.date = date
        self.timeSlept = timeSlept
        self.bedtimeMood = bedtimeMood
        self.wakeUpMood = wakeUpMood
        self.habits = habits
        self.notes = notes
    }
    
    public init(original: DiaryEntry, date: NSDate? = nil, timeSlept: TimeSlept? = nil , bedtimeMood: Mood.MoodRating? = nil, wakeUpMood: Mood.MoodRating? = nil, habits: [Habit]? = nil, notes: String? = nil) {
        self.date = date ?? original.date
        self.timeSlept = timeSlept ?? original.timeSlept
        self.bedtimeMood = bedtimeMood ?? original.bedtimeMood
        self.wakeUpMood = wakeUpMood ?? original.wakeUpMood
        self.habits = habits ?? original.habits
        self.notes = notes ?? original.notes
    }
    
}