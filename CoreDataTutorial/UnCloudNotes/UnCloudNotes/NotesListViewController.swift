//
//  ViewController.swift
//  UnCloudNotes
//
//  Created by Saul Mora on 6/10/14.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

import UIKit
import CoreData

class NotesListViewController: UITableViewController, NSFetchedResultsControllerDelegate {
  lazy var stack : CoreDataStack = CoreDataStack(modelName:"UnCloudNotesDataModel", storeName:"UnCloudNotes")
  
  lazy var notes : NSFetchedResultsController <NSFetchRequestResult> = {
      let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Note")
      request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
      let notes = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.stack.context, sectionNameKeyPath: nil, cacheName: nil)
      notes.delegate = self
      return notes
  }()
  
  override func viewWillAppear(_ animated: Bool){
    super.viewWillAppear(animated)
    do {
      try notes.performFetch()
    } catch let error as NSError {
      print("Error fetching data \(error)")
    }
    tableView.reloadData()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let objects = notes.fetchedObjects
    return objects?.count ?? 0
  }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath as IndexPath) as? NoteTableViewCell {
            if let objects = notes.fetchedObjects
            {
                cell.note = objects[indexPath.row] as? Note
            }
            return cell
        }
        return UITableViewCell()
    }
    
  
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
  
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        let indexPathsFromOptionals: (IndexPath?) -> [IndexPath] = { indexPath in
            if let indexPath = indexPath {
                return [indexPath]
            }
            return []
        }
        
        switch type
        {
        case .insert:
            tableView.insertRows(at: indexPathsFromOptionals(newIndexPath), with: .automatic)
        case .delete:
            tableView.deleteRows(at: indexPathsFromOptionals(indexPath), with: .automatic)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
    
  
  @IBAction
  func unwindToNotesList(segue:UIStoryboardSegue) {
    NSLog("Unwinding to Notes List")

    if stack.context.hasChanges
    {
      do {
        try stack.context.save()
      } catch let error as NSError {
        print("Error saving context: \(error)")
      }
    }
  }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createNote"
        {
            let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            context.parent = stack.context
            if let navController = segue.destination as? UINavigationController {
                if let nextViewController = navController.topViewController as? CreateNoteViewController {
                    nextViewController.managedObjectContext = context
                }
            }
        }
        if segue.identifier == "showNoteDetail" {
            if let detailView = segue.destination as? NoteDetailViewController {
                if let selectedIndex = tableView.indexPathForSelectedRow {
                    if let objects = notes.fetchedObjects {
                        detailView.note = objects[selectedIndex.row] as? Note
                    }
                }
            }
        }
    }
    
}
