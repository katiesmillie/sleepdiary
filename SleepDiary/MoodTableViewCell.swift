//
//  MoodTableViewCell.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/9/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

protocol Moods {
    var moods: [Mood.MoodRating] { get }
}

extension Moods {
    var moods: [Mood.MoodRating] {
        return [.Anxious, .Cranky, .Relaxed, .Happy, .Energetic]
    }
}

class MoodTableViewCell: UITableViewCell, Moods {
    
    @IBOutlet weak var firstButton: UIButton?
    @IBOutlet weak var secondButton: UIButton?
    @IBOutlet weak var thirdButton: UIButton?
    @IBOutlet weak var fourthButton: UIButton?
    @IBOutlet weak var fifthButton: UIButton?
    
    @IBOutlet weak var headerLabel: UILabel?
    
    var diaryViewModel: DiaryViewModel?
    var moodType: Mood.MoodType?
    

    
    class func cell(tableView: UITableView) -> MoodTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MoodTableViewCell") as! MoodTableViewCell
        return cell
    }
    
    func configure(diaryViewModel: DiaryViewModel, moodType: Mood.MoodType) {
        self.diaryViewModel = diaryViewModel
        self.moodType = moodType
        
        
        switch moodType {
        case .Bedtime:
            headerLabel?.text = "Bedtime Mood"
        case .WakeUp:
            headerLabel?.text = "Wake-Up Mood"

        }
       
        for mood in moods {
            switch mood {
            case .Anxious:
                firstButton?.setTitle(mood.string(), forState: UIControlState.Normal)
            case .Cranky:
                secondButton?.setTitle(mood.string(), forState: UIControlState.Normal)
            case .Relaxed:
                thirdButton?.setTitle(mood.string(), forState: UIControlState.Normal)
            case .Happy:
                fourthButton?.setTitle(mood.string(), forState: UIControlState.Normal)
            case .Energetic:
                fifthButton?.setTitle(mood.string(), forState: UIControlState.Normal)
            }
        }
    }
    
    
    @IBAction func firstButtonTapped(sender: UIButton) {
        let mood: Mood.MoodRating = .Anxious
        guard let moodType = moodType else { return }
        diaryViewModel?.updateMood(mood, moodType: moodType)
    }
    

 
    
    

}
