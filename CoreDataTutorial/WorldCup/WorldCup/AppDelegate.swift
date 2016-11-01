//
//  AppDelegate.swift
//  WorldCup
//
//  Created by Pietro Rea on 8/2/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  lazy var  coreDataStack = CoreDataStack()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        importJSONSeedDataIfNeeded()
        
        let navController = window!.rootViewController as! UINavigationController
        let viewController = navController.topViewController as! ViewController
        viewController.coreDataStack = coreDataStack
        
        return true
    }
  
    func applicationWillTerminate(_ application: UIApplication) {
         coreDataStack.saveContext()
    }
    
  
  
  func importJSONSeedDataIfNeeded() {
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Team")
    
    do {
        let count = try coreDataStack.context.count(for: fetchRequest)
        if count == 0 {
            importJSONSeedData()
        }
    } catch  {
        print("Error")
    }
    
  }
  
  func importJSONSeedData() {
    let jsonURL = Bundle.main.url(forResource: "seed", withExtension: "json")
    
    let jsonData = NSData(contentsOf: jsonURL!)
    
    do {
      let jsonArray = try JSONSerialization.jsonObject(with: jsonData! as Data, options: .allowFragments) as! NSArray
      let entity = NSEntityDescription.entity(forEntityName: "Team", in: coreDataStack.context)
      
      for dic in jsonArray {
        let jsonDictionary = dic as! NSDictionary
        let teamName = jsonDictionary["teamName"] as! String
        let zone = jsonDictionary["qualifyingZone"] as! String
        let imageName = jsonDictionary["imageName"] as! String
        let wins = jsonDictionary["wins"] as! NSNumber
        
        let team = Team(entity: entity!,
          insertInto: coreDataStack.context)
        team.teamName = teamName
        team.imageName = imageName
        team.qualifyingZone = zone
        team.wins = wins
      }
      
      coreDataStack.saveContext()
      print("Imported \(jsonArray.count) teams")
      
    } catch let error as NSError {
      print("Error importing teams: \(error)")
    }
  }
}

