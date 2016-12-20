//
//  LXFFindViewController.swift
//  SWIFT_EX
//
//  Created by libo on 2016/12/20.
//  Copyright © 2016年 libo. All rights reserved.
//

import UIKit

// MARK: - 全局变量 - 当前navigationController
class LXFFindViewController: LXFBaseController {
    
    // MARK: - 懒加载属性
    ///子标题
    lazy var subTitles: [String] = {
        return ["推荐", "分类", "广播", "榜单", "主播"]
    }()
    
    ///子控制器
    lazy var controllers: [UIViewController] = {
        [unowned self] in
        var cons: [UIViewController] = [UIViewController]()
        for title in self.subTitles {
           let con = 
        }
        
        
        return cons
    }()
    
    func <#name#>() ->  {
        
    }
}
