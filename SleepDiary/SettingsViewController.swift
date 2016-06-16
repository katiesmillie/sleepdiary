//
//  SettingsViewController.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/14/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit
import CoreData

private enum SettingsRow {
    case MoodString
    case HabitsString
}

class SettingsViewController: UITableViewController, MoodProtocol, HabitProtocol {
    
    private var rows: [SettingsRow] = [.MoodString, .HabitsString]    
    var moodStrings: [String]?
    var habitStrings: [String]?
    let moodCellString = "Choose an emoji to represent your mood rankings"
    let habitCellString = "Choose an emoji to represent your bedtime habits"
    
    var managedObjectContext: NSManagedObjectContext? {
        guard let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else { return nil }
        return appDelegate.managedObjectContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.keyboardDismissMode = .Interactive
        fetchStrings()
        saveMoodStrings()
        saveHabitStrings()
    }
    
    private func fetchRow(indexPath: NSIndexPath) -> SettingsRow {
        return rows[indexPath.row]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch fetchRow(indexPath) {
        case .MoodString:
            let cell = CustomStringTableViewCell.cell(tableView)
            cell.headerLabel?.text = moodCellString
            guard let moodStrings = moodStrings else { return cell }
            cell.configure(self, strings: moodStrings)
            return cell
        case .HabitsString:
            let cell = CustomStringTableViewCell.cell(tableView)
            cell.headerLabel?.text = habitCellString
            guard let habitStrings = habitStrings else { return cell }
            cell.configure(self, strings: habitStrings)
            return cell
        }
        
    }
    
    func fetchStrings() {
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
            if let moodString = moodStringResults?.last {
                moodStrings = [moodString.mood1, moodString.mood2, moodString.mood3, moodString.mood4, moodString.mood5].flatMap{$0}
            }
            if let habitString = habitStringsResults?.last {
                habitStrings = [habitString.habit1, habitString.habit2, habitString.habit3, habitString.habit4, habitString.habit5].flatMap{$0}
            }
        } catch let error as NSError {
            print("An error: \(error.localizedDescription)")
        }
        
    }
    
    func saveMoodStrings() {
        guard let managedObjectContext = managedObjectContext  else { return }
       
        var moodStringsObject: NSManagedObject?
        let fetchRequest = NSFetchRequest(entityName: "MoodStrings")
        
        // Check to see if an object already exists, if not insert it
        if let results = try? self.managedObjectContext?.executeFetchRequest(fetchRequest) as? [NSManagedObject], object = results?.first {
            moodStringsObject = object
        } else if let entitity = NSEntityDescription.entityForName("MoodStrings", inManagedObjectContext: managedObjectContext) {
            moodStringsObject = NSManagedObject(entity: entitity, insertIntoManagedObjectContext: managedObjectContext)
        }
        
        // Get the default strings in case the user hasn't saved any
        let defaultMoodStrings = moods.map{$0.string()}
        let moodStringsToSave: [String] = moodStrings ?? defaultMoodStrings
        moodStrings = moodStringsToSave
        
        moodStringsObject?.setValue(moodStringsToSave[0], forKey: "mood1")
        moodStringsObject?.setValue(moodStringsToSave[1], forKey: "mood2")
        moodStringsObject?.setValue(moodStringsToSave[2], forKey: "mood3")
        moodStringsObject?.setValue(moodStringsToSave[3], forKey: "mood4")
        moodStringsObject?.setValue(moodStringsToSave[4], forKey: "mood5")
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError  {
            print("Could not save \(error)")
        }
    }
    
    func saveHabitStrings() {
        // TODO: Figure out better way to not repeat this function for both mood and habit
        guard let managedObjectContext = managedObjectContext  else { return }
        
        var habitStringsObject: NSManagedObject?
        let fetchRequest = NSFetchRequest(entityName: "HabitStrings")
        
        // Check to see if an object already exists, if not insert it
        if let results = try? self.managedObjectContext?.executeFetchRequest(fetchRequest) as? [NSManagedObject], object = results?.first  {
            habitStringsObject = object
        } else if let entity = NSEntityDescription.entityForName("HabitStrings", inManagedObjectContext: managedObjectContext) {
            habitStringsObject = NSManagedObject(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
        }
        // Get the default strings in case the user hasn't saved any
        let defaultHabitStrings = getHabitStrings(defaultHabits)
        let habitStringsToSave = habitStrings ?? defaultHabitStrings
        habitStrings = defaultHabitStrings
        
        habitStringsObject?.setValue(habitStringsToSave[0], forKey: "habit1")
        habitStringsObject?.setValue(habitStringsToSave[1], forKey: "habit2")
        habitStringsObject?.setValue(habitStringsToSave[2], forKey: "habit3")
        habitStringsObject?.setValue(habitStringsToSave[3], forKey: "habit4")
        habitStringsObject?.setValue(habitStringsToSave[4], forKey: "habit5")
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError  {
            print("Could not save \(error)")
        }
    }

    
    @IBAction func save(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func saveCurrentStrings() {
        guard let cells = tableView.visibleCells as? [CustomStringTableViewCell] else { return }
        for cell in cells {
            if cell.headerLabel?.text == moodCellString {
                moodStrings = [cell.string1?.text, cell.string2?.text, cell.string3?.text, cell.string4?.text, cell.string5?.text].flatMap{$0}
            } else if cell.headerLabel?.text == habitCellString {
                habitStrings = [cell.string1?.text, cell.string2?.text, cell.string3?.text, cell.string4?.text, cell.string5?.text].flatMap{$0}
            }
        }
        saveHabitStrings()
        saveMoodStrings()
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // TODO: only allow 1-2 characters
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        saveCurrentStrings()
    }

}



