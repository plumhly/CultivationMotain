//
//  Walk+CoreDataProperties.swift
//  Dog Walk
//
//  Created by plum on 2016/10/31.
//  Copyright © 2016年 Razeware. All rights reserved.
//

import Foundation
import CoreData

extension Walk {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Walk> {
        return NSFetchRequest<Walk>(entityName: "Walk");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var dog: Dog?

}
