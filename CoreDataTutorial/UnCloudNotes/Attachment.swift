//
//  Attachment.swift
//  UnCloudNotes
//
//  Created by libo on 16/11/6.
//  Copyright © 2016年 plum. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Attachment: NSManagedObject {
    @NSManaged var dateCreated: NSDate
    @NSManaged var image: UIImage?
    @NSManaged var note: Note
}
