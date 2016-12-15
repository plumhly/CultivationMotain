//
//  UIView+Extenion.swift
//  SWIFT_EX
//
//  Created by libo on 2016/12/15.
//  Copyright © 2016年 libo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    //裁剪 view 的圆角
    func clipRectCorner(direction: UIRectCorner, cornerRadius: CGFloat) {
        let cornerSize = CGSize(width: cornerRadius, height: cornerRadius)
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: direction, cornerRadii: cornerSize)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.addSublayer(maskLayer)
        layer.mask = maskLayer
    }
    
    public var x: CGFloat {
        set {
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
        get {
            return self.frame.origin.x
        }
    }
    
    public var y: CGFloat {
        set {
            var r = frame
            r.origin.y = newValue
            frame = r
        }
        
        get {
            return frame.origin.y
        }
    }
    
    ///右边界的x值
    public var rightX: CGFloat {
        set {
            var r = frame
            r.origin.x = newValue - r.size.width
            frame = r
        }
        
        get {
            return frame.origin.x + frame.size.width
        }
    }
    
    ///下边界的y值
    public var bottomY: CGFloat {
        set {
            var r = frame
            r.origin.y = newValue - r.width
            frame = r
        }
        
        get {
            return frame.origin.y + frame.height
        }
    }
    
    public var centerX: CGFloat {
        set {
            var r = frame
            r.origin.x = newValue - r.width/2.0
            frame = r
        }
        
        get {
            return frame.origin.x + frame.width/2.0
        }
    }
    
    public var centerY: CGFloat {
        set {
            var r = frame
            r.origin.y = newValue - r.height/2.0
            frame = r
        }
        
        get {
            return frame.origin.x + frame.height/2.0
        }
    }
    
    public var width: CGFloat {
        set {
            var r = frame
            r.size.width = newValue
            frame = r
        }
        
        get {
            return frame.width
        }
    }
    
    public var height: CGFloat {
        set {
            var r = frame
            r.size.height = newValue
            frame = r
        }
        
        get {
            return frame.height
        }
    }
    
    public var origin: CGPoint {
        set {
            frame.origin = newValue
        }
        
        get {
            return frame.origin
        }
    }
    
    public var size: CGSize {
        set {
            frame.size = newValue
        }
        
        get {
            return frame.size
        }
    }
    
}
