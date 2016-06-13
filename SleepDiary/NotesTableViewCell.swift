//
//  NotesTableViewCell.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/10/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel?
    @IBOutlet weak var notesInputField: UITextField?
    
    var diaryViewModel: DiaryViewModel?
    
    class func cell(tableView: UITableView) -> NotesTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NotesTableViewCell") as! NotesTableViewCell
        return cell
    }
    
    
    func configure(diaryViewModel: DiaryViewModel) {
        self.diaryViewModel = diaryViewModel
        headerLabel?.text = "Notes"
    }

    
    // TODO: Save notes when done editing probably in UITextFieldDelegate
    
}


