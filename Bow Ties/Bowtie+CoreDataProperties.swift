//
//  Bowtie+CoreDataProperties.swift
//  Bow Ties
//
//  Created by b on 16/4/14.
//  Copyright © 2016年 Razeware. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Bowtie {

    @NSManaged var isFavorite: NSNumber?
    @NSManaged var lastWorn: NSDate?
    @NSManaged var rating: NSNumber?
    @NSManaged var searchKey: String?
    @NSManaged var timesWorn: NSNumber?
    @NSManaged var name: String?
    @NSManaged var photoData: NSData?
    @NSManaged var tintColor: NSObject?

}
