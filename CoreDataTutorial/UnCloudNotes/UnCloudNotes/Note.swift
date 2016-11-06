//
//  Note.swift
//  UnCloudNotes
//
//  Created by Saul Mora on 6/16/14.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Note : NSManagedObject
{
    @NSManaged var title : NSString!
    @NSManaged var body : NSString!
    @NSManaged var dateCreated: Date!
    @NSManaged var displayIndex: NSNumber!
    @NSManaged var attachments: NSSet

    override func awakeFromInsert()
    {
      super.awakeFromInsert()
      dateCreated = Date()
        
    }
    
    var lastestAttachment: ImageAttachment? {
        let attachmentsToSort = attachments.map {
            $0 as? ImageAttachment
        }.filter {
            $0 != nil
        }.map {
            $0!
        }.sorted { (first, seconde) -> Bool in
            let date1 = first.dateCreated.timeIntervalSinceReferenceDate
            let date2 = seconde.dateCreated.timeIntervalSinceReferenceDate
            return date1 > date2
        }
        return attachmentsToSort.first
    }
    
    var image: UIImage? {
        return lastestAttachment?.image
    }
    
    
}
