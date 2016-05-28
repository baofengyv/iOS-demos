//
//  SearchTableViewController.swift
//  UISearchController
//
//  Created by b on 16/5/28.
//  Copyright © 2016年 b. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController,UISearchResultsUpdating {

    let appleProducts = ["Mac","iPhone","iPad","Apple Watch"]
    var filteredAppleProducts = [String]()
    var resultSearchController:UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultSearchController = UISearchController(searchResultsController: nil)
        
        // 使用下面的 updateSearchResultsForSearchController 更新数据
        self.resultSearchController.searchResultsUpdater = self
        self.resultSearchController.searchBar.sizeToFit()
        
        // 将 搜索框 作为tableView最上方的附加view
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(tableView)")
        if self.resultSearchController.active {
            return self.filteredAppleProducts.count
//            return 0
        } else {
            return self.appleProducts.count
//            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        if self.resultSearchController.active {
            cell.textLabel?.text = self.filteredAppleProducts[indexPath.row]
        } else {
            cell.textLabel?.text = self.appleProducts[indexPath.row]
        }
        
        return cell
    }
 
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.filteredAppleProducts.removeAll(keepCapacity: false) //不保持数组的容量
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        
        let array = (self.appleProducts as NSArray).filteredArrayUsingPredicate(searchPredicate)
        
        self.filteredAppleProducts = array as! [String]
        
        self.tableView.reloadData()
    }
}