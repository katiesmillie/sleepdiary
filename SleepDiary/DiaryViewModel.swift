//
//  DiaryViewModel.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/10/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import Foundation

public class DiaryViewModel {
    
    var diaryEntry: DiaryEntry
    
    init(entry: DiaryEntry) {
        self.diaryEntry = entry
    }
    
    public var date: NSDate? {
        return diaryEntry.date ?? nil
    }
    
    public var timeSlept: TimeSlept? {
        return diaryEntry.timeSlept ?? nil
    }
    
    public var bedtimeMood: Mood.MoodRating? {
        return diaryEntry.bedtimeMood ?? nil
    }
    
    public var wakeUpMood: Mood.MoodRating? {
        return diaryEntry.wakeUpMood ?? nil
    }
    
    public var habits: [Habit]? {
        return diaryEntry.habits ?? nil
    }
    
    public var notes: String? {
        return diaryEntry.notes ?? nil
    }
    
    public func updateDate(date: NSDate) {
        let newDiary = DiaryEntry(original: diaryEntry, date: date)
        diaryEntry = newDiary
    }
    
    public func updateMood(mood: Mood.MoodRating, moodType: Mood.MoodType) {
        var newDiary: DiaryEntry
        switch moodType {
        case .Bedtime:
            newDiary = DiaryEntry(original: diaryEntry, bedtimeMood: mood)
        case .WakeUp:
            newDiary = DiaryEntry(original: diaryEntry, wakeUpMood: mood)
        }
        diaryEntry = newDiary
    }
}

