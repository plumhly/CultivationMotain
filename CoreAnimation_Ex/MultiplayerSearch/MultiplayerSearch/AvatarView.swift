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

func delay(time: Double, complete: @escaping (Void) -> Void) {
    let popTime = DispatchTime.now() + Double(Int64(Double(NSEC_PER_SEC) * time)) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: popTime, execute: {
        complete()
    })
}

@IBDesignable
class AvatarView: UIView {
  
  //constants
  let lineWidth: CGFloat = 6.0
  let animationDuration = 1.0
    var isSquare: Bool = false
    
  
  //ui
  let photoLayer = CALayer()
  let circleLayer = CAShapeLayer()
  let maskLayer = CAShapeLayer()
  let label: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "ArialRoundedMTBold", size: 18.0)
    label.textAlignment = .center
    label.textColor = UIColor.black
    return label
    }()
  
  //variables
  @IBInspectable
  var image: UIImage! {
    didSet {
      photoLayer.contents = image.cgImage
    }
  }
  
  @IBInspectable
  var name: String? {
    didSet {
      label.text = name
    }
  }
  
  var shouldTransitionToFinishedState = false
  
  override func didMoveToWindow() {
    layer.addSublayer(photoLayer)
//    layer.mask = maskLayer
    photoLayer.mask = maskLayer
    layer.addSublayer(circleLayer)
    addSubview(label)
  }
  
  override func layoutSubviews() {
    
    //Size the avatar image to fit
    photoLayer.frame = CGRect(
      x: (bounds.size.width - image.size.width + lineWidth)/2,
      y: (bounds.size.height - image.size.height - lineWidth)/2,
      width: image.size.width,
      height: image.size.height)
    
    //Draw the circle
    circleLayer.path = UIBezierPath(ovalIn: bounds).cgPath
    circleLayer.strokeColor = UIColor.white.cgColor
    circleLayer.lineWidth = lineWidth
    circleLayer.fillColor = UIColor.clear.cgColor
    
    //Size the layer
    maskLayer.path = circleLayer.path
    maskLayer.position = CGPoint(x: 0.0, y: 10.0)
    
    //Size the label
    label.frame = CGRect(x: 0.0, y: bounds.size.height + 10.0, width: bounds.size.width, height: 24.0)
  }
  
    
    func bounceOffPoint(bouncePoint: CGPoint, morphSize: CGSize) {
        let originCenter = center
        UIView.animate(withDuration: animationDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
            self.center = bouncePoint
        }, completion: {
            _ in
            if self.shouldTransitionToFinishedState {
                self.animateToSquare()
            }
        })
        
        UIView.animate(withDuration: animationDuration, delay: animationDuration, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: [], animations: {
            self.center = originCenter
        }, completion: {
            _ in
            if !self.isSquare {
                delay(time: 0.1, complete: {
                   self.bounceOffPoint(bouncePoint: bouncePoint, morphSize: morphSize)
                })
            }
            
        })
        
        let morphedFrame = (originCenter.x > bouncePoint.x) ? CGRect(x: 0.0, y: bounds.height - morphSize.height,width: morphSize.width, height: morphSize.height): CGRect(x: bounds.width - morphSize.width,y: bounds.height - morphSize.height,width: morphSize.width, height: morphSize.height)
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = animationDuration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.toValue = UIBezierPath(ovalIn: morphedFrame).cgPath
        circleLayer.add(animation, forKey: nil)
        maskLayer.add(animation, forKey: nil)
        
    }
    
    func animateToSquare() {
        isSquare = true
        let squarePath = UIBezierPath.init(rect: bounds).cgPath
        
        let an = CABasicAnimation(keyPath: "path")
        an.duration = 0.25
        an.fromValue = circleLayer.path
        an.toValue = squarePath
        
        circleLayer.add(an, forKey: nil)
        circleLayer.path = squarePath
        
        maskLayer.add(an, forKey: nil)
        maskLayer.path = squarePath
        
    }
    
    
}
