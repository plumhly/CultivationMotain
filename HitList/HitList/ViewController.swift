//
//  ViewController.swift
//  HitList
//
//  Created by plum on 2016/10/28.
//  Copyright © 2016年 plum. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    var people = [NSManagedObject]()
    
    var managerContext: NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "\"The List\""
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let fetchResult = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let result = try managerContext.fetch(fetchResult)
            people = result as! [NSManagedObject]
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    

    @IBAction func addName(_ sender: AnyObject) {
        let alert = UIAlertController.init(title: "New Name", message: "Add a new name", preferredStyle:.alert)
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Enter name"
        }
        let saveAction = UIAlertAction.init(title: "Save", style: .default) { (action: UIAlertAction) -> Void in
            let textField = alert.textFields?.first
            if let name = textField?.text {
                self.saveName(name: name)
                self.tableview.reloadData()
            }
        
        }
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .default) { (action: UIAlertAction) in
            
        }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveName(name: String) {
        
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managerContext)
        let person = NSManagedObject.init(entity: entity!, insertInto: managerContext)
        person.setValue(name, forKey: "name")
        do {
            try managerContext.save()
            people.append(person)
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview .dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let person = people[indexPath.row]
        cell.textLabel!.text = person.value(forKey: "name") as? String
        return cell;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

}

