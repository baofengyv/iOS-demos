//
//  ViewController.swift
//  WorldCup
//
//  Created by Pietro Rea on 8/2/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit
import CoreData

private let teamCellIdentifier = "teamCellReuseIdentifier"

class ViewController: UIViewController {
    
    var coreDataStack: CoreDataStack!
    
    var fetchedResultsController:NSFetchedResultsController!{
        didSet{
            fetchedResultsController.delegate = self
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let fetchRquest = NSFetchRequest(entityName: "Team")
        
        // 设置排序描述符
        // 设置section时 制定的第一个sortDescriptor必须相符
        let zoneSort = NSSortDescriptor(key: "qualifyingZone", ascending: true)
        let scoreSort = NSSortDescriptor(key: "wins", ascending: false)
        let nameSort = NSSortDescriptor(key: "teamName", ascending: true)

        
        fetchRquest.sortDescriptors = [zoneSort,scoreSort,nameSort]
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRquest,
            managedObjectContext: coreDataStack.context,
            sectionNameKeyPath: "qualifyingZone",
            cacheName: "worldCup"  //指定一个名字来使用cache
        )
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Error:\(error.localizedDescription)")
        }
    }
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            addButton.enabled = true
        }
    }
    @IBAction func addTeam(sender: AnyObject) {
        let alert = UIAlertController(title: "Secret Team",
                                      message: "Add a new team",
                                      preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField!) in
            textField.placeholder = "Team Name"
        }
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField!) in
            textField.placeholder = "Qualifying Zone"
        }
        alert.addAction(UIAlertAction(title: "Save",
            style: .Default, handler: { (action: UIAlertAction!) in
                print("Saved")
                let nameTextField = alert.textFields!.first
                let zoneTextField = alert.textFields![1]
                let team = NSEntityDescription.insertNewObjectForEntityForName("Team", inManagedObjectContext: self.coreDataStack.context)
                    as! Team
                team.teamName = nameTextField!.text
                team.qualifyingZone = zoneTextField.text
                team.imageName = "wenderland-flag"
                self.coreDataStack.saveContext()
        }))
        alert.addAction(UIAlertAction(title: "Cancel",
            style: .Default, handler: { (action: UIAlertAction!) in
                print("Cancel")
        }))
        presentViewController(alert, animated: true,
                              completion: nil)
    }
    func configureCell(cell: TeamCell, indexPath: NSIndexPath) {
        let team = fetchedResultsController.objectAtIndexPath(indexPath) as! Team
        
        cell.flagImageView.image = UIImage(named: team.imageName!)
        cell.teamLabel.text = team.teamName
        cell.scoreLabel.text = "Wins: \(team.wins!)"
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
       return fetchedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    func tableView(tableView: UITableView,
                   cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier(teamCellIdentifier, forIndexPath: indexPath) as! TeamCell
            
            configureCell(cell, indexPath: indexPath)
            
            return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.name
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView,didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let team = fetchedResultsController.objectAtIndexPath(indexPath) as! Team
        // NSNumber 转 Int
        let wins = team.wins!.integerValue
        // Int 转 NSNunmber
        team.wins = NSNumber(integer: wins + 1)
        
        // team实例在context中的    直接保存即可
        coreDataStack.saveContext()
    }
}

// 已扩展的方式 实现delegate
extension ViewController:NSFetchedResultsControllerDelegate{
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()//开始一系列的方法调用
    }
    func controller(controller: NSFetchedResultsController,
                    didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
        case .Update:
            let cell = tableView.cellForRowAtIndexPath(indexPath!) as! TeamCell
            configureCell(cell, indexPath: indexPath!)
        case .Move:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
        }
    }
    func controller(controller: NSFetchedResultsController,
                    didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        let indexSet = NSIndexSet(index: sectionIndex)
        
        switch type {
        case .Insert:
            tableView.insertSections(indexSet, withRowAnimation: .Automatic)
        case .Delete:
            tableView.deleteSections(indexSet, withRowAnimation: .Automatic)
        default:
            break
        }
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates() //结束一系列的方法调用 apply changes to tableView
    }
}
