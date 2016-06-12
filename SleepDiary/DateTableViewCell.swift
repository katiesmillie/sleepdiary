//
//  DateTableViewCell.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/9/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

class DateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel?
    
    class func cell(tableView: UITableView) -> DateTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DateTableViewCell") as! DateTableViewCell
        return cell
    }
    
    func configure(delegate: DiaryViewModel) {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .LongStyle
        let dateString = formatter.stringFromDate(NSDate())
        dateLabel?.text = "🗓 \(dateString)"
    }

}
