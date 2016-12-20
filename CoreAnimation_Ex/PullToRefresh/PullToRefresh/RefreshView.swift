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

// MARK: Refresh View Delegate Protocol
protocol RefreshViewDelegate {
  func refreshViewDidRefresh(_ refreshView: RefreshView)
}

// MARK: Refresh View
class RefreshView: UIView, UIScrollViewDelegate {
  
  var delegate: RefreshViewDelegate?
  var scrollView: UIScrollView?
  var refreshing: Bool = false
  var progress: CGFloat = 0.0
  
  var isRefreshing = false
  
  let ovalShapeLayer: CAShapeLayer = CAShapeLayer()
  let airplaneLayer: CALayer = CALayer()
  
  init(frame: CGRect, scrollView: UIScrollView) {
    super.init(frame: frame)
    
    self.scrollView = scrollView
    
    //add the background image
    let imgView = UIImageView(image: UIImage(named: "refresh-view-bg.png"))
    imgView.frame = bounds
    imgView.contentMode = .scaleAspectFill
    imgView.clipsToBounds = true
    addSubview(imgView)
    
    ovalShapeLayer.strokeColor = UIColor.white.cgColor
    ovalShapeLayer.fillColor = UIColor.clear.cgColor
    ovalShapeLayer.lineDashPattern = [2, 3]
    ovalShapeLayer.lineWidth = 4
    let radius = frame.size.height/2 * 0.8
    ovalShapeLayer.path = UIBezierPath(ovalIn: CGRect(x: frame.size.width/2 - radius,y: frame.size.height/2 - radius,width: 2 * radius,height: 2 * radius)).cgPath
    
    layer.addSublayer(ovalShapeLayer)
    
    let image = UIImage(named: "airplane.png")
    airplaneLayer.contents = image?.cgImage
    airplaneLayer.bounds = CGRect(x: 0.0, y: 0.0, width:(image?.size.width)!, height: (image?.size.height)!)
    airplaneLayer.position = CGPoint(x: frame.size.width/2 + frame.size.height/2 * 0.8, y: frame.size.height/2)
    airplaneLayer.opacity = 0
    layer.addSublayer(airplaneLayer)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Scroll View Delegate methods
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = CGFloat( max(-(scrollView.contentOffset.y + scrollView.contentInset.top), 0.0))
    self.progress = min(max(offsetY / frame.size.height, 0.0), 1.0)
    
    if !isRefreshing {
      redrawFromProgress(self.progress)
    }
  }
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    if !isRefreshing && self.progress >= 1.0 {
      delegate?.refreshViewDidRefresh(self)
      beginRefreshing()
    }
  }
  
  // MARK: animate the Refresh View
  
  func beginRefreshing() {
    isRefreshing = true
    
    let start = CABasicAnimation(keyPath: "strokeStart")
    start.fromValue = -0.5
    start.toValue = 1.0
    
    let end = CABasicAnimation(keyPath: "strokeEnd")
    start.fromValue = 0.0
    start.toValue = 1.0
    
    let group = CAAnimationGroup()
    group.duration = 1.5
    group.repeatCount = 5
    group.animations = [start, end]
    ovalShapeLayer.add(group, forKey: nil)
    
    let airAnimation = CAKeyframeAnimation(keyPath: "position")
    airAnimation.path = ovalShapeLayer.path
    airAnimation.calculationMode = kCAAnimationPaced//等步长
//    airAnimation.rotationMode = kCAAnimationRotateAuto
    
    let airplaneOrientationAnimation = CABasicAnimation(keyPath: "transform.rotation")
    airplaneOrientationAnimation.fromValue = 0
    airplaneOrientationAnimation.toValue = M_PI * 2
    
    let airGroup = CAAnimationGroup()
    airGroup.duration = 1.5
    airGroup.repeatCount = 5
    airGroup.animations = [airAnimation, airplaneOrientationAnimation]
    airplaneLayer.add(airGroup, forKey: nil)
    
    
    
 
    UIView.animate(withDuration: 0.3, animations: {
      var newInsets = self.scrollView!.contentInset
      newInsets.top += self.frame.size.height
      self.scrollView!.contentInset = newInsets
    })
    
  }
  
  func endRefreshing() {
    
    isRefreshing = false
    
    UIView.animate(withDuration: 0.3, delay:0.0, options: .curveEaseOut ,animations: {
      var newInsets = self.scrollView!.contentInset
      newInsets.top -= self.frame.size.height
      self.scrollView!.contentInset = newInsets
      }, completion: {_ in
        //finished
    })
  }
  
  func redrawFromProgress(_ progress: CGFloat) {
    ovalShapeLayer.strokeEnd = progress
//    ovalShapeLayer.strokeStart = -0.5
//    ovalShapeLayer.strokeEnd = 0.25
    airplaneLayer.opacity = Float(progress)
  }
  
}
