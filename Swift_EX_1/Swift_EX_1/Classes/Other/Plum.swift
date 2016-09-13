//
//  File.swift
//  Swift_EX_1
//
//  Created by plum on 16/9/13.
//  Copyright © 2016年 plum. All rights reserved.
//

import Foundation
import UIKit

//屏幕高
let screenHeight = UIScreen.mainScreen().bounds.height

//屏幕宽
let screenWidth = UIScreen.mainScreen().bounds.width

//屏幕尺寸
let screenScale = UIScreen.mainScreen().bounds

//是否是iphone 6p
let isIphone6P = (screenHeight == 736)

//是否是iphone6
let isIphone6 = (screenHeight == 667)

//是否是iphone 5
let isIphone5 = (screenHeight == 568)

//是否是iphone 4 or 4s
let isIphone4 = (screenHeight == 480)

//商城界面请求路径
let shopUrl: String = "http://m.ds.xiangha.com/v1/home?fr1=ds_home_entry1"

//广告请求路径
let adUrl = "http://mobads.baidu.com/cpro/ui/mads.php"

//学做菜界面请求路径
let cookUrl = "http://api.xiangha.com/main6/index/baseData"

//精彩生活圈请求路径
let lifeUrl = "http://api.xiangha.com/main6/index/getTieList"

//精彩生活圈更多数据请求路径
let lifeMoreUrl = "http://101.201.172.223/main6/index/getTieList"

//菜谱界面请求路径
let menuUrl = "http://101.201.172.223/main5/caipu/getDishList"

//广告请求参数
let adCode2 = "phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3Ln-tkQW08nau_I1Y1P1Rhmhwz5Hb8nz3zFMTqP1RsFMKo5yPEUi43py78uv99QMKzUzu9TZfqrau9mvnqf-w5Fhq15y-ETzubuy3qnBuzug7xpyfqmHf4nAP9PhwWmW9WP17-mhfYuH7bPj7buWR1mWmYnhchUy7s5HDhIywGujd9mW7bmymkPWmzuhczuHFWnHwhPAN9PyD4PhfsrjT4PWFbmhc4nAPbFMPLpHYkFh7sTA-b5ymLPAczmyuhFhPdTWYsFMKzuykEmyfqnauGuAu95RRYnW-DPjndQH04wH6VPDw7PaY3PHKAQH6kfbP7PW0vPjfswBu9mLfqHbD_H70_wDshTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhu-IjdcNDdnQD7rNDb_HNPHRau_pjYdPWThmgKGujYzPjcYPWcdFh7s5H0hIhfqniusThqb5gF1TAk9Tv6hTv3qwHfzrRfYn1RVnj-7raYYwDRYQH6dnDmVrj7afYRvnjmYPjKAFh7sTZu-TWYkFhPV5HRknBuYUHYdnHchULK9mv-YXHYkFMwzuMws5gPbpdt1QWTzFh7Y5HchpjYknHnYFMws5y-fpAq8uH6_niuYmycqnau1IjYkPjmvn1cvnH0YPHTYQW6kPauVmybqnauBnHfvPWnzPWDsPjYkFMP-UWdDiNn_fb7nQ7PPRzkPfN0_Nbf_RY95Q7PFHBkHHdR_fRPjQDdFfzkZR7n_fYqPQD7iQ7uDHikPNDt_wD-iFMP9UjYhmLnqPAf1rymvrAcLnvF9njubuhDLn1RYPj7WmW--nWmvrj0hTvwW5HTLra3srHnLPH0_nHD4rHc8rj0sP16kFh3qniu1Ugnqniu1I1YLPH0hUhqs5Hfvnj0zFhd-UHYLP168njb1P1RsQjDkrHbzQW6snjT3niuk5ymLPAczmyuhgvPsTBu_my4bTvP9TARqnamb"

//Cook界面Plist文件名
let cookPlistFileName = (NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0] as NSString).stringByAppendingString("cook.plist")

func plumColor(r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
    let color = UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    return color
}


///  Red alpha : 0.7
let redBackgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.7)
///  Black alpha : 0.9
let blackBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
///  Black alpha : 0.7
let blackBackgroundColor2 = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)

/// Orange alpha : 0.8
let orangeBackgroundColor = UIColor (red: 255/255.0, green: 82/255.0, blue: 60/255.0, alpha: 0.8)
/// Orange alpha : 0.9
let orangeBackgroundColor2 = UIColor (red: 255/255.0, green: 82/255.0, blue: 60/255.0, alpha: 0.9)

//collectionView 背景颜色
let collectionViewBackgroundColor = plumColor(241, 239, 228)

// topView 背景颜色
let topViewBackgroundColor = plumColor(245, 245, 245)

// border 颜色
let borderColor = UIColor(white: 0.5, alpha: 1)

//通知
let lifeNotification = "LIFE"

/**
 根据透明度生成背景颜色
 
 - parameter alpha: 透明度
 
 - returns: 颜色
 */
func orangeColorWithAlpha(alpha: CGFloat) -> UIColor {
    let color = UIColor (red: 255/255.0, green: 82/255.0, blue: 60/255.0, alpha: alpha)
    return color
}






