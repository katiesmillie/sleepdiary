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
    
    @IBOutlet weak var firstButton: UIButton?
    @IBOutlet weak var secondButton: UIButton?
    @IBOutlet weak var thirdButton: UIButton?
    @IBOutlet weak var fourthButton: UIButton?
    @IBOutlet weak var fifthButton: UIButton?
    @IBOutlet weak var sixthButton: UIButton?
    @IBOutlet weak var headerLabel: UILabel?
    
    var diaryViewModel: DiaryViewModel?
    
    var habits: [Habit] {
        return [.DrankTea, .BathOrShower, .ReadBook, .Supplements, .Massage, .NoScreens]
    }
    
    class func cell(tableView: UITableView) -> HabitsTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HabitsTableViewCell") as! HabitsTableViewCell
        return cell
    }

    func configure(diaryViewModel: DiaryViewModel) {
        self.diaryViewModel = diaryViewModel
        headerLabel?.text = "Bedtime Habits"
        
        
        // ???: Create a tighter coupling between buttons and moods
        for habit in habits {
            switch habit {
            case .DrankTea:
                firstButton?.setTitle(habit.string(), forState: UIControlState.Normal)
            case .BathOrShower:
                secondButton?.setTitle(habit.string(), forState: UIControlState.Normal)
            case .ReadBook:
                thirdButton?.setTitle(habit.string(), forState: UIControlState.Normal)
            case .Supplements:
                fourthButton?.setTitle(habit.string(), forState: UIControlState.Normal)
            case .Massage:
                fifthButton?.setTitle(habit.string(), forState: UIControlState.Normal)
            case .NoScreens:
                sixthButton?.setTitle(habit.string(), forState: UIControlState.Normal)
            }
        }
    }

}
