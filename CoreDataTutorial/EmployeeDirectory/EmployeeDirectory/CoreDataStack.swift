/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import CoreData

class CoreDataStack {
  
  let modelName = "EmployeeDirectory"
  
  lazy var applicationDocumentsDirectory: NSURL = {
    let urls = FileManager.default.urls(
      for: .documentDirectory, in: .userDomainMask)
    return urls[urls.count-1] as NSURL
  }()
  
  lazy var managedObjectModel: NSManagedObjectModel = {
    let modelURL = Bundle.main
      .url(forResource: self.modelName,
        withExtension: "momd")!
    return NSManagedObjectModel(contentsOf: modelURL)!
  }()
  
  lazy var psc: NSPersistentStoreCoordinator = {
    let coordinator = NSPersistentStoreCoordinator(
      managedObjectModel: self.managedObjectModel)
    let url =
      self.applicationDocumentsDirectory
      .appendingPathComponent(self.modelName + ".sqlite")
    let walURL = self.applicationDocumentsDirectory
      .appendingPathComponent(self.modelName + ".sqlite-wal")
    let shmURL = self.applicationDocumentsDirectory
      .appendingPathComponent(self.modelName + ".sqlite-shm")
    
    do {
      try coordinator.addPersistentStore(
        ofType: NSSQLiteStoreType, configurationName: nil, at: url,
          options: nil)
    } catch {
      print("Model has changed, removing.")
      do {
        try FileManager.default.removeItem(at: url!)
        try FileManager.default.removeItem(at: walURL!)
        try FileManager.default.removeItem(at: shmURL!)
        do {
          try coordinator.addPersistentStore(
            ofType: NSSQLiteStoreType, configurationName: nil, at: url,
            options: nil)
        } catch {
          let nserror = error as NSError
          print("Error: \(nserror.localizedDescription)")
          abort()
        }
      } catch {
        let nserror = error as NSError
        print("Error removing persistent store: \(nserror)")
        abort()
      }
    }
    
    return coordinator
  }()
  
  lazy var context: NSManagedObjectContext = {
    var managedObjectContext = NSManagedObjectContext(
      concurrencyType: .mainQueueConcurrencyType)
    managedObjectContext.persistentStoreCoordinator = self.psc
    return managedObjectContext
  }()
  
  func saveContext () {
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        print("Error: \(nserror.localizedDescription)")
        abort()
      }
    }
  }
}

