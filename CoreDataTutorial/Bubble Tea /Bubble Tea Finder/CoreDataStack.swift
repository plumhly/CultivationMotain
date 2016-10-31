//
//  CoreDataStack.swift
//  Dog Walk
//
//  Created by Pietro Rea on 7/18/15.
//  Copyright © 2015 Razeware. All rights reserved.
//

import CoreData

class CoreDataStack {
  
  let modelName = "Bubble_Tea_Finder"
  
  lazy var context: NSManagedObjectContext = {
    
    var managedObjectContext = NSManagedObjectContext(
      concurrencyType: .mainQueueConcurrencyType)
    
    managedObjectContext.persistentStoreCoordinator = self.psc
    return managedObjectContext
    }()
  
  private lazy var psc: NSPersistentStoreCoordinator = {
    
    let coordinator = NSPersistentStoreCoordinator(
      managedObjectModel: self.managedObjectModel)
    
    let url = self.applicationDocumentsDirectory
      .appendingPathComponent(self.modelName)
    
    do {
      let options =
      [NSMigratePersistentStoresAutomaticallyOption : true]
      
        try coordinator.addPersistentStore(
            ofType: NSSQLiteStoreType, configurationName: nil, at: url,
        options: options)
    } catch  {
      print("Error adding persistent store.")
    }
    
    return coordinator
    }()
  
  private lazy var managedObjectModel: NSManagedObjectModel = {
    
    let modelURL = Bundle.main
      .url(forResource: self.modelName,
        withExtension: "momd")!
    return NSManagedObjectModel(contentsOf: modelURL)!
    }()
  
  private lazy var applicationDocumentsDirectory: NSURL = {
    let urls = FileManager.default.urls(
        for: .documentDirectory, in: .userDomainMask)
    return urls[urls.count-1] as NSURL
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
