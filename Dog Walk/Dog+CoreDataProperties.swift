//
//  Dog+CoreDataProperties.swift
//  Dog Walk
//
//  Created by b on 16/4/15.
//  Copyright © 2016年 Razeware. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Dog {

    @NSManaged var name: String?
    @NSManaged var walks: NSOrderedSet?

}
