//
//  BackgroundView.swift
//  Flo
//
//  Created by plum on 16/5/19.
//  Copyright © 2016年 plum. All rights reserved.
//

import UIKit

@IBDesignable
class BackgroundView: UIView {

    @IBInspectable var lightColor: UIColor = UIColor.orangeColor()
    @IBInspectable var darkColor: UIColor = UIColor.yellowColor()
    @IBInspectable var patternSize: CGFloat = 200
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, darkColor.CGColor)
        CGContextFillRect(context, rect)
        
        let drawSize = CGSize(width: patternSize, height: patternSize)
        
        //insert code here
        UIGraphicsBeginImageContextWithOptions(drawSize, true, 0.0)
        let drawingContext = UIGraphicsGetCurrentContext()
        
        //set the fill color for the new context
        darkColor.setFill()
        CGContextFillRect(drawingContext,
                          CGRectMake(0, 0, drawSize.width, drawSize.height))
        
        let trianglePath = UIBezierPath()
        //1
        trianglePath.moveToPoint(CGPoint(x:drawSize.width/2,
            y:0))
        //2
        trianglePath.addLineToPoint(CGPoint(x:0,
            y:drawSize.height/2))
        //3
        trianglePath.addLineToPoint(CGPoint(x:drawSize.width,
            y:drawSize.height/2))
        
        //4
        trianglePath.moveToPoint(CGPoint(x: 0,
            y: drawSize.height/2))
        //5
        trianglePath.addLineToPoint(CGPoint(x: drawSize.width/2,
            y: drawSize.height))
        //6
        trianglePath.addLineToPoint(CGPoint(x: 0,
            y: drawSize.height))
        
        //7
        trianglePath.moveToPoint(CGPoint(x: drawSize.width,
            y: drawSize.height/2))
        //8
        trianglePath.addLineToPoint(CGPoint(x:drawSize.width/2,
            y:drawSize.height))
        //9
        trianglePath.addLineToPoint(CGPoint(x: drawSize.width,
            y: drawSize.height))
        
        lightColor.setFill()
        trianglePath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIColor.init(patternImage: image).setFill()
        CGContextFillRect(context, rect)
        
    }
    

}
