//
//  LXFFindHeaderIconView.swift
//  SWIFT_EX
//
//  Created by libo on 2016/12/25.
//  Copyright © 2016年 libo. All rights reserved.
//

import UIKit
import SDWebImage


class LXFFindHeaderIconView: UIView {
    
    //MARK: - 连线属性
    
    @IBOutlet weak var imageIcon: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - 自定义属性
    var model: LXFFindDiscoveryColumnsList! {
        didSet {
            setupDetailModel()
        }
    }
    
    //MARK: - 创建视图
    class func newInstance() -> LXFFindHeaderIconView {
        return Bundle.main.loadNibNamed("LXFFindHeaderIconView", owner: nil, options: nil)?.first as! LXFFindHeaderIconView
    }
    
}

// Mark:- viewModel被设置后调用
extension LXFFindHeaderIconView {
    func setupDetailModel() {
        guard let title = model.title else {
            return
        }
        titleLabel.text = title
        
        guard let imageUrl = model.url else {
            return
        }
        imageIcon.sd_setImage(with: URL.init(string: imageUrl))
    }
}

// Mark:- 为了复用提供的额外方法
extension LXFFindHeaderIconView {
    func iconConfigWith(title: String, localImageName: String) {
        titleLabel.text = title
        imageIcon.image = UIImage(named: localImageName)
    }
}
