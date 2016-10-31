//
//  CoreDataStack.swift
//  Dog Walk
//
//  Created by plum on 2016/10/31.
//  Copyright © 2016年 Razeware. All rights reserved.
//

import Foundation
import CoreData
import UIKit

//关系图
//                             | --> model
// context -->  coordinator -->|
//                             | --> persistenceStore



class CoreDataStack {
    let modelName = "Dog Walk"
    
    private lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    lazy var context: NSManagedObjectContext = {
        var managedObjectCotext = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
        managedObjectCotext.persistentStoreCoordinator = self.psc
        return managedObjectCotext
    }()
    
    private lazy var psc: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator.init(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent(self.modelName)
        do {
            let options = [NSMigratePersistentStoresAutomaticallyOption : true]
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url,
                options: options)
        } catch  {
            print("Error adding persistent store.")
        }
        return coordinator
    }()
    
    public lazy var managedObjectModel: NSManagedObjectModel = {
        let modelUrl = Bundle.main.url(forResource: self.modelName, withExtension: "momd")!
        return NSManagedObjectModel.init(contentsOf: modelUrl)!
    }()
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                print("Error: \(error.localizedDescription)")
                abort()//终止程序
            } 
        }
    }
}


