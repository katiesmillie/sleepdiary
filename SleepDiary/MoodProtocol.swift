//
//  MoodProtocol.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/15/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import Foundation

protocol MoodProtocol {
    var moods: [Mood.MoodRating] { get }
}

extension MoodProtocol {
    var moods: [Mood.MoodRating] {
        return [.Anxious, .Cranky, .Relaxed, .Happy, .Energetic]
    }
}
