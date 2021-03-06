//
//  MoodTableViewCell.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/9/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

class MoodTableViewCell: UITableViewCell, MoodProtocol {
    
    @IBOutlet weak var firstButton: DiaryButton?
    @IBOutlet weak var secondButton: DiaryButton?
    @IBOutlet weak var thirdButton: DiaryButton?
    @IBOutlet weak var fourthButton: DiaryButton?
    @IBOutlet weak var fifthButton: DiaryButton?
    
    @IBOutlet weak var headerLabel: UILabel?
    
    var diaryViewModel: DiaryViewModel?
    var moodType: Mood.MoodType?
    
    class func cell(tableView: UITableView) -> MoodTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MoodTableViewCell") as! MoodTableViewCell
        return cell
    }
    
    func configure(diaryViewModel: DiaryViewModel, moodType: Mood.MoodType, strings: [String]) {
        self.diaryViewModel = diaryViewModel
        self.moodType = moodType

        setButtonStrings(strings)

        var setMood: Mood.MoodRating
        
        switch moodType {
        case .Bedtime:
            headerLabel?.text = "Bedtime Mood"
            guard let mood = diaryViewModel.bedtimeMood else { return }
            setMood = mood
        case .WakeUp:
            headerLabel?.text = "Wake-Up Mood"
            guard let mood = diaryViewModel.wakeUpMood else { return }
            setMood = mood
        }
        
        switch setMood {
        case .Anxious: firstButton?.selected = true
        case .Cranky: secondButton?.selected = true
        case .Relaxed: thirdButton?.selected = true
        case .Happy: fourthButton?.selected = true
        case .Energetic: fifthButton?.selected = true
        }
    }
    
    func setButtonStrings(strings: [String]){
        for mood in moods {
            switch mood {
            case .Anxious:
                firstButton?.setTitle(strings[0], forState: UIControlState.Normal)
            case .Cranky:
                secondButton?.setTitle(strings[1], forState: UIControlState.Normal)
            case .Relaxed:
                thirdButton?.setTitle(strings[2], forState: UIControlState.Normal)
            case .Happy:
                fourthButton?.setTitle(strings[3], forState: UIControlState.Normal)
            case .Energetic:
                fifthButton?.setTitle(strings[4], forState: UIControlState.Normal)
            }
        }
    }
    
    @IBAction func buttonWasTapped(sender: DiaryButton) {
        let buttons = [firstButton, secondButton, thirdButton, fourthButton, fifthButton]
        let filteredButtons = buttons.filter { $0?.titleLabel?.text == sender.titleLabel?.text }
        guard let buttonTapped = filteredButtons.first else { return }
        
        // If another button is selected, unselect it
        // Since only one mood will be saved
        for button in buttons {
            if button != buttonTapped {
                button?.selected = false
            }
        }
        
        guard let moodType = moodType else { return }
        
        for mood in moods {
            switch mood {
            case .Anxious:
                if buttonTapped?.titleLabel?.text == mood.string() {
                    let mood: Mood.MoodRating = .Anxious
                    diaryViewModel?.updateMood(mood, moodType: moodType)
                }
            case .Cranky:
                if buttonTapped?.titleLabel?.text == mood.string() {
                    let mood: Mood.MoodRating = .Cranky
                    diaryViewModel?.updateMood(mood, moodType: moodType)
                }
            case .Relaxed:
                if buttonTapped?.titleLabel?.text == mood.string() {
                    let mood: Mood.MoodRating = .Relaxed
                    diaryViewModel?.updateMood(mood, moodType: moodType)
                }
            case .Happy:
                if buttonTapped?.titleLabel?.text == mood.string() {
                    let mood: Mood.MoodRating = .Happy
                    diaryViewModel?.updateMood(mood, moodType: moodType)
                }
            case .Energetic:
                if buttonTapped?.titleLabel?.text == mood.string() {
                    let mood: Mood.MoodRating = .Energetic
                    diaryViewModel?.updateMood(mood, moodType: moodType)
                }
            }
        }
    }    
    
}




