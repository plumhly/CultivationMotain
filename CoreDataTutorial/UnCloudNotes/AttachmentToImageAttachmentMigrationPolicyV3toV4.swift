//
//  AttachmentToImageAttachmentMigrationPolicyV3toV4.swift
//  UnCloudNotes
//
//  Created by libo on 16/11/5.
//  Copyright © 2016年 Ray Wenderlich. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AttachmentToImageAttachmentMigrationPolicyV3toV4: NSEntityMigrationPolicy {
    
    
    override func createDestinationInstances(forSource sInstance: NSManagedObject, in mapping: NSEntityMapping, manager: NSMigrationManager) throws {
        //1
        let newAttachment = NSEntityDescription.insertNewObject(forEntityName: "ImageAttachment", into: manager.destinationContext)
        
        //2
        
        func traversePropertyMappings(block: (NSPropertyMapping) -> ()) throws {
            if let attributeMappings = mapping.attributeMappings {
                for propertyMapping in attributeMappings {
                    if propertyMapping.name != nil {
                        block(propertyMapping)
                    } else {
                        //3
                        let message = "Attribute destination not configuredproperly"
                        let userinfo = [NSLocalizedFailureReasonErrorKey: message]
                        throw NSError.init(domain: "domain", code: 0, userInfo: userinfo)
                        
                    }
                }
            } else {
                let message = "No Attribute Mappings found!"
                let userinfo = [NSLocalizedFailureReasonErrorKey: message]
                throw NSError.init(domain: "domain", code: 0, userInfo: userinfo)
                
                
            }
        }
        
        //4
       try  traversePropertyMappings { (propertyMapping) in
        if let valueExpression = propertyMapping.valueExpression {
            let context: NSMutableDictionary = ["source": sInstance]
            let destinationValue: AnyObject = valueExpression.expressionValue(with: sInstance, context: context) as AnyObject
            if let name = propertyMapping.name {
                newAttachment.setValue(destinationValue, forKey: name)
            }
        }
      }
        //5
       if let image = sInstance.value(forKey: "image") as? UIImage {
            newAttachment.setValue(image.size.width, forKey: "width")
            newAttachment.setValue(image.size.height, forKey: "height")
        }
        
        //6
        let body = sInstance.value(forKeyPath: "note.body") as! NSString
        newAttachment.setValue(body.substring(to: 80), forKey: "caption")
        
        //7
        manager.associate(sourceInstance: sInstance, withDestinationInstance: newAttachment, for: mapping)
        
    }
}
