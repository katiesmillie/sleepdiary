//
//  HabitsTableViewCell.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/9/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

class HabitsTableViewCell: UITableViewCell, HabitProtocol {
    
    @IBOutlet weak var firstButton: DiaryButton?
    @IBOutlet weak var secondButton: DiaryButton?
    @IBOutlet weak var thirdButton: DiaryButton?
    @IBOutlet weak var fourthButton: DiaryButton?
    @IBOutlet weak var fifthButton: DiaryButton?
    @IBOutlet weak var headerLabel: UILabel?
    
    var diaryViewModel: DiaryViewModel?

    class func cell(tableView: UITableView) -> HabitsTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HabitsTableViewCell") as! HabitsTableViewCell
        return cell
    }
    
    func configure(diaryViewModel: DiaryViewModel, habits: [Habit]) {
        self.diaryViewModel = diaryViewModel
        headerLabel?.text = "Bedtime Habits"
        setButtonStrings(getHabitStrings(habits))
        setSelectedButtons()
    }
    
    private func setButtonStrings(strings: [String]) {
        // ???: Create a tighter coupling between buttons and habits
        for habit in defaultHabits {
            switch habit {
            case .DrankTea:
                firstButton?.setTitle(strings[0], forState: UIControlState.Normal)
            case .BathOrShower:
                secondButton?.setTitle(strings[1], forState: UIControlState.Normal)
            case .ReadBook:
                thirdButton?.setTitle(strings[2], forState: UIControlState.Normal)
            case .Massage:
                fourthButton?.setTitle(strings[3], forState: UIControlState.Normal)
            case .NoScreens:
                fifthButton?.setTitle(strings[4], forState: UIControlState.Normal)
            }
        }
    }
    
    private func setSelectedButtons() {
        guard let selectedHabits = diaryViewModel?.habits else { return }
        for selectedHabit in selectedHabits {
            switch selectedHabit {
            case .DrankTea: firstButton?.selected = true
            case .BathOrShower: secondButton?.selected = true
            case .ReadBook: thirdButton?.selected = true
            case .Massage: fourthButton?.selected = true
            case .NoScreens: fifthButton?.selected = true
            }
        }
    }
    
    @IBAction func buttonWasTapped(sender: DiaryButton) {
        // Every time a button is tapped, find all buttons that are selected
        // Get the associated Habit, then update the view model
        let buttons: [DiaryButton?] = [firstButton, secondButton, thirdButton, fourthButton, fifthButton]
        
        var selectedHabits: [Habit] = []
        for button in buttons {
            guard let button = button else { return }
            
            // Selected isn't get set on the currently tapped button until after this func is called
            // So make sure the sender is added to habits
            if button.selected || button == sender as DiaryButton {
                guard let habit = getHabitFromButton(button) else { return }
                selectedHabits += [habit]
            }
        }
        diaryViewModel?.updateHabits(selectedHabits)
    }
    
    private func getHabitFromButton(button: DiaryButton) -> Habit? {
            for habit in defaultHabits {
            switch habit {
            case let .DrankTea(string):
                if button.titleLabel?.text == string {
                    return .DrankTea(string)
                }
            case let .BathOrShower(string):
                if button.titleLabel?.text == string {
                    return .BathOrShower(string)
                }
            case let .ReadBook(string):
                if button.titleLabel?.text == string {
                    return .ReadBook(string)
                }
            case let .Massage(string):
                if button.titleLabel?.text == string {
                    return .Massage(string)
                }
            case let .NoScreens(string):
                if button.titleLabel?.text == string {
                    return .NoScreens(string)
                }
            }
        }
        return nil
    }
    
}
