//
//  AppDelegate.swift
//  UnCloudNotes
//
//  Created by Saul Mora on 6/10/14.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    if let splitController = window?.rootViewController as? UISplitViewController {
      splitController.delegate = self
    }
    return true
  }
  
  func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
    if let secondaryAsNoteDetail = secondaryViewController as? NoteDetailViewController {
      if secondaryAsNoteDetail.note == nil {
        // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return true
      }
    }
    return false
  }
  
}

