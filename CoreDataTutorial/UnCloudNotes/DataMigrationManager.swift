//
//  DataMigrationManager.swift
//  UnCloudNotes
//
//  Created by libo on 16/11/6.
//  Copyright © 2016年 plum. All rights reserved.
//

import Foundation
import CoreData
import UIKit

//目录结构   UnCloudNotesDataModel.momd(文件夹) -》 1.各种版本的数据库 xx.mom； 2 versionInfo.plist （currentModel）



class DataMigrationManager: NSManagedObjectModel {
    let storeName: String
    let modelName: String
    var options: NSDictionary?
    var stack: CoreDataStack {
        if !storeIsCompatibleWith(Model: currentModel) {
            performMigration()
        }
        return CoreDataStack.init(modelName: modelName, storeName: storeName, options: options)
    }
    
    lazy var storeURL: NSURL = {
       var storePaths = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)
        let firstStorePath = String(describing: storePaths.first) as NSString
        let storePath = firstStorePath.appendingPathComponent(self.storeName + ".sqlite") 
        return NSURL.fileURL(withPath: storePath) as NSURL
    }()
    
    
    lazy var storeModel : NSManagedObjectModel? = {
        for model in DataMigrationManager.modelVersionsForName(name: self.modelName) {
                if self.storeIsCompatibleWith(Model:model) {
                    print("Store \(self.storeURL) is compatible with model\(model.versionIdentifiers)")
                    return model
                }
        }
        print("Unable to determine storeModel")
        return nil
    }()
    
    
    lazy var currentModel: NSManagedObjectModel = {
        if let modeUrl = Bundle.main.url(forResource: self.modelName, withExtension: "momd") {
            return NSManagedObjectModel.init(contentsOf: modeUrl) ?? NSManagedObjectModel()
        }
        return NSManagedObjectModel()
    }()
    
    
    init(storeName: String, modelName: String) {
       
        self.modelName = modelName
        self.storeName = storeName
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.modelName = ""
        self.storeName = ""
        super.init(coder: aDecoder)
    }
    
    
    
    // 存储器是否兼容model
    func storeIsCompatibleWith(Model model: NSManagedObjectModel) -> Bool {
        let storeMetadata = metadataForStoreAtURL(storeURL: storeURL)
        return model.isConfiguration(withName: nil, compatibleWithStoreMetadata: storeMetadata)
        
    }
    
    //根据url获取原始数据
    func metadataForStoreAtURL(storeURL: NSURL) -> [String: AnyObject] {
        let metadata: [String: AnyObject]?
        
        do {
            metadata = try NSPersistentStoreCoordinator.metadataForPersistentStore(ofType: NSSQLiteStoreType, at: storeURL as URL) as [String : AnyObject]?
        } catch let error as NSError {
            metadata = nil
            print("Error retrieving metadata for store at URL: \(storeURL):\(error)")
        }
        return metadata ?? [:]
    }
    
    func performMigration() {
        if !isVersion4() {
            fatalError("Can only handle migrations to version 4!")
        }
        
        if let storeModel = self.storeModel {
            if storeModel == DataMigrationManager.version1(){
                options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true];
            } else {
                options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: false];
            }
            
            
            if storeModel == DataMigrationManager.version1() {
                let destinatonModel = DataMigrationManager.version2()
                migrateStoreAt(URL: storeURL, fromModel: storeModel, toModel: destinatonModel)
                performMigration()
            } else if storeModel == DataMigrationManager.version2() {
                let destinatonModel = DataMigrationManager.version3()
                let mappingModel = NSMappingModel.init(from: nil, forSourceModel: storeModel, destinationModel: destinatonModel)
                migrateStoreAt(URL: storeURL, fromModel: storeModel, toModel: destinatonModel,mappingModel:mappingModel)
                performMigration()
            }else if storeModel == DataMigrationManager.version3() {
                let destinatonModel = DataMigrationManager.version4()
                let mappingModel = NSMappingModel.init(from: nil, forSourceModel: storeModel, destinationModel: destinatonModel)
               migrateStoreAt(URL: storeURL, fromModel: storeModel, toModel: destinatonModel,mappingModel:mappingModel)
                performMigration()
            }
        }
    }
    
    
}



extension DataMigrationManager {
   class func modelVersionsForName(name: String) -> [NSManagedObjectModel] {
        let urls = Bundle.main.urls(forResourcesWithExtension: "mom", subdirectory: "\(name).momd") ?? []
        return urls.map({
            NSManagedObjectModel(contentsOf:$0)
        }).filter ({ $0 != nil })
        .map ({ $0! })
    }
    
    class func uncloudNotesModelNamed(name:String) -> NSManagedObjectModel {
        if let modelUrl = Bundle.main.url(forResource: name, withExtension: "mom", subdirectory:"UnCloudNotesDataModel.momd") {
            return NSManagedObjectModel.init(contentsOf: modelUrl) ?? NSManagedObjectModel()
        }
        return NSManagedObjectModel()
    }
    
    class func version1() -> NSManagedObjectModel {
        return uncloudNotesModelNamed(name:"UnCloudNotesDataModel.momd")
    }
    
    
    func isVersion1() -> Bool {
        return self == type(of: self).version1()
    }
    
    class func version2() -> NSManagedObjectModel {
        
        return uncloudNotesModelNamed(name: "UnCloudNotesDataModel v2")
        
    }
    
    func isVersion2() -> Bool {
        
        return self == type(of: self).version2()
        
    }
    
    class func version3() -> NSManagedObjectModel {
        
        return uncloudNotesModelNamed(name: "UnCloudNotesDataModel v3")
        
    }
    
    func isVersion3() -> Bool {
        
        return self == type(of: self).version3()
        
    }
    
    class func version4() -> NSManagedObjectModel {
        
        return uncloudNotesModelNamed(name: "UnCloudNotesDataModel v4")
        
    }
    
    func isVersion4() -> Bool {
        
        return self == type(of: self).version4()
        
    }
    
    static func == (firstModel: DataMigrationManager, otherModel: NSManagedObjectModel) -> Bool {
        let myEntities = firstModel.entitiesByName
        let others = otherModel.entitiesByName
        return NSDictionary.init(dictionary: myEntities).isEqual(to: others)
    }
    
    func migrateStoreAt(URL storeURL:NSURL, fromModel from: NSManagedObjectModel, toModel to: NSManagedObjectModel, mappingModel:NSMappingModel? = nil) {
        
        //1
        let migrationManager = NSMigrationManager.init(sourceModel: from, destinationModel: to)
        
        //2
        var migrationMappingModel: NSMappingModel
        if let mappingModel = mappingModel{
            migrationMappingModel = mappingModel
        } else {
            migrationMappingModel = try! NSMappingModel.inferredMappingModel(forSourceModel: from, destinationModel: to)
        }
        
        //3
        let destinationURL = storeURL.deletingLastPathComponent
        let destinationName = storeURL.lastPathComponent! + "~" + "1"
        let destination = destinationURL?.appendingPathComponent(destinationName)
        print("From model:\(from.versionIdentifiers)")
        print("To model:\(to.versionIdentifiers)")
        print("Migrating Store:\(storeURL) to \(destination)")
        print("Mapping model:\(mappingModel)")
        
        
        //4
        let success: Bool
        do {
            try migrationManager.migrateStore(from: storeURL as URL, sourceType: NSSQLiteStoreType, options: nil, with: migrationMappingModel, toDestinationURL: destination!, destinationType: NSSQLiteStoreType, destinationOptions: nil)
            success = true
        } catch let error as NSError {
            success = false
            NSLog("Migration failed \(error)")
        }
        
        
        //5
        if success {
            print("Migration Completed Successfully")
            let fileManager = FileManager.default
            do {
                try fileManager.removeItem(at: storeURL as URL)
                try fileManager.moveItem(at: destination!, to: storeURL as URL)
            } catch let error as NSError {
                NSLog("Migration failed \(error)")
            }
            
        }
        
    }
    
}
