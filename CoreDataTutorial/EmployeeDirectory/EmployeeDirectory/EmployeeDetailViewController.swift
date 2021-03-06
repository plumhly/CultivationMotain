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

class EmployeeDetailViewController: UIViewController {
  
  @IBOutlet var headShotImageView: UIImageView!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var departmentLabel: UILabel!
  @IBOutlet var emailLabel: UILabel!
  @IBOutlet var phoneNumberLabel: UILabel!
  @IBOutlet var startDateLabel: UILabel!
  @IBOutlet var vacationDaysLabel: UILabel!
  @IBOutlet var salesCountLabel: UILabel!
  @IBOutlet var bioTextView: UITextView!
  
  let dateFormatter = DateFormatter()
  
  var employee: Employee? {
    didSet {
      configureView()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    configureView()
  }
  
  func configureView() {
    if let employee: Employee = employee {
      
      title = employee.name
      
      if let imageView = headShotImageView {
        let image = UIImage(data: employee.pictureThumbnail as Data)
        imageView.image = image
      }
      
      if let label = nameLabel {
        label.text = employee.name
      }
      
      if let label = departmentLabel {
        label.text = employee.department
      }
      
      if let label = emailLabel {
        label.text = employee.email
      }
      
      if let label = phoneNumberLabel {
        label.text = employee.phone
      }
      
      if let label = startDateLabel {
        label.text =
          dateFormatter.string(from: employee.startDate as Date)
      }
      
      if let label = vacationDaysLabel {
        label.text = String(employee.vacationDays.intValue)
      }
      
      if let textView = bioTextView {
        textView.text = employee.about
      }
      
      if let label = salesCountLabel {
        label.text = salesCountForEmployeeSimple(employee: employee)
      }
    }
  }
  
  func salesCountForEmployee(employee:Employee) -> String {
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Sale")
    let predicate =
      NSPredicate(format: "employee == %@", employee)
    fetchRequest.predicate = predicate
//    fetchRequest.requestType = 
    let context = employee.managedObjectContext!
    do {
      let results =
        try context.fetch(fetchRequest)
      return "\(results.count)"
    } catch let error as NSError {
      print("Error: \(error.localizedDescription)")
      return "0"
    }

  }
  
  func salesCountForEmployeeFast(employee:Employee) -> String {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Sale")
    let predicate = NSPredicate.init(format: "employee == %@",employee)
    fetchRequest.predicate = predicate
    
    let context = employee.managedObjectContext!
    do {
      let result = try context.count(for: fetchRequest)
      return "\(result)"
    } catch let error as NSError {
      print("error %@",error)
    }
    return "0"
  }
  
  func salesCountForEmployeeSimple(employee:Employee) -> String {
    return "\(employee.sales.count)"
  }
  
  //MARK: Segues
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier ==
      "SegueEmployeeDetailToEmployeePicture" {
      (segue.destination
        as! EmployeePictureViewController).employee = employee
    }
  }
}
