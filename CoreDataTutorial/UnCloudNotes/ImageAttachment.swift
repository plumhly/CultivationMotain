//
//  ImageAttachment.swift
//  UnCloudNotes
//
//  Created by libo on 16/11/6.
//  Copyright © 2016年 plum. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ImageAttachment: Attachment {
    @NSManaged var image: UIImage?
    
    @NSManaged var width: CGFloat
    
    @NSManaged var height: CGFloat
    
    @NSManaged var caption: NSString
}
