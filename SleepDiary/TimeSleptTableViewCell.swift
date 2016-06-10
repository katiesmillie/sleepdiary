//
//  TimeSleptTableViewCell.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/10/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

class TimeSleptTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hoursLabel: UILabel?
    @IBOutlet weak var minutesLabel: UILabel?
    @IBOutlet weak var headerLabel: UILabel?
    
    @IBOutlet weak var hoursInput: UITextField?
    @IBOutlet weak var minutesInput: UITextField?

    var diaryViewModel: DiaryViewModel?
    
    class func cell(tableView: UITableView) -> TimeSleptTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TimeSleptTableViewCell") as! TimeSleptTableViewCell
        return cell
    }
    
    func configure(diaryViewModel: DiaryViewModel) {
        self.diaryViewModel = diaryViewModel
        headerLabel?.text = "Time Slept"
        minutesLabel?.text = "Minutes"
        hoursLabel?.text = "Hours"
        
    }

    func validateMinutes() -> Bool {
        guard let inputtedMinutes = minutesInput?.text else { return false }
        guard let formattedMinutes = NSNumberFormatter().numberFromString(inputtedMinutes) else { return false }
        let minutes = Int(formattedMinutes)
        
        if minutes < 60 || minutes >= 0 {
           return true
        } else {
            return false
        }

    }
    
    func validateHours() -> Bool {
        guard let inputtedHours = hoursInput?.text else { return false }
        guard let formattedHours = NSNumberFormatter().numberFromString(inputtedHours) else { return false }
        let hours = Int(formattedHours)
        
        if hours <= 20 || hours >= 0 {
            return true
        } else {
            return false
        }
    }
    
    func minutesAlert() {
        let message = "Please enter minutes between 0 and 59"
        let alert = UIAlertController(title: nil, message: message,  preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: {
            action in
        })
        alert.addAction(action)
    }
    
    func hoursAlert() {
        let message = "Please enter hours between 0 and 20"
        let alert = UIAlertController(title: nil, message: message,  preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: {
            action in
        })
        alert.addAction(action)
    }
    
    

}
