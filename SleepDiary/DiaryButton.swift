//
//  DiaryButton.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/10/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

class DiaryButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Don't turn the emojis white when in selected state!
        setTitleColor(UIColor.blackColor(), forState: .Selected)
        self.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)
    }
    
    func buttonTapped() {
        selected = !selected
    }
    
}
