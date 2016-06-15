//
//  EntriesTableViewController.swift
//  SleepDiary
//
//  Created by Katie Smillie on 6/12/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit
import CoreData

class EntriesTableViewController: UITableViewController {
    
    var entriesViewModel: DiaryEntriesViewModel?
    var diaryEntries: [DiaryViewModel] = []
    var selectedIndexPath: NSIndexPath?
    
    var managedObjectContext: NSManagedObjectContext? {
        guard let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else { return nil }
        return appDelegate.managedObjectContext
    }
    
    
    lazy var fetchedResultsController: NSFetchedResultsController? = {
        let fetchRequest = NSFetchRequest(entityName: "Entry")
        let primarySortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [primarySortDescriptor]
        guard let managedObjectContext = self.managedObjectContext else { return nil }
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewModel()
        fetchData()
    }
    

    func setViewModel() {
        let diaryEntries: [DiaryViewModel] = []
        entriesViewModel = DiaryEntriesViewModel(diaryEntries: diaryEntries)
    }
    
    func fetchData() {
        do {
            try fetchedResultsController?.performFetch()
            
        } catch let error as NSError {
            print("An error: \(error.localizedDescription)")
        }
        
        guard let coreDataEntries = fetchedResultsController?.fetchedObjects as? [Entry] else { return }
        entriesViewModel?.addEntries(coreDataEntries)
        guard let entries = entriesViewModel?.diaryEntries else { return }
        diaryEntries = entries
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaryEntries.count
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, 10, 70))
        headerView.layer.borderColor = UIColor.grayColor().CGColor
        headerView.backgroundColor = UIColor.whiteColor()
        let doneLabel = UILabel(frame: headerView.frame)
        doneLabel.text = "+ Add Entry"
        doneLabel.textColor = UIColor.blackColor()
        doneLabel.textAlignment = NSTextAlignment.Center
        headerView.addSubview(doneLabel)
        
        let addButton = UIButton(frame: headerView.frame)
        addButton.addTarget(self, action: #selector(addEntry), forControlEvents: UIControlEvents.TouchUpInside)
        headerView.addSubview(addButton)
        
        headerView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        doneLabel.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        addButton.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        
        return headerView
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Entry Cell", forIndexPath: indexPath) as! EntryCell
        let entry = diaryEntries[indexPath.row]
        guard let date = entry.date else { return cell }
        let dateString = NSDateFormatter.localizedStringFromDate(date, dateStyle: .FullStyle, timeStyle: .NoStyle)
        cell.dateLabel?.text = dateString
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndexPath = indexPath
        performSegueWithIdentifier("Open Entry", sender: indexPath.row)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            if let item = fetchedResultsController?.objectAtIndexPath(indexPath) as? NSManagedObject {
                managedObjectContext?.deleteObject(item)
                do {
                    try managedObjectContext?.save()
                }
                catch let error as NSError  {
                    print("Could not save \(error)")
                }
            }
        }
    }
    
  // MARK: Navigation
    
    func addEntry() {
        // Create a new empty view model
        let diaryViewModel = DiaryViewModel(entry: DiaryEntry())
        
        // Update the date to today
        diaryViewModel.updateDate(NSDate())
        performSegueWithIdentifier("Open Entry", sender: diaryViewModel)
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var viewModel: DiaryViewModel?
        if let diaryViewModel = sender as? DiaryViewModel {
            viewModel = diaryViewModel
        }
        
        if let index = sender as? Int {
            let entry = diaryEntries[index].diaryEntry
            viewModel = DiaryViewModel(entry: entry)
        }
        
        if let navController = segue.destinationViewController as? UINavigationController, diaryVC = navController.topViewController as? DiaryTableViewController {
            diaryVC.diaryViewModel = viewModel
            diaryVC.delegate = self
        }
    }
}
    
extension EntriesTableViewController: DiaryTableViewDelegate {
    
    func saveEntry(diaryViewModel: DiaryViewModel) {
      
        guard let managedObjectContext = managedObjectContext  else { return }
        guard let entity = NSEntityDescription.entityForName("Entry", inManagedObjectContext: managedObjectContext) else { return }
        
        var entry: NSManagedObject
        
        // If the entry already existed, look it up from the index path
        if let index = selectedIndexPath {
            entry = fetchedResultsController?.objectAtIndexPath(index) as! Entry
            // then clear selected index path
            selectedIndexPath = nil
        
        // Otherwise, insert a new entry
        } else {
            entry = NSManagedObject(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
        }
        
        entry.setValue(diaryViewModel.date, forKey: "date")
        entry.setValue(diaryViewModel.timeSlept?.totalMinutes, forKey: "timeSlept")
        entry.setValue(diaryViewModel.bedtimeMood?.rawValue, forKey: "bedtimeMood")
        entry.setValue(diaryViewModel.wakeUpMood?.rawValue, forKey: "wakeUpMood")
        let mappedHabits = diaryViewModel.habits?.map{ $0.rawValue() }
        entry.setValue(mappedHabits, forKey: "habits")
        entry.setValue(diaryViewModel.notes, forKey: "notes")
                
        do {
            try managedObjectContext.save()
        } catch let error as NSError  {
            print("Could not save \(error)")
        }
    }

}

extension EntriesTableViewController: NSFetchedResultsControllerDelegate {

    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
        case .Insert:
            if let insertIndexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([insertIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }
        case .Delete:
            if let deleteIndexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([deleteIndexPath], withRowAnimation: .Fade)
            }
        case .Update, .Move:
            if let _ = indexPath { }
        }
        fetchData()

    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
}