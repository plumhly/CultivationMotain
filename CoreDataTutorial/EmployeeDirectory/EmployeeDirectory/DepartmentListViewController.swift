/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import CoreData

class DepartmentListViewController:
  UITableViewController {
  
  var coreDataStack: CoreDataStack!
  var items = [[String:String]]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    items = totalEmployeesPerDepartmentFast()
  }

  func totalEmployeesPerDepartment()
    -> [[String:String]] {
    
    //1
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
    var fetchResults: [AnyObject] = []
    do {
      fetchResults =
        try coreDataStack.context.fetch(fetchRequest)
    } catch let error as NSError {
      print("ERROR: \(error.localizedDescription)")
      return [[String:String]]()
    }
      
    //2
    var uniqueDepartments = [String:Int]()
    for object in fetchResults {
      
      let employee = object as! Employee
      
      if let employeeDepartmentCount =
        uniqueDepartments[employee.department] {
          
          uniqueDepartments[employee.department] =
            employeeDepartmentCount + 1
          
      } else {
        uniqueDepartments[employee.department] = 1
      }
    }
    
    //3
    var results = [[String:String]]()
    for (department, headCount) in uniqueDepartments {
      
      let departmentDictionary:[String:String] =
      ["department":department,
        "headCount":String(headCount)]
      
      results.append(departmentDictionary)
    }
    
    return results
  }
  
   func totalEmployeesPerDepartmentFast() -> [[String : String]] {
    //1
    let expressionDescription = NSExpressionDescription.init()
    expressionDescription.name = "headCount"
    
    //2
    expressionDescription.expression = NSExpression.init(forFunction: "count:", arguments: [NSExpression.init(forKeyPath: "department")])
    
    //3
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Employee")
    fetchRequest.propertiesToFetch = ["department", expressionDescription]
    fetchRequest.propertiesToGroupBy = ["department"]
    fetchRequest.resultType = .dictionaryResultType
    
    //4
    do {
     let fetchRequsts = try coreDataStack.context.fetch(fetchRequest)
      return fetchRequsts as! [[String : String]]
    } catch let error as NSError {
      print("ERROR: \(error.localizedDescription)")
      return [[String : String]]()
    }
  }

  
  //MARK: Segues
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier ==
      "SegueDepartmentListToDepartmentDetails" {
      
      let indexPath = tableView.indexPath(for: sender
        as! UITableViewCell)!
      let departmentDictionary = items[indexPath.row]
      let department = departmentDictionary["department"]
      
      let viewController = segue.destination
        as! DepartmentDetailsViewController
      viewController.coreDataStack = coreDataStack
      viewController.department = department
      
    } else if segue.identifier ==
      "SegueDepartmentsListToEmployeeList" {
      
      let indexPath = tableView.indexPathForSelectedRow!
      let departmentDictionary = items[indexPath.row]
      let department = departmentDictionary["department"]
      
      let viewController = segue.destination
        as! EmployeeListViewController
      viewController.coreDataStack = coreDataStack
      viewController.department = department
    }
  }
  

  //MARK: UITableViewDataSource
  
  override func tableView(_ tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let departmentDictionary:[String:String] =
      items[indexPath.row]
    
    let cell =
      tableView.dequeueReusableCell(
        withIdentifier: "DepartmentCellReuseIdentifier",
        for: indexPath as IndexPath) as UITableViewCell
    
    cell.textLabel!.text = departmentDictionary["department"]
    cell.detailTextLabel!.text =
      departmentDictionary["headCount"]
    
    return cell
  }
  
  
  
}
