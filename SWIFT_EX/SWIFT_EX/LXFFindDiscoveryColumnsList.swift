//
//  LXFFindDiscoveryColumnsList.swift
//  SWIFT_EX
//
//  Created by libo on 2016/12/25.
//  Copyright © 2016年 libo. All rights reserved.
//

import UIKit
import HandyJSON

class LXFFindDiscoveryColumnsList: HandyJSON {
    var subtitle: String?
    
    var converPath: String?
    
    var contentType: String?
    
    var title: String?
    
    var enableShare: Bool = false
    
    var isExternalURL: Bool = false
    
    var sharePic: String?
    
    var url: String?
    
    var properties: LXFFindDiscoveryColumnsProperties?
    
    
    required init() {}
}
