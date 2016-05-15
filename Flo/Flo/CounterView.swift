//
//  CounterView.swift
//  Flo
//
//  Created by plum on 16/5/4.
//  Copyright © 2016年 plum. All rights reserved.
//

import UIKit

let noOfGlasses = 8
let π:CGFloat = CGFloat(M_PI)


@IBDesignable class CounterView: UIView {

    @IBInspectable var counter: Int = 8 {
        didSet {
            if counter <= noOfGlasses {
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var counterLineColor: UIColor = UIColor.blueColor()
    @IBInspectable var counterColor: UIColor = UIColor.orangeColor()
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let center = CGPointMake(rect.size.width/2, rect.size.height/2)
        let radius: CGFloat = min(rect.size.width, rect.size.height)
        let arcWidth: CGFloat = 76;
        
        let startAngle: CGFloat = 3 * π / 4
        let endAngle: CGFloat = π / 4
        
        let path = UIBezierPath.init(arcCenter: center, radius: radius/2 - arcWidth/2, startAngle: startAngle, endAngle: endAngle, clockwise: true);
        path.lineWidth = arcWidth
        counterColor.setStroke();
        path.stroke()
        
        
        //line
        let totalAngle: CGFloat = 2 * π - startAngle + endAngle
        let unit: CGFloat = totalAngle / CGFloat(noOfGlasses)
        let outlineAngle: CGFloat = startAngle + unit * CGFloat(counter)
        let outlineColor = UIColor.blueColor();
        let outlinePath = UIBezierPath.init(arcCenter: center, radius:rect.width/2 - 2.5 , startAngle: startAngle, endAngle: outlineAngle, clockwise: true)
        outlinePath.addArcWithCenter(center, radius: rect.width/2 - arcWidth + 2.5, startAngle: outlineAngle, endAngle:startAngle , clockwise: false)
        outlineColor.setStroke()
        outlinePath.closePath()
        outlinePath.lineWidth = 5
        outlinePath.stroke();
        
//
        
        
        
        
        
        
    }
 

}
