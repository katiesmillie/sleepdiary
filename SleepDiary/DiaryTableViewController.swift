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

class DiaryTableViewController: UITableViewController, MoodProtocol, HabitProtocol {
    
    private var rows: [DiaryRow] = [.Date, .TimeSlept, .BedMood, .WakeMood, .Habits, .Notes]
    internal var diaryViewModel : DiaryViewModel?
    var delegate: DiaryTableViewDelegate?
    
    var moodStrings: [String]?
    var habits: [Habit]?
    
    var managedObjectContext: NSManagedObjectContext? {
        guard let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else { return nil }
        return appDelegate.managedObjectContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStrings()
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
        guard let moodStrings = moodStrings else { return defaultCell }
        
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
            cell.configure(diaryViewModel, moodType: .Bedtime, strings: moodStrings)
            return cell
        case .WakeMood:
            let cell = MoodTableViewCell.cell(tableView)
            cell.configure(diaryViewModel, moodType: .WakeUp, strings: moodStrings)
            return cell
        case .Habits:
            let cell = HabitsTableViewCell.cell(tableView)
            cell.configure(diaryViewModel, habits: habits)
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
    
    func fetchStrings() {
        let defaultMoodStrings = moods.map{$0.string()}
        moodStrings = defaultMoodStrings
        
        guard let managedObjectContext = managedObjectContext  else { return }
        let fetchMoodString = NSFetchRequest()
        let fetchHabitString = NSFetchRequest()
        guard let moodStringsEntity = NSEntityDescription.entityForName("MoodStrings", inManagedObjectContext: managedObjectContext) else { return }
        guard let habitStringsEntity = NSEntityDescription.entityForName("HabitStrings", inManagedObjectContext: managedObjectContext) else { return }
        
        fetchMoodString.entity = moodStringsEntity
        fetchHabitString.entity = habitStringsEntity
        
        do {
            let moodStringResults = try self.managedObjectContext?.executeFetchRequest(fetchMoodString) as? [MoodStrings]
            let habitStringsResults = try self.managedObjectContext?.executeFetchRequest(fetchHabitString) as? [HabitStrings]
            
            
            // TODO: Refactor model names to make more sense
            // ??? Do I really need two entities for the separate strings?
            if let moodString = moodStringResults?.first {
                moodStrings = [moodString.mood1, moodString.mood2, moodString.mood3, moodString.mood4, moodString.mood5].flatMap{$0}
            }
            if let habitString = habitStringsResults?.first {
                let habitStrings = [habitString.habit1, habitString.habit2, habitString.habit3, habitString.habit4, habitString.habit5].flatMap{$0}
                habits = getHabitsFromStrings(habitStrings)
                
            }
        } catch let error as NSError {
            print("An error: \(error.localizedDescription)")
        }
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
        guard let string = textField.text else { return true }
        diaryViewModel?.updateNotes(string)
        return true
    }
    
}




