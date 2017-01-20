//
//  LXFFindCityColumn.swift
//  SWIFT_EX
//
//  Created by libo on 2016/12/25.
//  Copyright © 2016年 libo. All rights reserved.
//

import UIKit
import HandyJSON

class LXFFindCityColumn: HandyJSON {

    var title: String?
    
    var code: String?
    
    var contentType: String?
    
    
    var count: Int = 0
    
    
    var hasMore: Bool = false
    
    
    var list: [LXFFindFeeDetailModel]?
    
    required init() {

    }
}
