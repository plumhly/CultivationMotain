//
//  LXFFindHotRecommendsList.swift
//  SWIFT_EX
//
//  Created by libo on 2016/12/25.
//  Copyright © 2016年 libo. All rights reserved.
//

import UIKit
import HandyJSON

class LXFFindHotRecommendsList: HandyJSON {

    var title: String?
    
    var contentType: String?
    
    
    var hasMore: Bool = false
    
    var isPaid: Bool = false
    
    var isFinished: Bool = false
    
    var filterSupported: Bool = false
    
    
    var count: Int = 0
    
    var categoryId: Int = 0
    
    var categoryType: Int = 0
    
    
    var list: [LXFFindFeeDetailModel]?
    
    required init() {
        
    }
}
