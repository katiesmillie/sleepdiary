//
//  Habits.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/13/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import Foundation

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