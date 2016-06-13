//
//  DiaryEntry.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/9/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import Foundation


public struct DiaryEntry {
    let timeSlept: TimeSlept?
    let bedtimeMood: Mood.MoodRating?
    let wakeUpMood: Mood.MoodRating?
    let habits: [Habit]?
    let notes: String?
    
    let date: NSDate?
    
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

public enum Mood {
    
    // Experimenting with nested Enums
    // I like associating MoodType and MoodRating, but it doesn't totally seem necessary here
    public enum MoodRating {
    public enum MoodRating: Int {
        case Anxious
        case Cranky
        case Relaxed
        case Happy
        case Energetic
        
        public func string() -> String {
            switch self {
            case Anxious: return "😖"
            case Cranky: return "🙄"
            case Relaxed: return "😴"
            case Happy: return "☺️"
            case Energetic: return "😝"
            }
        }
    }
    
    public enum MoodType {
        case Bedtime
        case WakeUp
    }
    
}

public enum Habit: Int {
    case DrankTea
    case BathOrShower
    case ReadBook
    case Massage
    case NoScreens
    
    public func string() -> String {
        switch self {
        case DrankTea: return "🍵"
        case BathOrShower: return "🛁"
        case ReadBook: return "📚"
        case Massage: return "🎾"
        case NoScreens: return "🚫📱"
        }
    }

}