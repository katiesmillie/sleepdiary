//
//  ViewController.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/9/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit
import CoreData

protocol DiaryTableViewDelegate {
    func saveEntry(diaryViewModel: DiaryViewModel)
}

private enum DiaryRow {
    case Date
    case TimeSlept
    case BedMood
    case WakeMood
    case Habits
    case Notes
}

class DiaryTableViewController: UITableViewController {
    
    private var rows: [DiaryRow] = [.Date, .TimeSlept, .BedMood, .WakeMood, .Habits, .Notes]
    internal var diaryViewModel : DiaryViewModel?
    var delegate: DiaryTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.keyboardDismissMode = .Interactive
    }
    
    private func fetchRow(indexPath: NSIndexPath) -> DiaryRow {
        return rows[indexPath.row]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch fetchRow(indexPath) {
        case .Date:
            return 60
        case .TimeSlept, .BedMood, .WakeMood, .Habits, .Notes:
            return 90
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        guard let diaryViewModel = diaryViewModel else { return defaultCell }

        switch fetchRow(indexPath) {
        case .Date:
            let cell = DateTableViewCell.cell(tableView)
            cell.configure(diaryViewModel)
            return cell
        case .TimeSlept:
            let cell = TimeSleptTableViewCell.cell(tableView)
            cell.configure(diaryViewModel, delegate: self)
            return cell
        case .BedMood:
            let cell = MoodTableViewCell.cell(tableView)
            cell.configure(diaryViewModel, moodType: .Bedtime)
            return cell
        case .WakeMood:
            let cell = MoodTableViewCell.cell(tableView)
            cell.configure(diaryViewModel, moodType: .WakeUp)
            return cell
        case .Habits:
            let cell = HabitsTableViewCell.cell(tableView)
            cell.configure(diaryViewModel)
            return cell
        case .Notes:
            let cell = NotesTableViewCell.cell(tableView)
            cell.configure(diaryViewModel)
            cell.notesInputField?.delegate = self
            return cell
        }
    }
    
    @IBAction func done(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
        guard let diaryViewModel = diaryViewModel else { return }
        delegate?.saveEntry(diaryViewModel)
    }
    

}

extension DiaryTableViewController: TimeSleptAlert {

    func minutesAlert() {
        showAlert("Please enter minutes between 0 and 59")
    }
    
    func hoursAlert() {
        showAlert("Please enter hours between 0 and 20")
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message,  preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}

extension DiaryTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}




