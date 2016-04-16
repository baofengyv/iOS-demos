//
//  CoreDataStack.swift
//  Dog Walk
//
//  Created by b on 16/4/15.
//  Copyright © 2016年 Razeware. All rights reserved.
//

import CoreData
class CoreDataStack {
    
    let modelName = "Dog Walk"
    
//    MAKR: 以下组件是相互依赖的 都设置成lazy 当需要的时候自动全部初始化
    
    // 获得应用的document文件夹的路径
    private lazy var applicationDocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(
            .DocumentDirectory,
            inDomains: .UserDomainMask
        )
        return urls[urls.count-1]
    }()
 
    
    //1 NSManagedObjectContext
    lazy var context: NSManagedObjectContext = {
        var managedObjectContext = NSManagedObjectContext(
            concurrencyType: .MainQueueConcurrencyType
        )
        managedObjectContext.persistentStoreCoordinator = self.psc
        return managedObjectContext
    }()
    
    
    //2 NSPersistentStoreCoordinator
    private lazy var psc: NSPersistentStoreCoordinator = {
        
        let coordinator = NSPersistentStoreCoordinator(
            managedObjectModel: self.managedObjectModel
        )
        
        let url = self.applicationDocumentsDirectory
            .URLByAppendingPathComponent(self.modelName)
        
        do {
            let options =
                [NSMigratePersistentStoresAutomaticallyOption : true]
            try coordinator.addPersistentStoreWithType(
                NSSQLiteStoreType,
                configuration: nil,
                URL: url,
                options: options
            )
        } catch {
            print("Error adding persistent store.")
        }
        
        return coordinator
    }()
    
    //3 NSManagedObjectModel
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource(self.modelName,
                                                             withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                print("Error: \(error.localizedDescription)")
                abort()
            }
        }
    }
    
}