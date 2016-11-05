//
//  Attachment.swift
//  UnCloudNotes
//
//  Created by libo on 16/11/5.
//  Copyright © 2016年 Ray Wenderlich. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Attachment: NSManagedObject {
    @NSManaged var dateCreated: NSDate!
    @NSManaged var note: Note
}
