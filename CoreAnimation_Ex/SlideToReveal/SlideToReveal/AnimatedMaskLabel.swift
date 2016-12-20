/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import QuartzCore

@IBDesignable
class AnimatedMaskLabel: UIView {
  
  let gradientLayer: CAGradientLayer = {
    let gradientLayer = CAGradientLayer()
    
    // Configure the gradient here
    gradientLayer.colors = [UIColor.yellow, UIColor.gray, UIColor.orange, UIColor.cyan, UIColor.red, UIColor.yellow].map {
        $0.cgColor
    }
    gradientLayer.locations = [0.15, 0.3, 0.45, 0.6, 0.75, 1]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
    return gradientLayer
    }()
  
    let textAttr: [String : AnyObject] = {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        return [NSFontAttributeName: UIFont(name: "HelveticaNeue-Thin", size: 28)!, NSParagraphStyleAttributeName: style]
    }()
    
    
  @IBInspectable var text: String! {
    didSet {
      setNeedsDisplay()
        
//        let aview = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: bounds.height))
//            aview.backgroundColor = UIColor.red
        
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        let newT = text as NSString
        newT.draw(in: bounds, withAttributes: textAttr)
//        aview.draw(bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        
        UIGraphicsEndImageContext()
        
        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.clear.cgColor
        //这里masklayer的背景是clear的，image除了文字部分其他的都是透明的，所以只有文字部分是实心的，当把它作为gradientLayer的mask的时候，只有文字部分才能显示，其他的都不能显示，而把maskLayer以addsubLayer的方法添加上去，gradientLayer的背景会显示，文字也会显示
        maskLayer.contents = image?.cgImage
        maskLayer.frame = bounds.offsetBy(dx: bounds.width, dy: 0)
        
        gradientLayer.mask = maskLayer //mask图层的Color属性是无关紧要的，但是color会影响效果，真正重要的是图层的轮廓。mask属性就像是一个饼干切割机，mask图层实心的部分会被保留下来，其他的则会被抛弃。
//        gradientLayer.addSublayer(maskLayer)
    }
  }
  
  override func layoutSubviews() {
    layer.borderColor = UIColor.green.cgColor
    gradientLayer.frame = CGRect(x: -bounds.width, y: bounds.origin.y, width: 3 * bounds.width, height: bounds.height)//加宽是为了使得过渡区域变长
    
  }
  
  override func didMoveToWindow() { ///like awakenFromNib
    super.didMoveToWindow()
    self.layer.addSublayer(gradientLayer)
    
    let gradientAnimation = CABasicAnimation(keyPath: "locations")
    /*
    gradientAnimation.fromValue = [0.0, 0.0, 0.25]
    gradientAnimation.toValue = [0.75, 1.0, 1.0]
     */
    //challenge
    gradientAnimation.fromValue = [0.0, 0.0, 0.0, 0.0, 0.0, 0.25]
    gradientAnimation.toValue = [0.65, 0.8, 0.85, 0.9, 0.95, 1.0]
    gradientAnimation.duration = 3.0
    gradientAnimation.repeatCount = Float.infinity
    gradientLayer.add(gradientAnimation, forKey: nil)
  }
  
}
