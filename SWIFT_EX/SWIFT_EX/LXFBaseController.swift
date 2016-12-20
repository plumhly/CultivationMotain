//
//  LXFBaseController.swift
//  SWIFT_EX
//
//  Created by libo on 2016/12/20.
//  Copyright © 2016年 libo. All rights reserved.
//

import UIKit

class LXFBaseController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //是否
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.hexInt(0xf3f3f3)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isTranslucent = false
    }
}
