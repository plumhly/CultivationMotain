//
//  Dog+CoreDataProperties.swift
//  Dog Walk
//
//  Created by plum on 2016/10/31.
//  Copyright © 2016年 Razeware. All rights reserved.
//

import Foundation
import CoreData


extension Dog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dog> {
        return NSFetchRequest<Dog>(entityName: "Dog");
    }

    @NSManaged public var name: String?
    @NSManaged public var walks: NSOrderedSet?

}

// MARK: Generated accessors for walks
extension Dog {

    @objc(insertObject:inWalksAtIndex:)
    @NSManaged public func insertIntoWalks(_ value: NSManagedObject, at idx: Int)

    @objc(removeObjectFromWalksAtIndex:)
    @NSManaged public func removeFromWalks(at idx: Int)

    @objc(insertWalks:atIndexes:)
    @NSManaged public func insertIntoWalks(_ values: [NSManagedObject], at indexes: NSIndexSet)

    @objc(removeWalksAtIndexes:)
    @NSManaged public func removeFromWalks(at indexes: NSIndexSet)

    @objc(replaceObjectInWalksAtIndex:withObject:)
    @NSManaged public func replaceWalks(at idx: Int, with value: NSManagedObject)

    @objc(replaceWalksAtIndexes:withWalks:)
    @NSManaged public func replaceWalks(at indexes: NSIndexSet, with values: [NSManagedObject])

    @objc(addWalksObject:)
    @NSManaged public func addToWalks(_ value: NSManagedObject)

    @objc(removeWalksObject:)
    @NSManaged public func removeFromWalks(_ value: NSManagedObject)

    @objc(addWalks:)
    @NSManaged public func addToWalks(_ values: NSOrderedSet)

    @objc(removeWalks:)
    @NSManaged public func removeFromWalks(_ values: NSOrderedSet)

}
