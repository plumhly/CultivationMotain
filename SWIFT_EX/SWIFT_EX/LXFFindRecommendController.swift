//
//  LXFFindRecommendController.swift
//  SWIFT_EX
//
//  Created by libo on 2016/12/20.
//  Copyright © 2016年 libo. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON


// MARk:- 各个section
let kFindSectionEditComment = 0 //小编推荐
let kFindSectionLive        = 1 //现场直播
let kFindSectionGuess       = 2 //猜你喜欢
let kFindSectionCityColumn  = 3 //城市歌单
let kFindSectionSpecial     = 4 //精品听单
let kFindSectionAdvertise   = 5 //推广
let kFindSectionHotComments = 6 //热门推广
let kFindSectionMore        = 7 //更多分类

// MARK:- 注册tableView的cellID
fileprivate let LXFFindCellStyleFeeId = "LXFFindCellStyleFee"
fileprivate let LXFFindCellStyleLiveID = "LXFFindCellStyleLive"
fileprivate let LXFFindCellStyleSpecialId = "LXFFindCellStyleSpecial"
fileprivate let LXFFindCellStyleMoreId = "LXFFindCellStyleMore"

class LXFFindRecommendController: LXFFindBaseController {
    // MARK:- 懒加载属性
    let headFrame:CGRect = CGRect(x: 0, y: 0, width: kScreenW, height: 250)
    
    lazy var header: LXFFindRecHeader = {
       let aHeader = LXFFindRecHeader.newInstance()
        aHeader.frame = self.headFrame
        return aHeader
    }()
    
    lazy var tableView: UITableView = {
        [unowned self]
            in
        let tab: UITableView = UITableView(frame: self.view.frame, style: .plain)
        tab.delegate = self
        tab.dataSource = self
        tab.separatorStyle = .none
        tab.tableHeaderView = self.header
        self.view.addSubview(tab)
        
        tab.register(UINib.init(nibName: LXFFindCellStyleMoreId, bundle: nil), forCellReuseIdentifier: LXFFindCellStyleFeeId)
        tab.register(UINib.init(nibName: LXFFindCellStyleLiveID, bundle: nil), forCellReuseIdentifier: LXFFindCellStyleLiveID)
        tab.register(UINib.init(nibName: LXFFindCellStyleSpecialId, bundle: nil), forCellReuseIdentifier: LXFFindCellStyleSpecialId)
        tab.register(UINib.init(nibName: LXFFindCellStyleMoreId, bundle: nil), forCellReuseIdentifier: LXFFindCellStyleMoreId)
        
        return tab
    }()
    
    /// viewModel
    lazy var viewModel: LXFFindRecViewModel = {
        return LXFFindRecViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        //刷新回调
        viewModel.updateBlock = { [unowned self] in
            self.tableView.reloadData()
            self.header.focusImgNames = self.viewModel.focusPics
            self.header.categoryModelArr = self.viewModel.headerCategory
        }
        self.viewModel.refreshDataSource()
        
    }
}

// MARK:- UITableViewDelegate & UITableViewDataSource
extension LXFFindRecommendController:UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemInSection(section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case kFindSectionEditComment:
            let cell = tableView.dequeueReusableCell(withIdentifier: LXFFindCellStyleFeeID, for: indexPath) as lxffindcell
        default:
            <#code#>
        }
    }
}
