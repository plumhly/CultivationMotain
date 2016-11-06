//
//  AttachmentToImageAttachmentMigrationPolicyV3toV4.swift
//  UnCloudNotes
//
//  Created by libo on 16/11/6.
//  Copyright © 2016年 plum. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class AttachmentToImageAttachmentMigrationPolicyV3toV4: NSEntityMigrationPolicy {
    
    override func createDestinationInstances(forSource sInstance: NSManagedObject, in mapping: NSEntityMapping, manager: NSMigrationManager) throws {
        //1
        let newAttachment = NSEntityDescription.insertNewObject(forEntityName: "ImageAttachment", into: manager.destinationContext) as? ImageAttachment
        
        //2
        func traversePropertyMappings(block: (NSPropertyMapping) ->()) throws {
            if let attributeMappings = mapping.attributeMappings {
                for property in attributeMappings {
                    if property.name != nil {
                        block(property);
                    } else {
                        //3
                        let message = "Attribute destination not configured properly"
                        let userInfo = [NSLocalizedFailureReasonErrorKey: message]
                        throw NSError.init(domain: "Domain", code: 0, userInfo: userInfo)
                    }
                }
            } else {
                let message = "No Attribute Mappings found!"
                let userInfo = [NSLocalizedFailureReasonErrorKey: message]
                throw NSError.init(domain: "Domain", code: 0, userInfo: userInfo)
            }
        }
        
        //4 这里仅仅解决从 source 提供的数据。也就是property, 添加的属性，自己想办法
       try traversePropertyMappings { (property) in
            if let valueEx = property.valueExpression {
                let context: NSMutableDictionary = ["source" : sInstance]
                var destinationValue: Any = valueEx.expressionValue(with: sInstance, context: context) as Any
                if property.name == "dateCreated" {
                    destinationValue = destinationValue as! Date as AnyObject
                }
                
                if property.name == "image" {
                    destinationValue = destinationValue as! UIImage
                }
                newAttachment?.setValue(destinationValue, forKey: property.name!)
            }
        }
        
        //5 添加的属性
        if let image = sInstance.value(forKey: "image") as? UIImage {
            newAttachment?.setValue(image.size.width, forKey: "width")
            newAttachment?.setValue(image.size.height, forKey: "height")
        }
        
        //6 添加的属性
        let body = sInstance.value(forKeyPath: "note.body") as! NSString
        newAttachment?.setValue(body.substring(to: 80), forKey: "caption")
        
        //7
        manager.associate(sourceInstance: sInstance, withDestinationInstance: newAttachment!, for: mapping)
        
    }
}
