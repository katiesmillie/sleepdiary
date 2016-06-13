//
//  Entry+CoreDataProperties.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/12/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Entry {

    @NSManaged var date: NSDate?
    @NSManaged var timeSlept: NSNumber?
    @NSManaged var bedtimeMood: NSNumber?
    @NSManaged var notes: String?
    @NSManaged var wakeUpMood: NSNumber?
    @NSManaged var habits: NSObject?

}
