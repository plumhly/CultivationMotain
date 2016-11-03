//
//  RWTImageTransformer.swift
//  UnCloudNotes
//
//  Created by Richard Turton on 25/07/2014.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

import Foundation
import UIKit

class ImageTransformer : ValueTransformer {
    
  override class func transformedValueClass() -> AnyClass {
    return Data.self as! AnyClass

  }
  
  override class func allowsReverseTransformation() -> Bool {
    return true
  }
  
  override func reverseTransformedValue(_ value: Any?) -> Any? {
    if let data = value as? Data {
        return UIImage(data: data)
    }
    return nil
  }
  
  override func transformedValue(_ value: Any?) -> Any? {
    if let image = value as? UIImage {
        return UIImagePNGRepresentation(image)
    }
    return nil
  }
        
}
