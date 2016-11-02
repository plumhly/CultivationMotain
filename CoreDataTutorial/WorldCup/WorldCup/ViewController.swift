//
//  ViewController.swift
//  WorldCup
//
//  Created by Pietro Rea on 8/2/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit
import CoreData

private let teamCellIdentifier = "teamCellReuseIdentifier"

class ViewController: UIViewController {
  
  var coreDataStack: CoreDataStack!
    var fetchedResultsController: NSFetchedResultsController <NSFetchRequestResult>!
    
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var addButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Team")
    let zoneSort = NSSortDescriptor(key: "qualifyingZone", ascending: true)
    let scoreSort = NSSortDescriptor(key: "wins", ascending: false)
    let nameSort = NSSortDescriptor(key: "teamName", ascending: true)
    fetchRequest.sortDescriptors = [zoneSort, scoreSort, nameSort]
    fetchedResultsController = NSFetchedResultsController.init(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.context, sectionNameKeyPath: "qualifyingZone", cacheName: "worldCup")
    fetchedResultsController.delegate = self
    
    do {
        try fetchedResultsController.performFetch()
    } catch let error as NSError {
        print("Error: \(error.localizedDescription)")
    }
    
    
  }
  
  func configureCell(cell: TeamCell, indexPath: NSIndexPath) {
    let team = fetchedResultsController.object(at: indexPath as IndexPath) as! Team
    
    cell.flagImageView.image = UIImage.init(named: team.imageName!)
    cell.teamLabel.text = team.teamName!
    cell.scoreLabel.text = "Wins: \(team.wins!)"
  }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (fetchedResultsController.sections?.count)!
    }
  
  func tableView(_ tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
      let items = fetchedResultsController.sections![section]
      return items.numberOfObjects
  }
  
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
      
      let cell =
        tableView.dequeueReusableCell(
            withIdentifier: teamCellIdentifier, for: indexPath)
        as! TeamCell
      
      configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
      
      return cell
  }
}

extension ViewController: UITableViewDelegate {
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let team = fetchedResultsController.object(at: indexPath) as! Team
        let count = team.wins?.intValue
        team.wins = NSNumber.init(value: count! + 1)
        coreDataStack.saveContext()
    }
    
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let info = fetchedResultsController.sections![section]
        return info.name
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            addButton.isEnabled = true
        }
    }
    
    @IBAction func addTeam(sender: AnyObject) {
        let alert = UIAlertController.init(title: "Secret Team", message: "Add Name", preferredStyle: .alert)
        
        alert.addTextField { (field: UITextField) in
            field.placeholder = "Team Name"
        }
        
        alert.addTextField { (field: UITextField) in
            field.placeholder = "Qualifying Zone"
        }
        
        alert.addAction(UIAlertAction.init(title: "Save", style: .default, handler: { [unowned self](action: UIAlertAction) in
            print("Saved")
            let nameTextField = alert.textFields?.first
            let zoneTextField = alert.textFields?.last
            
            let team = NSEntityDescription.insertNewObject(forEntityName: "Team", into: self.coreDataStack.context) as! Team
            
            team.teamName = nameTextField?.text
            team.qualifyingZone = zoneTextField?.text
            team.imageName = "wenderland-flag"
            self.coreDataStack.saveContext()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension ViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
            
        case .delete:
            tableView.deleteRows(at: [newIndexPath!], with: .automatic)
            
        case .update:
            let cell = tableView.cellForRow(at: indexPath!) as! TeamCell
            configureCell(cell: cell, indexPath: indexPath! as NSIndexPath)
            
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let indexSet = NSIndexSet.init(index: sectionIndex)
        switch type {
        case .insert:
            tableView.insertSections(indexSet as IndexSet, with: .automatic)
            
        case .delete:
            tableView.deleteSections(indexSet as IndexSet, with: .automatic)
        default:
            break
        }
    }
}
