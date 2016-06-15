//
//  Habits.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/13/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import Foundation

public enum Habit {
    
    case DrankTea(String)
    case BathOrShower(String)
    case ReadBook(String)
    case Massage(String)
    case NoScreens(String)
    
    public init(index: Int, string: String) throws {
        switch index {
        case 1:     self = .DrankTea(string)
        case 2:     self = .BathOrShower(string)
        case 3:     self = .ReadBook(string)
        case 4:     self = .Massage(string)
        case 5:     self = .NoScreens(string)
        default:
            let info = [NSLocalizedDescriptionKey : "Unknown index: \(index)"]
            throw NSError(domain: #file, code: #line, userInfo: info)
        }
    }
    
    public func rawValue() -> Int {
        switch self {
        case DrankTea: return 1
        case BathOrShower: return 2
        case ReadBook: return 3
        case Massage: return 4
        case NoScreens: return 5
        }
    }
    
    
}