//
//  ViewController.swift
//  Bubble Tea Finder
//
//  Created by Pietro Rea on 8/24/14.
//  Copyright (c) 2014 Pietro Rea. All rights reserved.
//

import UIKit
import CoreData

let filterViewControllerSegueIdentifier = "toFilterViewController"
let venueCellIdentifier = "VenueCell"

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
    var coreDataStack: CoreDataStack!
    
    var fetchRequest: NSFetchRequest<NSFetchRequestResult>!
    var venues: [Venue]!
    
    
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let model = coreDataStack.context.persistentStoreCoordinator!.managedObjectModel
    fetchRequest = model.fetchRequestTemplate(forName: "FetchRequest")
    fetchAndReload()
    
  }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == filterViewControllerSegueIdentifier {
            let navi = segue.destination as! UINavigationController
            let vc = navi.topViewController as! FilterViewController
            vc.coreDataStack = coreDataStack;
        }
    }
  
  @IBAction func unwindToVenuListViewController(segue: UIStoryboardSegue) {
    
  }
    
    func fetchAndReload() {
        do {
            venues =
            try coreDataStack.context.fetch(fetchRequest) as! [Venue]
            tableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
}

extension ViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
    return venues.count
  }

  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let venue = venues[indexPath.row] 
    
    let cell = tableView.dequeueReusableCell(withIdentifier: venueCellIdentifier)!
    cell.textLabel!.text = venue.name
    cell.detailTextLabel!.text = venue.priceInfo?.priceCategory
    
    return cell
  }
}
