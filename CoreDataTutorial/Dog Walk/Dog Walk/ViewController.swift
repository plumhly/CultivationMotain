//
//  ViewController.swift
//  Dog Walk
//
//  Created by Pietro Rea on 7/17/15.
//  Copyright © 2015 Razeware. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController, UITableViewDataSource {
  
  lazy var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
  }()
  
  @IBOutlet var tableView: UITableView!
  var walks:Array<Date> = []
    
    var managedContext: NSManagedObjectContext!
    
    lazy var coreDataStack = CoreDataStack()
    
    var currentDog: Dog!
    
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    tableView.register(UITableViewCell.self,
      forCellReuseIdentifier: "Cell")
    
    let dogEntity = NSEntityDescription.entity(forEntityName: "Dog", in: managedContext)!
    let dogName = "Fido"
    let dogFetch = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Dog")
    dogFetch.predicate = NSPredicate.init(format: "name == %@", dogName)
    
    do {
        let results =
        try managedContext.fetch(dogFetch) as! [Dog]
        
        if results.count > 0 {
            currentDog = results.first
        } else {
            currentDog = Dog.init(entity: dogEntity, insertInto: managedContext)
            currentDog.name = dogName
            try managedContext.save()
        }
    } catch let error as NSError {
        print("Error:\(error)" + "description \(error.localizedDescription)")
    }
    
    
    
  }
  
  func tableView(_ tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
      
      return currentDog.walks!.count
  }
  
  func tableView(_ tableView: UITableView,
    titleForHeaderInSection section: Int) -> String? {
      return "List of Walks"
  }
  
  func tableView(_ tableView: UITableView,
    cellForRowAt
    indexPath: IndexPath) -> UITableViewCell {
      
      let cell =
      tableView.dequeueReusableCell(withIdentifier: "Cell",
        for: indexPath) as UITableViewCell
    
      let walk = currentDog.walks![indexPath.row] as! Walk
      cell.textLabel!.text = dateFormatter.string(from: walk.date as! Date)
      return cell
  }
  
  @IBAction func add(_ sender: AnyObject) {
//    walks.append(Date()) 
    let walk = NSEntityDescription.insertNewObject(forEntityName: "Walk", into: managedContext) as! Walk
    walk.date = NSDate()
    let walks = currentDog.walks?.mutableCopy() as! NSMutableOrderedSet
    walks.add(walk)
    
    currentDog.walks = walks.copy() as? NSOrderedSet
    
    do {
        try managedContext.save()
    } catch let error as NSError {
        print("Could not save:\(error)")
    }
    
    tableView.reloadData()
  }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let walkToRemove = currentDog.walks![indexPath.row] as! Walk
            managedContext.delete(walkToRemove)
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save: \(error)")
            }
        }
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}

