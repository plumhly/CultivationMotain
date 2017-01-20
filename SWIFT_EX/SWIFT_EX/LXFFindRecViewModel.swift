//
//  LXFFindRecViewModel.swift
//  SWIFT_EX
//
//  Created by libo on 2016/12/25.
//  Copyright © 2016年 libo. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class LXFFindRecViewModel: NSObject {
    // MARK:- 网络请求Model属性
    //小编推荐
    var editorRecAlbum: LXFFindEditorRecommendAlbum!
    //轮番图
    var focusImages: LXFFindFocusImages!
    //精品歌单
    var special: LXFFindSpecialColumn!
    //分类
    var discoverColumn: LXFFindDiscoveryColumns?
    //猜你喜欢
    var guess: LXFFindGuess?
    //听北京
    var cityColumn: LXFFindCityColumn?
    //热门推荐
    var hotRecommends: LXFFindHotRecommends?
    //现场直播
    var list: Array<LXFFindLive?> = []
    
    // MARK:- 对数据处理的属性
    
    //轮播图URL
    var focusPics = [String]()
    //分类
    var headerCategory = [LXFFindDiscoveryColumnsList]()
    
    // MARK:- 数据更新回调
    typealias AddBlock = () -> Void
    var updateBlock = AddBlock?()
    
    
}

// MARK:- 加载数据
extension LXFFindRecViewModel {
    func refreshDataSource() {
        //加载recommend API
        LXFFindAPI.requestRecommends {[unowned self] (result, error) in
            
            if error != nil {
                return
            }
            let json = JSON(result)
            
            // 小编推荐
            let editorRecAlbum = JSONDeserializer<LXFFindEditorRecommendAlbum>.deserializeFrom(json: json["editorRecommendAlbums"].description)
            
            // 轮播图
            let focusImage = JSONDeserializer<LXFFindFocusImages>.deserializeFrom(json: json["focusImages"].description)
            
            // 精品听单
            let special = JSONDeserializer<LXFFindSpecialColumn>.deserializeFrom(json: json["spacialColumn"].description)
            
            self.editorRecAlbum = editorRecAlbum
            self.focusImages = focusImage
            self.special = special
            
            /* =============================== 处理数据 ============================= */
            
            /// 遍历取出轮播图
            if let list = focusImage?.list {
                for item in list {
                    self.focusPics.append(item.pic ?? "")
                }
            }
            // 更新tableView数据
            self.updateBlock?()
        }
        
        // 加载 HotAndGuessAPI
        LXFFindAPI.requstHotAndGuess { [unowned self](result, error) in
            if error != nil {
                return
            }
            let json = JSON(result)
            
            //分类
            let category = JSONDeserializer<LXFFindDiscoveryColumns>.deserializeFrom(json: json["discoveryColumns"].description)
            
            //猜你喜欢
            let guess = JSONDeserializer<LXFFindGuess>.deserializeFrom(json: json["guess"].description)
            
            //听北京
            let city = JSONDeserializer<LXFFindCityColumn>.deserializeFrom(json: json["cityColumn"].description)
            
            //热门推荐
            let hot = JSONDeserializer<LXFFindHotRecommends>.deserializeFrom(json: json["hotRecommends"].description)
            
            self.discoverColumn = category
            self.guess = guess
            self.cityColumn = city
            self.hotRecommends = hot
            /* =============================== 处理数据 ============================= */
            
            //分类
            if let list = category?.list {
                self.headerCategory = list
            }
            
            // 更新tableView数据
            self.updateBlock?()
        }
        
        //加载直播
        LXFFindAPI.requestLiveRecommend { [unowned self](result, error) in
            if error != nil {
                return
            }
            
            let json = JSON(result)
            
            if let liveArray  = JSONDeserializer<LXFFindLive>.deserializeModelArrayFrom(json: json["data"].description) {
                self.list = liveArray
            }
            // 更新tableView数据
            self.updateBlock?()
        }
    }
}


// MARK:- 各section的高度
let kSectionHeight: CGFloat = 230
let kSectionSpecialHeight: CGFloat = 219
let kSectionLiveHeight: CGFloat = 227
let kSectionMoreHeight: CGFloat = 60

// MARK:- tableView的数据
extension LXFFindRecViewModel {
    func numberOfSections() -> Int {
        return 8
    }
    
    func numberOfItemInSection(_ section: Int) -> Int {
        switch section {
        case kFindSectionEditComment: //小编推荐
            return 1
            
        case kFindSectionLive: //直播
            return list.count == 0 ? 0:1
            
        case kFindSectionGuess: //猜你喜欢
            guard guess != nil else {
                return 0
            }
            return guess?.list?.count == 0 ? 0 : 1
            
        case kFindSectionCityColumn: //城市歌曲
            guard cityColumn != nil else {
                return 0
            }
            return cityColumn?.list?.count == 0 ? 0 : 1
            
        case kFindSectionSpecial: //精品歌单
            guard cityColumn != nil else {
                return 0
            }
            return cityColumn?.list?.count == 0 ? 0:1
            
        case kFindSectionAdvertise: //推广
            return 0
            
        case kFindSectionHotComments: //热门推荐
            guard hotRecommends != nil else {
                return 0
            }
            return hotRecommends?.lsit?.count == 0 ? 0 : 1
            
        case kFindSectionMore: //更多
            return 1
        default:
            return 0
        }
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case kFindSectionEditComment: //小编推荐
            return kSectionHeight
            
        case kFindSectionLive: //直播
            return list.count == 0 ? 0: kSectionLiveHeight
            
        case kFindSectionGuess: //猜你喜欢
            guard guess != nil else {
                return 0
            }
            return guess?.list?.count == 0 ? 0 : kSectionHeight
            
        case kFindSectionCityColumn: //城市歌曲
            guard cityColumn != nil else {
                return 0
            }
            return cityColumn?.list?.count == 0 ? 0 : kSectionHeight
            
        case kFindSectionSpecial: //精品歌单
            guard cityColumn != nil else {
                return 0
            }
            return cityColumn?.list?.count == 0 ? 0:kSectionSpecialHeight
            
        case kFindSectionAdvertise: //推广
            return 0
            
        case kFindSectionHotComments: //热门推荐
            guard hotRecommends != nil else {
                return 0
            }
            return hotRecommends?.lsit?.count == 0 ? 0 : kSectionHeight
            
        case kFindSectionMore: //更多
            return kSectionMoreHeight
        default:
            return 0

        }
    }
    
}
