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
        var timeSlept: TimeSlept?
        var bedtimeMood: Mood.MoodRating?
        var wakeUpMood: Mood.MoodRating?
 
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

        let notes = entry.notes
        
        return DiaryEntry(date: date, timeSlept: timeSlept, bedtimeMood: bedtimeMood, wakeUpMood: wakeUpMood, habits: nil, notes: notes)
    }
    
}