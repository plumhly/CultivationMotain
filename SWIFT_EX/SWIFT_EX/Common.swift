//
//  Common.swift
//  SWIFT_EX
//
//  Created by libo on 2016/12/15.
//  Copyright © 2016年 libo. All rights reserved.
//

import Foundation
import UIKit

//当前系统版本
let kCersion = (UIDevice.current.systemVersion as NSString).floatValue

//屏幕宽度
let kScreenW = UIScreen.main.bounds.width

//屏幕高度
let kScreenH = UIScreen.main.bounds.height

// Mark:- 颜色方法
func RGBA (r: CGFloat, g: CGFloat, b: CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}


// Mark:- 自定义打印方法
func LXFLog<T> (_ message: T, file: String = #file, funcName: String = #function, lineNumber: Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\(fileName):(\(lineNumber)-\(message))")
    #endif
}
