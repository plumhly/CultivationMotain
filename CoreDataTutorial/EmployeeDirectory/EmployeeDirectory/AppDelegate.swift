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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  lazy var coreDataStack = CoreDataStack()

  let amountToImport = 50
  let addSalesRecords = true

  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    
    importJSONSeedDataIfNeeded()
    
    let tabController = window!.rootViewController
      as! UITabBarController
    let employeeListNavigationController =
      tabController.viewControllers![0]
        as! UINavigationController
    let employeeListViewController =
      employeeListNavigationController.topViewController
        as! EmployeeListViewController
    employeeListViewController.coreDataStack = coreDataStack
    
    let departmentListNavigationController =
      tabController.viewControllers![1]
        as! UINavigationController
    let departmentListViewController =
      departmentListNavigationController.topViewController
        as! DepartmentListViewController
    departmentListViewController.coreDataStack = coreDataStack
    
    return true
    
  }
  
  func applicationWillTerminate(application: UIApplication) {
    coreDataStack.saveContext()
  }
  
  
  //MARK: Data Import
  
  func importJSONSeedDataIfNeeded() {
    var importRequired = false

    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
    var error: NSError? = nil
    let employeeCount = try? coreDataStack.context.count(for: fetchRequest)
    
    if employeeCount != amountToImport {
      importRequired = true
    }

    if !importRequired && addSalesRecords {
      let salesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Sale")
      var salesError : NSError? = nil
      let salesCount =
        try? coreDataStack.context.count(for: salesFetch)
      if salesCount == 0 {
        importRequired = true
      }
    }

    if importRequired {
      
      let deleteRequest =
        NSBatchDeleteRequest(fetchRequest: fetchRequest)
      deleteRequest.resultType = .resultTypeCount
      
      let deletedObjectCount: Int
      do {
        let resultBox = try coreDataStack.context
          .execute(deleteRequest)
            as! NSBatchDeleteResult
        deletedObjectCount = resultBox.result as! Int
      } catch {
        let nserror = error as NSError
        print("Error: \(nserror.localizedDescription)")
        abort()
      }
      
      print("Removed \(deletedObjectCount) objects.")
      coreDataStack.saveContext()
      let records = max(0, min(500, amountToImport))
      importJSONSeedData(records: records)
    }
  }
  
  func importJSONSeedData(records: Int) {
    
    let jsonURL = Bundle.main.url(forResource: "seed",
      withExtension: "json")!
    let jsonData = NSData(contentsOf: jsonURL)!
    
    var jsonArray = NSArray()
    do {
      jsonArray = try JSONSerialization
        .jsonObject(with: jsonData as Data, options: []) as! NSArray
    } catch let error as NSError {
      print("Error: \(error.localizedDescription)")
      abort()
    }
    
    let entity =
      NSEntityDescription.entity(forEntityName: "Employee",
                                 in: coreDataStack.context)!
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    var counter = 0
    for jsonDic in jsonArray {
      
      counter += 1
      
      let jsonDictionary = jsonDic as! NSDictionary
      let guid = jsonDictionary.value(forKey: "guid") as! String
      let active = jsonDictionary.value(forKey: "active") as! Bool
      let name = jsonDictionary.value(forKey:"name") as! String
      let vacationDays =
        jsonDictionary.value(forKey: "vacationDays") as! Int
      let department =
        jsonDictionary.value(forKey:"department") as! String
      let startDate =
        jsonDictionary.value(forKey:"startDate") as! String
      let email = jsonDictionary.value(forKey:"email") as! String
      let phone = jsonDictionary.value(forKey:"phone") as! String
      let address =
        jsonDictionary.value(forKey:"address") as! String
      let about =
        jsonDictionary.value(forKey:"about") as! String
      let picture =
        jsonDictionary.value(forKey:"picture") as! String
      let pictureComponents = picture.components(separatedBy: ".")
      let pictureFileName = pictureComponents[0] as String
      let pictureFileExtension = pictureComponents[1] as String
      let pictureURL = Bundle.main.url(forResource: pictureFileName, withExtension: pictureFileExtension)!
      let pictureData = NSData(contentsOf: pictureURL)!
      
      let employee = Employee(entity: entity,
        insertInto: coreDataStack.context)
      employee.guid = guid
      employee.active = NSNumber(value: active)
      employee.name = name
      employee.vacationDays = NSNumber(value: vacationDays)
      employee.department = department
      employee.startDate =
        dateFormatter.date(from: startDate)! as NSDate
      employee.email = email
      employee.phone = phone
      employee.address = address
      employee.about = about
      employee.pictureThumbnail = imageDataScaledToHeight(imageData: pictureData, height: 120)
      
      let employeePictureEntity = NSEntityDescription.insertNewObject(forEntityName: "EmployeePicture", into: coreDataStack.context) as? EmployeePicture
      employeePictureEntity?.picture = pictureData
      employee.picture = employeePictureEntity!
      
      
      
      if addSalesRecords {
        addSalesRecordsToEmployee(employee: employee)
      }
      
      if counter == records {
        break
      }
      
      if counter % 20 == 0 {
        coreDataStack.saveContext()
        coreDataStack.context.reset()
      }
    }
    
    coreDataStack.saveContext()
    coreDataStack.context.reset()
    print("Imported \(counter) employees.")
  }
  
  func imageDataScaledToHeight(imageData: NSData,
    height: CGFloat) -> NSData {
      
      let image = UIImage(data: imageData as Data)!
      let oldHeight = image.size.height
      let scaleFactor = height / oldHeight
      let newWidth = image.size.width * scaleFactor
      let newSize = CGSize.init(width: newWidth, height: height)
      let newRect = CGRect.init(x: 0, y: 0, width: newWidth, height: height)
      
      UIGraphicsBeginImageContext(newSize)
      image.draw(in: newRect)
      let newImage =
        UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      
      return UIImageJPEGRepresentation(newImage!, 0.8)! as NSData
  }
  
  func addSalesRecordsToEmployee(employee:Employee) {
    let numberOfSales = 1000 + arc4random_uniform(5000)
    for _ in 0...numberOfSales {
      let sale =
        NSEntityDescription.insertNewObject(
          forEntityName: "Sale", into: coreDataStack.context)
           as! Sale
      sale.employee = employee
      sale.amount = NSNumber(value:3000 + arc4random_uniform(20000))
    }
    print("added \(employee.sales.count) sales")
  }

}

