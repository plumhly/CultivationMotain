//
//  PushButtonView.swift
//  Flo
//
//  Created by plum on 16/5/4.
//  Copyright © 2016年 plum. All rights reserved.
//

import UIKit

@IBDesignable



class PushButtonView: UIButton {

    @IBInspectable var fillColor: UIColor = UIColor.greenColor()
    
    @IBInspectable var isAddbutton: Bool = true
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let path = UIBezierPath.init(ovalInRect: rect)
        fillColor.setFill()
        path.fill();
        
        let plusHeight: CGFloat = 3.0;
        let plusWidth: CGFloat = min(rect.size.height, rect.size.width) * 0.6
        let plusPath = UIBezierPath.init()
        
        plusPath.lineWidth = plusHeight
        plusPath.moveToPoint(CGPointMake((rect.size.width - plusWidth)/2 + 0.5, rect.size.height/2 + 0.5) )
        plusPath.addLineToPoint(CGPointMake((rect.size.width + plusWidth)/2 + 0.5, rect.size.height/2 + 0.5))
        
        
        if isAddbutton {
            plusPath.moveToPoint(CGPointMake(rect.size.width/2 + 0.5, (rect.size.height - plusWidth)/2 + 0.5) )
            plusPath.addLineToPoint(CGPointMake(rect.size.width/2 + 0.5, (rect.size.height + plusWidth)/2 + 0.5))
            plusPath.stroke()
        }
        UIColor.whiteColor().setStroke()
        plusPath.stroke()
        
    }
 

}
