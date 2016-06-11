//
//  SleepDiaryTests.swift
//  SleepDiaryTests
//
//  Created by Katie Smillie on 6/9/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import XCTest
@testable import SleepDiary

class SleepDiaryTests: XCTestCase {
    
    var diaryViewModel: DiaryViewModel?
    let date1 = NSDate.init(timeIntervalSince1970: 1465401184000) // 6/8/2016, 11:53:04 AM
    let date2 = NSDate.init(timeIntervalSince1970: 1465573984000) // 6/10/2016, 11:53:04 AM
    let mood1: Mood.MoodRating = .Happy
    let mood2: Mood.MoodRating = .Energetic
    
    override func setUp() {
        super.setUp()

        let timeSlept = TimeSlept(minutes: 480)
        let habits: [Habit]? = [.ReadBook, .NoScreens]
        let notes = Notes(notes: "Hello")
        let diaryEntry = DiaryEntry(date: date1, timeSlept:timeSlept, bedtimeMood: mood1, wakeUpMood: mood2, habits: habits , notes: notes)
        
        diaryViewModel = DiaryViewModel(entry: diaryEntry)
        
    }

    
    func testUpdateDate() {
        XCTAssertEqual(date1, diaryViewModel?.date)
        diaryViewModel?.updateDate(date2)
        XCTAssertNotEqual(date1, diaryViewModel?.date)
        XCTAssertEqual(date2,  diaryViewModel?.date)
    }
    
    
    func testUpdateMood() {
        XCTAssertEqual(mood1, diaryViewModel?.bedMood)
        diaryViewModel?.updateMood(mood2, moodType: .Bedtime)
        XCTAssertNotEqual(mood1, diaryViewModel?.bedMood)
        XCTAssertEqual(mood2,  diaryViewModel?.bedMood)
        
    }
    
}
