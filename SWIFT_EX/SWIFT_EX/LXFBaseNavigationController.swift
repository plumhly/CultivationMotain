//
//  LXFBaseNavigationController.swift
//  SWIFT_EX
//
//  Created by libo on 2016/12/20.
//  Copyright © 2016年 libo. All rights reserved.
//

import UIKit

class LXFBaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        let attribute = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 18),
            NSForegroundColorAttributeName: UIColor.hexInt(0x333333)
        ]
        UINavigationBar.appearance().tintColor = UIColor.hexInt(0x333333)
        UINavigationBar.appearance().titleTextAttributes = attribute
        
        let image = UIImage(named: "btn_back_n")?.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 18, 0, 0))
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-1000, 0), for: .default)//// 让导航条返回键带的title消失!
        UIBarButtonItem.appearance().setBackButtonBackgroundImage(image, for: .normal, barMetrics: .default)
    }

}
