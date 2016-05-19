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
        var startPoint = CGPoint.zero
        var endPoint = CGPointMake(0, rect.size.height)
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, CGGradientDrawingOptions.DrawsBeforeStartLocation)
        let margin: CGFloat = 20
        var columnXpoint = { (column: Int) -> CGFloat in
            let spacer = (width - margin*2 - 4) /
                CGFloat((self.graphPoints.count - 1))
            var x:CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
        }
        
        // calculate the y point
        
        let topBorder:CGFloat = 60
        let bottomBorder:CGFloat = 50
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = graphPoints.maxElement()
        var columnYPoint = { (graphPoint:Int) -> CGFloat in
            var y:CGFloat = CGFloat(graphPoint) /
                CGFloat(maxValue!) * graphHeight
            y = graphHeight + topBorder - y // Flip the graph
            return y
        }
        
        //draw line
        UIColor.whiteColor().setFill()
        UIColor.whiteColor().setStroke()
        
        var linePath = UIBezierPath.init()
        linePath.moveToPoint(CGPointMake(columnXpoint(0), columnYPoint(self.graphPoints[0])))
        
        for i in 1..<graphPoints.count {
            let nextPoint = CGPointMake(columnXpoint(i), columnYPoint(self.graphPoints[i]))
            linePath.addLineToPoint(nextPoint)
            
        }
        linePath.stroke()
        
        //Create the clipping path for the graph gradient
        
        //1 - save the state of the context (commented out for now)
        CGContextSaveGState(context)
        
        //2 - make a copy of the path
        let clipPath = linePath.copy() as! UIBezierPath
        
        //3 - add lines to the copied path to complete the clip area
        clipPath.addLineToPoint(CGPoint(
            x: columnXpoint(graphPoints.count - 1),
            y:height))
        clipPath.addLineToPoint(CGPoint(
            x:columnXpoint(0),
            y:height))
        clipPath.closePath()
        
        //4 - add the clipping path to the context
        clipPath.addClip()
        
        //5 - check clipping path - temporary code
        UIColor.greenColor().setFill()
//        let rectPath = UIBezierPath(rect: self.bounds)
//        rectPath.fill()
        clipPath.fill();
        //end temporary code
        
        let hightYPoint = columnYPoint(maxValue!)
        startPoint = CGPoint(x:margin, y: hightYPoint)
        endPoint = CGPoint(x:margin, y:self.bounds.height)
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, .DrawsBeforeStartLocation)
        CGContextRestoreGState(context)
        
        linePath.lineWidth = 2.0
        linePath.stroke()
        
        for i in 0..<self.graphPoints.count {
            var point = CGPoint(x:columnXpoint(i), y:columnYPoint(graphPoints[i]))
            point.x -= 5.0/2
            point.y -= 5.0/2
            let path = UIBezierPath.init(ovalInRect: CGRect.init(origin: point, size: CGSizeMake(5, 5)))
            
            path.fill()
        }
        
        //Draw horizontal graph lines on the top of everything
        var aLinePath = UIBezierPath()
        
        //top line
        aLinePath.moveToPoint(CGPoint(x:margin, y: topBorder))
        aLinePath.addLineToPoint(CGPoint(x: width - margin,
            y:topBorder))
        
        //center line
        aLinePath.moveToPoint(CGPoint(x:margin,
            y: graphHeight/2 + topBorder))
        aLinePath.addLineToPoint(CGPoint(x:width - margin,
            y:graphHeight/2 + topBorder))
        
        //bottom line
        aLinePath.moveToPoint(CGPoint(x:margin,
            y:height - bottomBorder))
        aLinePath.addLineToPoint(CGPoint(x:width - margin,
            y:height - bottomBorder))
        let color = UIColor(white: 1.0, alpha: 0.3)
        color.setStroke()
        
        aLinePath.lineWidth = 1.0
        aLinePath.stroke()

    }
    

}
