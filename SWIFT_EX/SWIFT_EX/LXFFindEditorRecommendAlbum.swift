//
//  LXFFindEditorRecommendAlbum.swift
//  SWIFT_EX
//
//  Created by libo on 2016/12/25.
//  Copyright © 2016年 libo. All rights reserved.
//

import UIKit
import HandyJSON

class LXFFindEditorRecommendAlbum: HandyJSON {

    var title: String?
    
    var ret: Int = 0
    
    var hasMore: Bool = false
    
    var list: [LXFFindFeeDetailModel]?
    
    required init() {
        
    }
}
