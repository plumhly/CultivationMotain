//
//  AppDelegate.swift
//  Dog Walk
//
//  Created by Pietro Rea on 7/17/15.
//  Copyright © 2015 Razeware. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch
    
    let navi = window?.rootViewController as! UINavigationController
    
    let viewController = navi.topViewController as! ViewController
    
    viewController.managedContext = CoreDataStack().context
    return true
  }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        CoreDataStack().saveContext()
    }
  
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataStack().saveContext()
    }
}

