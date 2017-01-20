//
//  LXFSubFindFactory.swift
//  SWIFT_EX
//
//  Created by libo on 2016/12/20.
//  Copyright © 2016年 libo. All rights reserved.
//

import Foundation

enum LXFSubFindType {
    case LXFSubFindTypeRecommend   //推荐
    case LXFSubFindTypeCategory    //分类
    case LXFSubFindTypeRadio       //广播
    case LXFSubFindTypeRand        //榜单
    case LXFSubFindTypeAchor       //主播
    case LXFSubFindTypeUnkown      //未知
}

class LXFSubFindFactory: NSObject {
   class func subFindVCWithIdentifier(_ indentifier: String) -> LXFBaseController {
//    let type = typeFromTitle(indentifier)
//    
        return LXFBaseController()
    }
    
     // MARK:- 根据唯一标识符查找对应类型
    private func typeFromTitle(_ title: String) -> LXFSubFindType {
        switch title {
        case "推荐":
            return .LXFSubFindTypeRecommend
        case "分类":
            return .LXFSubFindTypeCategory
        case "广播":
            return .LXFSubFindTypeRadio
        case "榜单":
            return .LXFSubFindTypeRand
        case "主播":
            return .LXFSubFindTypeAchor
        default:
            return .LXFSubFindTypeUnkown
        }
    }
}
