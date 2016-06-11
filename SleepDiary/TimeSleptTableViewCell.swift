//
//  TimeSleptTableViewCell.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/10/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

protocol TimeSleptAlert {
    func minutesAlert()
    func hoursAlert()
}

class TimeSleptTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hoursLabel: UILabel?
    @IBOutlet weak var minutesLabel: UILabel?
    @IBOutlet weak var headerLabel: UILabel?
    
    @IBOutlet weak var hoursInput: UITextField?
    @IBOutlet weak var minutesInput: UITextField?
    
    var diaryViewModel: DiaryViewModel?
    var delegate: DiaryTableViewController?
    
    class func cell(tableView: UITableView) -> TimeSleptTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TimeSleptTableViewCell") as! TimeSleptTableViewCell
        return cell
    }
    
    func configure(diaryViewModel: DiaryViewModel, delegate: DiaryTableViewController) {
        self.diaryViewModel = diaryViewModel
        self.delegate = delegate
        headerLabel?.text = "Time Slept"
        minutesLabel?.text = "Minutes"
        hoursLabel?.text = "Hours"
        createAccessoryView()
    }
    
    func createAccessoryView() {
        let accessoryView = UIView(frame: CGRectMake(0, 0, 10, 40))
        accessoryView.layer.borderColor = UIColor.grayColor().CGColor
        accessoryView.backgroundColor = UIColor.whiteColor()
        let doneLabel = UILabel(frame: accessoryView.frame)
        doneLabel.text = "Done ✅"
        doneLabel.textColor = UIColor.blueColor()
        doneLabel.textAlignment = NSTextAlignment.Center
        accessoryView.addSubview(doneLabel)
        
        let doneButton = UIButton(frame: accessoryView.frame)
        doneButton.addTarget(self, action: #selector(validateAndDismissKeyboard), forControlEvents: UIControlEvents.TouchUpInside)
        accessoryView.addSubview(doneButton)
        
        accessoryView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        doneLabel.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        doneButton.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        
        hoursInput?.inputAccessoryView = accessoryView
        minutesInput?.inputAccessoryView = accessoryView
    }
    
    func validateAndDismissKeyboard() {
        if !validateHours() {
            delegate?.hoursAlert()
        } else if !validateMinutes() {
            delegate?.minutesAlert()
        } else if validateHours() && validateMinutes() {
            diaryViewModel?.updateTimeSlept(hoursAsInt(), minutes: minutesAsInt())
            hoursInput?.resignFirstResponder()
            minutesInput?.resignFirstResponder()
        }
    }

    func hoursAsInt() -> Int {
        // If hours field is nil or empty string, set to 0
        guard let hoursString = hoursInput?.text else { return 0 }
        return Int(hoursString) ?? 0
    }
    
    func minutesAsInt() -> Int {
        // If minutes field is nil or empty string, set to 0
        guard let minutesString = minutesInput?.text else { return 0 }
        return Int(minutesString) ?? 0
    }
    
    func validateHours() -> Bool {
        return hoursAsInt() <= 20 && hoursAsInt() >= 0
    }
    
    func validateMinutes() -> Bool {
        return minutesAsInt() < 60 && minutesAsInt() >= 0
    }
    
    
}
