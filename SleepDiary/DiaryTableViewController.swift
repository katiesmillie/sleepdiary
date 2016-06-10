//
//  ViewController.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/9/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

private enum DiaryRow {
    case Date
    case TimeSlept
    case BedMood
    case WakeMood
    case Habits
    case Meds
    case Notes
}

class DiaryTableViewController: UITableViewController {
    
    private var rows: [DiaryRow] = [.Date, .TimeSlept, .BedMood, .WakeMood, .Habits, .Meds, .Notes]
    private var diaryViewModel : DiaryViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        let diaryEntry = DiaryEntry(date: NSDate())
        diaryViewModel = DiaryViewModel(entry: diaryEntry)
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
            return 40
        case .TimeSlept, .BedMood, .WakeMood:
            return 80
        case .Habits, .Meds:
            return 120
        case .Notes:
            return 100
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
            cell.configure(diaryViewModel)
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
        case .Meds:
            return defaultCell
        case .Notes:
            return defaultCell
        }
        
    }
    

    

    
}

