//
//  GraphView.swift
//  Flo
//
//  Created by plum on 16/5/13.
//  Copyright © 2016年 plum. All rights reserved.
//

import UIKit


@IBDesignable class GraphView: UIView {

    var graphPoints: [Int] = [4, 2, 6, 4, 5, 8, 3]
    
    
    
   @IBInspectable var startColor: UIColor = UIColor.redColor()
   @IBInspectable var endColor: UIColor = UIColor.greenColor()
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        let width = rect.size.width
        let height = rect.size.height
        let path = UIBezierPath.init(roundedRect: rect, byRoundingCorners: .AllCorners, cornerRadii: CGSizeMake(8, 8))
        self.clipsToBounds = true
        path.addClip()
        
        let colorspace = CGColorSpaceCreateDeviceRGB()
        let colors = [startColor.CGColor, endColor.CGColor]
        let c: [CGFloat] = [0.0, 1.0]
        let gradient = CGGradientCreateWithColors(colorspace, colors, c)
        let startPoint = CGPoint.zero
        let endPoint = CGPointMake(0, rect.size.height)
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, CGGradientDrawingOptions.DrawsBeforeStartLocation)
        let margin: CGFloat = 20
        var columnXpoint = { (column: Int) -> CGFloat in
            let spacer = (width - margin*2 - 4) /
                CGFloat((self.graphPoints.count - 1))
            var x:CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
        }
        
        
        
        
        
        
    }
    

}
