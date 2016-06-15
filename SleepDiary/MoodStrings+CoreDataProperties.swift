//
//  MoodStrings+CoreDataProperties.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/14/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension MoodStrings {

    @NSManaged var mood1: String?
    @NSManaged var mood2: String?
    @NSManaged var mood3: String?
    @NSManaged var mood4: String?
    @NSManaged var mood5: String?

}
