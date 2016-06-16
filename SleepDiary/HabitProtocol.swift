//
//  HabitProtocol.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/15/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import Foundation

protocol HabitProtocol {
    var defaultHabits: [Habit] { get }
    func getHabitStrings(habits: [Habit]) -> [String]
    func getHabitsFromStrings(strings: [String]) -> [Habit]
}

extension HabitProtocol {
    var defaultHabits: [Habit] {
        return [.DrankTea("🍵"),.BathOrShower("🛁"),.ReadBook("📚"),.Massage("🎾"),.NoScreens("📱")]
    }
    
    func getHabitStrings(habits: [Habit]) -> [String] {
        var strings: [String] = []
        for habit in habits {
            switch habit {
            case let .DrankTea(string):
                strings += [string]
            case let .ReadBook(string):
                strings += [string]
            case let .BathOrShower(string):
                strings += [string]
            case let .Massage(string):
                strings += [string]
            case let .NoScreens(string):
                strings += [string]
            }
        }
        return strings
    }
    
    func getHabitsFromStrings(strings: [String]) -> [Habit] {
        var newHabits: [Habit] = []
        
        for habit in defaultHabits {
            switch habit {
            case .DrankTea:
                guard let habit = try? Habit(index: 1, string: strings[0]) else { return newHabits }
                newHabits += [habit]
            case .ReadBook:
                guard let habit = try? Habit(index: 2, string: strings[1]) else { return newHabits }
                newHabits += [habit]
            case .BathOrShower:
                guard let habit = try? Habit(index: 3, string: strings[2]) else { return newHabits }
                newHabits += [habit]
            case .Massage:
                guard let habit = try? Habit(index: 4, string: strings[3]) else { return newHabits }
                newHabits += [habit]
            case .NoScreens:
                guard let habit = try? Habit(index: 5, string: strings[4]) else { return newHabits }
                newHabits += [habit]
            }
        }
        return newHabits
    }
}
