//
//  EntriesViewModel.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/12/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import Foundation


public class DiaryEntriesViewModel {
    
    var diaryEntries: [DiaryViewModel]
    
    init(diaryEntries: [DiaryViewModel]) {
        self.diaryEntries = diaryEntries
    }
    
    func addEntries(coreDataEntries: [Entry]) {
        let entries = coreDataEntries.map { decodeEntry($0) }
        diaryEntries = entries.map { DiaryViewModel(entry: $0) }
    }
    
    private func decodeEntry(entry: Entry) -> DiaryEntry {
        
        // Feels like there is a cleaner way to do this
        // Don't love all the vars and ifs
        var timeSlept: TimeSlept?
        var bedtimeMood: Mood.MoodRating?
        var wakeUpMood: Mood.MoodRating?
        var habits: [Habit]?
 
        let date = entry.date
        if let time = entry.timeSlept {
            timeSlept = TimeSlept(totalMinutes: Int(time))
        }
        if let bedtimeRaw = entry.bedtimeMood as? Int {
            bedtimeMood = Mood.MoodRating(rawValue: bedtimeRaw)

        }
        if let wakeUpRaw = entry.wakeUpMood as? Int {
            wakeUpMood = Mood.MoodRating(rawValue: wakeUpRaw)
        }
        
        if let habitsAsInt = entry.habits as? [Int] {
            habits = habitsAsInt.flatMap{ try? Habit(index: $0, string: "") }
        }
        let notes = entry.notes
        
        return DiaryEntry(date: date, timeSlept: timeSlept, bedtimeMood: bedtimeMood, wakeUpMood: wakeUpMood, habits: habits, notes: notes)
    }
    

}