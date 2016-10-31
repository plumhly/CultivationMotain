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
    
    
    var currentBowtie: Bowtie!
    
    
    
    var managedContex: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertSampleData()
        
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Bowtie")
        let firstTile = segmentedControl.titleForSegment(at: 0)
        
        request.predicate = NSPredicate.init(format: "searchKey == %@", firstTile!)
        
        do {
            let aResult =
            try managedContex.execute(request)
            let result = aResult as! NSAsynchronousFetchResult<NSFetchRequestResult>
            let results = result.finalResult as! [Bowtie]
            currentBowtie = results.first
            populate(bowtie: currentBowtie)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populate(bowtie: Bowtie) {
        imageView.image = UIImage.init(data: bowtie.photoData! as Data)
        nameLabel.text = bowtie.name
        ratingLabel.text = "Rating:\(bowtie.rating)"
        
        timesWornLabel.text = "# times worn: \(bowtie.timesWorn)"
        
        let dataFormatter = DateFormatter.init()
        dataFormatter.dateStyle = .short
        dataFormatter.timeStyle = .none
        
        lastWornLabel.text = "Last worn: " + dataFormatter.string(from: bowtie.lastWorn as! Date)
        favoriteLabel.isHidden = bowtie.isFavorite
        view.tintColor = bowtie.tintColor as! UIColor
        
    }
    
    
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        
    }
    
   
    
    @IBAction func wear(_ sender: AnyObject) {
        currentBowtie.timesWorn += 1
        currentBowtie.lastWorn = NSDate()
        
        do {
            try managedContex.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
            
        }
        populate(bowtie: currentBowtie)
    }
    

    @IBAction func rate(_ sender: AnyObject) {
        let alert = UIAlertController.init(title: "New Rating", message: "Rate this bow tie", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .default, handler: nil)
        let saveAction = UIAlertAction.init(title: "Save", style: .default) { (action: UIAlertAction) in
            let textField = alert.textFields?.first
            self.updateRating(numberic: (textField?.text)!)
        }
        
        alert.addTextField { (textField: UITextField) in
            textField.keyboardType = .numberPad
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        present(alert, animated: true, completion: nil)
        
        
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
        
        for dic in dataArray  {
            let entity = NSEntityDescription.insertNewObject(forEntityName: "Bowtie", into: managedContex) as! Bowtie
            let aDic = dic as! NSDictionary
            
            entity.name = aDic["name"] as? String
            entity.searchKey = aDic["searchKey"] as? String
            entity.rating = aDic["rating"] as! Double
            let tintColorDict = aDic["tintColor"] as! NSDictionary
            entity.tintColor = colorFromDic(dic: tintColorDict)
            
            let imageName = aDic["imageName"] as! String
            let image = UIImage.init(named: imageName)
            let data = UIImagePNGRepresentation(image!)
            entity.photoData = data as? NSData
        
    
            entity.lastWorn = aDic["lastWorn"] as? NSDate
            entity.timesWorn = (aDic["timesWorn"] as? Int32)!
            entity.isFavorite = (aDic["isFavorite"] as? Bool)!
        }
    }
    
    func colorFromDic(dic: NSDictionary) -> UIColor {
        let red = dic["red"] as! NSNumber
        let green = dic["green"] as! NSNumber
        let blue = dic["blue"] as! NSNumber
        
        let color = UIColor.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
        return color
    }
    
    func updateRating(numberic: String) {
        currentBowtie.rating = (numberic as NSString).doubleValue
        do {
            try managedContex.save()
        } catch let error as NSError {
            
            print("Could not save \(error), \(error.userInfo)")
            
        }
    }

}

