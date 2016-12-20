//
//  UIColor+Extention.swift
//  SWIFT_EX
//
//  Created by libo on 2016/12/20.
//  Copyright © 2016年 libo. All rights reserved.
//

import UIKit

extension UIColor {
    class func hexInt(_ hexValue: Int) -> UIColor {
        return UIColor(red: CGFloat((hexValue & 0xFF0000) >> 16)/255.0, green: CGFloat((hexValue & 0xFF00) >> 8)/255.0, blue: CGFloat(hexValue & 0xFF)/255.0, alpha: 1.0)
    }
}
