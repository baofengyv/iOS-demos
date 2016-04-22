//
//  FilterViewController.swift
//  Bubble Tea Finder
//
//  Created by Pietro Rea on 8/27/14.
//  Copyright (c) 2014 Pietro Rea. All rights reserved.
//

import UIKit
import CoreData

class FilterViewController: UITableViewController {
    
    @IBOutlet weak var firstPriceCategoryLabel: UILabel!
    @IBOutlet weak var secondPriceCategoryLabel: UILabel!
    @IBOutlet weak var thirdPriceCategoryLabel: UILabel!
    @IBOutlet weak var numDealsLabel: UILabel!
    
    //Price section
    @IBOutlet weak var cheapVenueCell: UITableViewCell!
    @IBOutlet weak var moderateVenueCell: UITableViewCell!
    @IBOutlet weak var expensiveVenueCell: UITableViewCell!
    
    //Most popular section
    @IBOutlet weak var offeringDealCell: UITableViewCell!
    @IBOutlet weak var walkingDistanceCell: UITableViewCell!
    @IBOutlet weak var userTipsCell: UITableViewCell!
    
    //Sort section
    @IBOutlet weak var nameAZSortCell: UITableViewCell!
    @IBOutlet weak var nameZASortCell: UITableViewCell!
    @IBOutlet weak var distanceSortCell: UITableViewCell!
    @IBOutlet weak var priceSortCell: UITableViewCell!
    
    var coreDataStack: CoreDataStack!
    
    // hold a reference to FilterViewController’s delegate
    weak var delegate: FilterViewControllerDelegate?
    var selectedSortDescriptor: NSSortDescriptor?
    var selectedPredicate: NSPredicate?
    
    // 用这个计算价格等级为$ 的数量
    lazy var cheapVenuePredicate: NSPredicate = {
        var predicate =
            NSPredicate(format: "priceInfo.priceCategory == %@", "$")
        return predicate
    }()
    
    lazy var moderateVenuePredicate: NSPredicate = { var predicate =
        NSPredicate(format: "priceInfo.priceCategory == %@", "$$")
        return predicate
    }()
    
    lazy var expensiveVenuePredicate: NSPredicate = {
        var predicate = NSPredicate(format: "priceInfo.priceCategory == %@", "$$$")
        return predicate
    }()
    
    lazy var offeringDealPredicate: NSPredicate = {
        var pr = NSPredicate(format: "specialCount > 0")
        return pr
    }()
    
    lazy var walkingDistancePredicate: NSPredicate = {
        var pr = NSPredicate(format: "location.distance < 500")
        return pr
    }()
    
    lazy var hasUserTipsPredicate: NSPredicate = {
        var pr = NSPredicate(format: "stats.tipCount > 0")
        return pr
    }()
    
    
    lazy var nameSortDescriptor: NSSortDescriptor = {
        var sd = NSSortDescriptor(
            key: "name",
            ascending: true,
            selector: #selector(NSString.localizedStandardCompare(_:)))
        return sd
    }()
    lazy var distanceSortDescriptor: NSSortDescriptor = {
        var sd = NSSortDescriptor(key: "location.distance", ascending: true)
        return sd
    }()
    lazy var priceSortDescriptor: NSSortDescriptor = {
        var sd = NSSortDescriptor(key: "priceInfo.priceCategory",ascending: true)
        return sd
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 显示最便宜价格的数量
        populateCheapVenueCountLabel()
        
        // 显示中等价格的数量
        populateModerateVenueCountLabel()
        
        // 通过直接获取的方式 得到数量
        populateExpensiveVenueCountLabel()
        
        populateDealsCountLabel()
    }
    func populateCheapVenueCountLabel() {
        // $ fetch request
        let fetchRequest = NSFetchRequest(entityName: "Venue")
        fetchRequest.resultType = .CountResultType
        fetchRequest.predicate = cheapVenuePredicate
        do {
            let results =
                try coreDataStack.context
                    .executeFetchRequest(fetchRequest) as! [NSNumber]
            let count = results.first!.integerValue

            firstPriceCategoryLabel.text = "\(count) bubble tea places"
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func populateModerateVenueCountLabel() {
        // $$ fetch request
        let fetchRequest = NSFetchRequest(entityName: "Venue")
        fetchRequest.resultType = .CountResultType
        fetchRequest.predicate = moderateVenuePredicate
        do {
            let results =
                try coreDataStack.context
                    .executeFetchRequest(fetchRequest) as! [NSNumber]
            let count = results.first!.integerValue
            secondPriceCategoryLabel.text = "\(count) bubble tea places"
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func populateExpensiveVenueCountLabel() {
        // $$$ fetch request
        let fetchRequest = NSFetchRequest(entityName: "Venue")
        fetchRequest.predicate = expensiveVenuePredicate
        var error: NSError?
        
        let count = coreDataStack.context.countForFetchRequest(fetchRequest,
                                                               error: &error)
        if count != NSNotFound {
            thirdPriceCategoryLabel.text = "\(count) bubble tea places"
        } else {
            print("Could not fetch \(error), \(error?.userInfo)")
        }
    }
    
    func populateDealsCountLabel() {
        //1
        let fetchRequest = NSFetchRequest(entityName: "Venue")
        fetchRequest.resultType = .DictionaryResultType
        //2
        let sumExpressionDesc = NSExpressionDescription()
        sumExpressionDesc.name = "sumDeals"
        //3
        sumExpressionDesc.expression = NSExpression(forFunction: "sum:",
                                                    arguments:[NSExpression(forKeyPath: "specialCount")])
        sumExpressionDesc.expressionResultType = .Integer32AttributeType
        //4
        fetchRequest.propertiesToFetch = [sumExpressionDesc]
        //5
        do {
            let results = try coreDataStack.context.executeFetchRequest(fetchRequest) as! [NSDictionary]
            let resultDict = results.first!
            let numDeals = resultDict["sumDeals"]
            numDealsLabel.text = "\(numDeals!) total deals"
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    //MARK - UITableViewDelegate methods
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        switch cell {
        // Price section
        case cheapVenueCell:
            selectedPredicate = cheapVenuePredicate
        case moderateVenueCell:
            selectedPredicate = moderateVenuePredicate
        case expensiveVenueCell:
            selectedPredicate = expensiveVenuePredicate //Most Popular section
        case offeringDealCell:
            selectedPredicate = offeringDealPredicate
        case walkingDistanceCell:
            selectedPredicate = walkingDistancePredicate
        case userTipsCell:
            selectedPredicate = hasUserTipsPredicate
        //Sort By section
        case nameAZSortCell:
            selectedSortDescriptor = nameSortDescriptor
        case nameZASortCell: 
            selectedSortDescriptor = nameSortDescriptor.reversedSortDescriptor as? NSSortDescriptor
        case distanceSortCell:
            selectedSortDescriptor = distanceSortDescriptor
        case priceSortCell:
            selectedSortDescriptor = priceSortDescriptor
        default:
            print("default case")
        }
        cell.accessoryType = .Checkmark
    }
    
    // MARK - UIButton target action
    
    @IBAction func saveButtonTapped(sender: UIBarButtonItem) {
        
        delegate!.filterViewController(self, didSelectPredicate: selectedPredicate, sortDescriptor: selectedSortDescriptor)
        dismissViewControllerAnimated(true, completion:nil)
//        dismissViewControllerAnimated(true, completion:nil)
    }
}

protocol FilterViewControllerDelegate: class {
    func filterViewController(filter: FilterViewController,
                              didSelectPredicate predicate:NSPredicate?,
                              sortDescriptor:NSSortDescriptor?)
}
