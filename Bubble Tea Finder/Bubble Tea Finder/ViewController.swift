//
//  ViewController.swift
//  Bubble Tea Finder
//
//  Created by Pietro Rea on 8/24/14.
//  Copyright (c) 2014 Pietro Rea. All rights reserved.
//

import UIKit
import CoreData

// 定义的两个全局的变量
let filterViewControllerSegueIdentifier = "toFilterViewController"
let venueCellIdentifier = "VenueCell"

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var coreDataStack: CoreDataStack!

    // 保存GUI方式定义的那个 FetchRequest ## you created using Xcode’s data model editor
    var fetchRequest: NSFetchRequest!
    var venues: [Venue]! = [] // 存储获得的 venues
    
    // 异步Fetch
    var asyncFetchRequest: NSAsynchronousFetchRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let model = coreDataStack.context.persistentStoreCoordinator!.managedObjectModel
//        fetchRequest = model.fetchRequestTemplateForName("FetchRequest")
//        fetchAndReload()
        
//        fetchRequest = NSFetchRequest(entityName: "Venue")
//        fetchAndReload()
        
        
        //1
        fetchRequest = NSFetchRequest(entityName: "Venue")
        //2
        asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest)
        { [unowned self] (result: NSAsynchronousFetchResult! ) -> Void in
            self.venues = result.finalResult as! [Venue]
            self.tableView.reloadData()
        }
        //3
        do {
            try coreDataStack.context.executeRequest(asyncFetchRequest)
            //Returns immediately, cancel here if you want
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        let batchUpdate = NSBatchUpdateRequest(entityName: "Venue")
        batchUpdate.propertiesToUpdate = ["favorite" : NSNumber(bool: true)]
        batchUpdate.affectedStores = coreDataStack.context.persistentStoreCoordinator!.persistentStores
        batchUpdate.resultType = .UpdatedObjectsCountResultType
        do {
            let batchResult =
                try coreDataStack.context .executeRequest(batchUpdate) as! NSBatchUpdateResult
            print("Records updated \(batchResult.result!)")
        } catch let error as NSError {
            print("Could not update \(error), \(error.userInfo)")
        }
        
    }
    //MARK: - Helper methods
    // 获取所有的 venues 存储到 venues 中
    func fetchAndReload() {
        do {
            venues = try coreDataStack.context.executeFetchRequest(fetchRequest) as! [Venue]
            tableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == filterViewControllerSegueIdentifier {
            // 从segue获取navigation 再获取里面viewControlor
            // 再设置viewControlor里的属性
            let navController =
                segue.destinationViewController as! UINavigationController
            let filterVC =
                navController.topViewController as! FilterViewController
            filterVC.coreDataStack = coreDataStack
            filterVC.delegate = self
        }
    }
    
    @IBAction func unwindToVenuListViewController(segue: UIStoryboardSegue) {
        
    }
}

extension ViewController: UITableViewDataSource {
    
    // 这个地方是tableView 的 dataSource
    // 有多少行 每行的内容是什么
    
    func tableView(tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(venueCellIdentifier)!
        let venue = venues[indexPath.row]
        cell.textLabel!.text = venue.name
        cell.detailTextLabel!.text = venue.priceInfo?.priceCategory
        return cell
    }
}
//MARK: FilterViewControllerDelegate methods
extension ViewController: FilterViewControllerDelegate {
    func filterViewController(filter: FilterViewController, didSelectPredicate predicate:NSPredicate?, sortDescriptor:NSSortDescriptor?) {
        fetchRequest.predicate = nil
        fetchRequest.sortDescriptors = nil
        if let fetchPredicate = predicate {
            fetchRequest.predicate = fetchPredicate
        }
        if let sr = sortDescriptor {
            fetchRequest.sortDescriptors = [sr]
        }
        fetchAndReload()
    }
}
