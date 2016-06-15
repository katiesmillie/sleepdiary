//
//  CustomStringTableViewCell.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/14/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

class CustomStringTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headerLabel: UILabel?
    @IBOutlet weak var string1: UITextField?
    @IBOutlet weak var string2: UITextField?
    @IBOutlet weak var string3: UITextField?
    @IBOutlet weak var string4: UITextField?
    @IBOutlet weak var string5: UITextField?
    
    
    class func cell(tableView: UITableView) -> CustomStringTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomStringTableViewCell") as! CustomStringTableViewCell
        return cell
    }
    
    func configure(delegate: UITextFieldDelegate, strings: [String]) {
        string1?.text = strings[0]
        string2?.text = strings[1]
        string3?.text = strings[2]
        string4?.text = strings[3]
        string5?.text = strings[4]
        
        string1?.delegate = delegate
        string2?.delegate = delegate
        string3?.delegate = delegate
        string4?.delegate = delegate
        string5?.delegate = delegate        
    }
    
}
