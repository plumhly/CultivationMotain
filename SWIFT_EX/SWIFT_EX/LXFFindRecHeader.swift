//
//  LXFFindRecHeader.swift
//  SWIFT_EX
//
//  Created by libo on 2016/12/24.
//  Copyright © 2016年 libo. All rights reserved.
//

import UIKit
import SDCycleScrollView

let kCycleViewH: CGFloat = 150
let cateIconW: Double = 71
let cateIconH: Double = 90


class LXFFindRecHeader: UIView, SDCycleScrollViewDelegate{
    
    // MARK: - 连接属性
    
    //广告轮播图
    @IBOutlet weak var adverScrollView: UIView!
    
    //下方的类别轮播图
    @IBOutlet weak var cateScrollView: UIScrollView!
    
    // MARK: - 定义属性
    ///轮播图model
    var focusImgNames: [String]! {
        didSet {
            setupCycleView()
        }
    }
    
    var categoryModelArr: [LXFFindDiscoveryColumnsList]! {
        didSet {
            setupCategorys()
        }
    }
    
    class func newInstance() -> LXFFindRecHeader {
        return Bundle.main.loadNibNamed("LXFFindRecHeader", owner: nil, options: nil)?.first as! LXFFindRecHeader
    }
    

}

extension LXFFindRecHeader {
    //设置轮番图
    func setupCycleView() {
        _ = adverScrollView.subviews.map {
            $0.removeFromSuperview()
        }
        //添加轮番图
        if  let cycleview = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kCycleViewH), delegate: self, placeholderImage: nil) {
            cycleview.showPageControl = false
            cycleview.imageURLStringsGroup = focusImgNames
            addSubview(cycleview)
        }
    }
    
    //设置分类
    func setupCategorys() {
        _ = cateScrollView.subviews.map({
            $0.removeFromSuperview()
        })
        
        let headCategoryCount: Double = Double(categoryModelArr.count)
        if headCategoryCount == 0 {
            return
        }
        
        //添加分类按钮
        cateScrollView.contentSize = CGSize(width: headCategoryCount * cateIconW, height: cateIconH)
        for index in 0..<categoryModelArr.count {
            let detailModel = categoryModelArr[index]
            let iconView = LXFFindHeaderIconView.newInstance()
            iconView.frame = CGRect(x: Double(index) * cateIconW, y: 0, width: cateIconW, height: cateIconH)
            iconView.model = detailModel
            cateScrollView.addSubview(iconView)
        }
    }
}

// Mark:- SDCycleScrollViewDelegate
extension LXFFindRecHeader {
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        LXFLog("点击了\(index+1)张图片")
    }
}
