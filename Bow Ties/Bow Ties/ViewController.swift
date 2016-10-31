//
//  ViewController.swift
//  Bow Ties
//
//  Created by libo on 16/10/29.
//  Copyright © 2016年 libo. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ViewController: UIViewController {

    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var timesWornLabel: UILabel!
    @IBOutlet weak var lastWornLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    
    
    var managedContex: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        
    }
    
   
    
    @IBAction func wear(_ sender: AnyObject) {
        
        
    }
    

    @IBAction func rate(_ sender: AnyObject) {
        
    }
    
    func insertSampleData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Bowtie")
        fetchRequest.predicate = NSPredicate.init(format: "searchKey != nil")
        do {
            let count = try managedContex.count(for: fetchRequest)
            if count > 0 {
                return
            }
        } catch let error as NSError {
            print("\(error)")
        }
        let path = Bundle.main.path(forResource: "SampleData", ofType: "plist")
        let dataArray = NSArray.init(contentsOfFile: path!)!
        
        for dic: Any in dataArray as! [Any] {
            let entity = NSEntityDescription.insertNewObject(forEntityName: "Bowtie", into: managedContex) as! Bowtie
            let aDic = dic as Dictionary
            
            entity.name = aDic["name"] as! String
            entity.searchKey = aDic["searchKey"] as! String

            
            
        }
        
        
    }
    

}

