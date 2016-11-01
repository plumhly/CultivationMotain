//
//  FilterViewController.swift
//  Bubble Tea Finder
//
//  Created by Pietro Rea on 8/27/14.
//  Copyright (c) 2014 Pietro Rea. All rights reserved.
//

import UIKit
import CoreData

protocol FilterViewControllerDelegate: class {
    func filterViewController(filter: FilterViewController, didSelectPredicate predicate: NSPredicate?, sortDescription: NSSortDescriptor?)
}

class FilterViewController: UITableViewController {
  
  @IBOutlet weak var firstPriceCategoryLabel: UILabel!
  @IBOutlet weak var secondPriceCategoryLabel: UILabel!
  @IBOutlet weak var thirdPriceCategoryLabel: UILabel!
  @IBOutlet weak var numDealsLabel: UILabel!
  
  //Price section
  @IBOutlet weak var cheapVenueCell: UITableViewCell!
  @IBOutlet weak var moderateVenueCell: UITableViewCell!
  @IBOutlet weak var expensiveVenueCell: UITableViewCell!
  
  //Most popular section
  @IBOutlet weak var offeringDealCell: UITableViewCell!
  @IBOutlet weak var walkingDistanceCell: UITableViewCell!
  @IBOutlet weak var userTipsCell: UITableViewCell!
  
  //Sort section
  @IBOutlet weak var nameAZSortCell: UITableViewCell!
  @IBOutlet weak var nameZASortCell: UITableViewCell!
  @IBOutlet weak var distanceSortCell: UITableViewCell!
  @IBOutlet weak var priceSortCell: UITableViewCell!
  

    var coreDataStack: CoreDataStack!
    
    lazy var cheapVenuePredicate: NSPredicate = {
        var predicate = NSPredicate.init(format: "priceInfo.priceCategory == %@", "$")
        return predicate
    }()
    
    lazy var moderateVenuePredicate: NSPredicate = {
        var predicate = NSPredicate(format: "priceInfo.priceCategory == %@", "$$")
        return predicate
    }()
    
    lazy var expensiveVenuePredicate: NSPredicate = {
        var predicate = NSPredicate.init(format: "priceInfo.priceCategory == %@", "$$$")
        return predicate
    }()
    
    weak var delegate: FilterViewControllerDelegate?
    var selectedSortDescriptor: NSSortDescriptor?
    var selectedPredicate: NSPredicate?
    
    lazy var offeringDealPredicate: NSPredicate = {
       let pr = NSPredicate.init(format: "specialCount > 0")
       return pr
    }()
    
    lazy var walkingDistancePredicate: NSPredicate = {
        let pr = NSPredicate.init(format: "location.distance < 500")
        return pr
    }()
    
    lazy var hasUserTipsPredicate: NSPredicate = {
        let pr = NSPredicate.init(format: "stats.tipCount > 0")
        return pr
    }()
    
    lazy var nameSortDescriptor: NSSortDescriptor = {
        let sort = NSSortDescriptor.init(key: "name", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        return sort
    }()
    
    lazy var distanceSortDescriptor: NSSortDescriptor = {
        let sort = NSSortDescriptor.init(key: "location.distance", ascending: true)
        return sort
    }()
    
    lazy var priceSortDescriptor: NSSortDescriptor = {
        let sort = NSSortDescriptor.init(key: "priceInfo.priceCategory", ascending: true)
        return sort
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateCheapVenueCountLabel()
        populateModerateVenueCountLabel()
        populateExpensiveVenueCountLabel()
        populateDealsCountLabel()
    }
    
  //MARK - UITableViewDelegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        
        switch cell {
        case cheapVenueCell:
            selectedPredicate = cheapVenuePredicate
            
        case moderateVenueCell:
            selectedPredicate = moderateVenuePredicate
            
        case expensiveVenueCell:
            selectedPredicate = expensiveVenuePredicate
            
        case offeringDealCell:
            selectedPredicate = offeringDealPredicate
            
        case walkingDistanceCell:
            selectedPredicate = walkingDistancePredicate
            
        case userTipsCell:
            selectedPredicate = hasUserTipsPredicate
            
        case nameAZSortCell:
            selectedSortDescriptor = nameSortDescriptor
            
        case nameZASortCell:
            selectedSortDescriptor = nameSortDescriptor.reversedSortDescriptor as? NSSortDescriptor
            
        case distanceSortCell:
            selectedSortDescriptor = distanceSortDescriptor
            
        case priceSortCell:
            selectedSortDescriptor = priceSortDescriptor
        default:
            print("default case")
        }
        cell.accessoryType = .checkmark
    }
  
  // MARK - UIButton target action
  
  @IBAction func saveButtonTapped(sender: UIBarButtonItem) {
    delegate?.filterViewController(filter: self, didSelectPredicate: selectedPredicate, sortDescription: selectedSortDescriptor)
    dismiss(animated: true, completion:nil)
  }
    
    func populateCheapVenueCountLabel() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Venue")
        fetchRequest.resultType = .countResultType
        fetchRequest.predicate = cheapVenuePredicate
        
        do {
            let results =
            try coreDataStack.context.fetch(fetchRequest) as! [NSNumber]
            let count = results.first!.intValue
            firstPriceCategoryLabel.text = "\(count) bubble tea places"
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func populateModerateVenueCountLabel() {
        
        // $$ fetch request
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Venue")
        fetchRequest.resultType = .countResultType
        fetchRequest.predicate = moderateVenuePredicate
        do {
            let results =
                try coreDataStack.context.fetch(fetchRequest) as! [NSNumber]
            let count = results.first!.intValue
            secondPriceCategoryLabel.text = "\(count) bubble tea places"
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func populateExpensiveVenueCountLabel() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Venue")
        fetchRequest.predicate = expensiveVenuePredicate
        
        do {
            let count =
               try coreDataStack.context.count(for: fetchRequest)
            thirdPriceCategoryLabel.text = "\(count) bubble tea places"
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func populateDealsCountLabel() {
        let fetchRequset = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Venue")
        fetchRequset.resultType = .dictionaryResultType
        
        let sumExp = NSExpressionDescription.init()
        sumExp.name = "sumDeals"
        
        sumExp.expression = NSExpression.init(forFunction: "sum:", arguments: [NSExpression.init(forKeyPath: "specialCount")])
        
        sumExp.expressionResultType = .integer32AttributeType
        fetchRequset.propertiesToFetch = [sumExp]
        
        do {
            let results = try coreDataStack.context.fetch(fetchRequset) as! [NSDictionary]
            let dic = results.first
            let numDeals = dic?["sumDeals"]
            numDealsLabel.text = "\(numDeals!) total deals"
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
}

