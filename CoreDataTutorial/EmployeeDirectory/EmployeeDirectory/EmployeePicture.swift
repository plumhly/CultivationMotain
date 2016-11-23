//
//  EmployeePicture.swift
//  EmployeeDirectory
//
//  Created by libo on 2016/11/22.
//  Copyright © 2016年 Razeware. All rights reserved.
//

import Foundation
import CoreData


class EmployeePicture: NSManagedObject {
  @NSManaged var picture: NSData
  @NSManaged var employee:Employee
}
