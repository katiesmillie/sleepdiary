//
//  HabitsTableViewCell.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/9/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

protocol Habits {
    var habits: [Habit] { get }
}

class HabitsTableViewCell: UITableViewCell, Habits {
    
    @IBOutlet weak var firstButton: DiaryButton?
    @IBOutlet weak var secondButton: DiaryButton?
    @IBOutlet weak var thirdButton: DiaryButton?
    @IBOutlet weak var fourthButton: DiaryButton?
    @IBOutlet weak var fifthButton: DiaryButton?
    @IBOutlet weak var headerLabel: UILabel?
    
    var diaryViewModel: DiaryViewModel?
    
    var habits: [Habit] {
        return [.DrankTea, .BathOrShower, .ReadBook, .Massage, .NoScreens]
    }
    
    class func cell(tableView: UITableView) -> HabitsTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HabitsTableViewCell") as! HabitsTableViewCell
        return cell
    }
    
    func configure(diaryViewModel: DiaryViewModel) {
        self.diaryViewModel = diaryViewModel
        headerLabel?.text = "Bedtime Habits"
        
        // ???: Create a tighter coupling between buttons and habits
        for habit in habits {
            switch habit {
            case .DrankTea:
                firstButton?.setTitle(habit.string(), forState: UIControlState.Normal)
            case .BathOrShower:
                secondButton?.setTitle(habit.string(), forState: UIControlState.Normal)
            case .ReadBook:
                thirdButton?.setTitle(habit.string(), forState: UIControlState.Normal)
            case .Massage:
                fourthButton?.setTitle(habit.string(), forState: UIControlState.Normal)
            case .NoScreens:
                fifthButton?.setTitle(habit.string(), forState: UIControlState.Normal)
            }
        }
    }
    
    @IBAction func buttonWasTapped(sender: DiaryButton) {
        // Every time a button is tapped, find all buttons that are selected
        // Get the Habit, then update the view model
        let buttons: [DiaryButton?] = [firstButton, secondButton, thirdButton, fourthButton, fifthButton]
        
        var selectedHabits: [Habit] = []
        for button in buttons {
            guard let button = button else { return }
            if button.selected {
                guard let habit = getHabitFromButton(button) else { return }
                selectedHabits += [habit]
            }
        }
        diaryViewModel?.updateHabits(selectedHabits)
    }
    
    func getHabitFromButton(button: DiaryButton) -> Habit? {
        for habit in habits {
            switch habit {
            case .DrankTea:
                if button.titleLabel?.text == habit.string() {
                    return .DrankTea
                }
            case .BathOrShower:
                if button.titleLabel?.text == habit.string() {
                    return .BathOrShower
                }
            case .ReadBook:
                if button.titleLabel?.text == habit.string() {
                    return .ReadBook
                }
            case .Massage:
                if button.titleLabel?.text == habit.string() {
                    return .Massage
                }
            case .NoScreens:
                if button.titleLabel?.text == habit.string() {
                    return .NoScreens
                }
            }
        }
        return nil
    }
    
}
