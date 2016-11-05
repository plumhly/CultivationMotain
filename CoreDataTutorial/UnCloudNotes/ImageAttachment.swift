//
//  ImageAttachment.swift
//  UnCloudNotes
//
//  Created by libo on 16/11/5.
//  Copyright © 2016年 Ray Wenderlich. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ImageAttachment: Attachment {
    @NSManaged var image: UIImage?
    @NSManaged var width: CGFont
    @NSManaged var height: CGFont
    @NSManaged var caption: NSString
}
