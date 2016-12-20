//
//  LXFPlayViewController.swift
//  SWIFT_EX
//
//  Created by libo on 2016/12/20.
//  Copyright © 2016年 libo. All rights reserved.
//

import UIKit

class LXFPlayViewController: LXFBaseController {
    static let shareInstanced: LXFBaseController = {
        let playVc = LXFBaseController()
        return playVc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置导航栏
        configNavigationBar()
    }
}

extension LXFPlayViewController {
    func configNavigationBar() {
        //左侧按钮
        let leftBtn = UIButton(type: .custom)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        leftBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        leftBtn.setImage(UIImage.init(named: "navidrop_arrow_down_h"), for: .normal)
        leftBtn.addTarget(self, action: #selector(backBtnClick(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBtn)
        
        //右侧按钮
        let rightBtn = UIButton(type: .custom)
        rightBtn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20)
        rightBtn.setImage(UIImage.init(named: "icon_share_h"), for: .normal)
        rightBtn.addTarget(self, action: #selector(shareBtnClick(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
    }
}

// MARK: - 监听事件
extension LXFPlayViewController {
    //导航栏左侧按钮
    func backBtnClick(_ button: UIButton) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    //导航栏右侧按钮
    func shareBtnClick(_ button: UIButton) {
        LXFLog("shareBtnClick:")
    }
}
