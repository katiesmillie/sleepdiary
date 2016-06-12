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
        self.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)
    }
    
    func buttonTapped() {
        selected = !selected
        setTitleColor(UIColor.blackColor(), forState: .Selected)
    }
    
}
