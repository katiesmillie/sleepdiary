//
//  Mood.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/13/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import Foundation

//TODO: Update Mood to match Habit enum pattern with associated values

public enum Mood {
    
    // Experimenting with nested Enums
    // I like associating MoodType and MoodRating
    // but it doesn't totally seem necessary here
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
