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


// A delay function
func delay(seconds: Double, completion:@escaping ()->()) {
  let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
  
  DispatchQueue.main.asyncAfter(deadline: popTime) {
    completion()
  }
}

class ViewController: UIViewController, CAAnimationDelegate, UITextFieldDelegate {
  
  // MARK: IB outlets
  
  @IBOutlet var loginButton: UIButton!
  @IBOutlet var heading: UILabel!
  @IBOutlet var username: UITextField!
  @IBOutlet var password: UITextField!
  
  @IBOutlet var cloud1: UIImageView!
  @IBOutlet var cloud2: UIImageView!
  @IBOutlet var cloud3: UIImageView!
  @IBOutlet var cloud4: UIImageView!
    
    let info = UILabel()
    
  
  // MARK: further UI
  
  let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
  let status = UIImageView(image: UIImage(named: "banner"))
  let label = UILabel()
  let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
  
  var statusPosition = CGPoint.zero
  
  // MARK: view controller methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //set up the UI
    loginButton.layer.cornerRadius = 8.0
    loginButton.layer.masksToBounds = true
    
    spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
    spinner.startAnimating()
    spinner.alpha = 0.0
    loginButton.addSubview(spinner)
    
    status.isHidden = true
    status.center = loginButton.center
    view.addSubview(status)
    
    label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
    label.font = UIFont(name: "HelveticaNeue", size: 18.0)
    label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
    label.textAlignment = .center
    status.addSubview(label)
    
    statusPosition = status.center
    
    info.frame = CGRect(x: 0, y: loginButton.center.y + 60, width: view.frame.width, height: 30)
    info.backgroundColor = UIColor.clear
    info.textAlignment = .center
    info.textColor = UIColor.white
    info.font = UIFont.init(name: "HelveticaNeue", size: 12)
    info.text = "Tap on a field and enter username and password"
    view.insertSubview(info, belowSubview: loginButton)
    
    let flyLeft = CABasicAnimation(keyPath: "position.x")
    flyLeft.fromValue = info.layer.position.x + view.frame.width
    flyLeft.toValue = info.layer.position.x
    /*
    flyLeft.repeatCount = 2.5//一个来回是一次repeatCount
    flyLeft.autoreverses = true
    flyLeft.speed = 2.0
    info.layer.speed = 2.0 // 2 * 2
    view.layer.speed = 2.0 // 2 * 2 * 2
    */
    flyLeft.duration = 5.0
    
    info.layer.add(flyLeft, forKey: "infoappear")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    //1
    //2
    //3
    
//    username.layer.position.x -= view.frame.width
//    password.layer.position.x -= view.frame.width

    
    //4
    
    let lableFadein = CABasicAnimation(keyPath: "opacity")
    lableFadein.fromValue = 0.2
    lableFadein.toValue = 1.0
    lableFadein.duration = 4.5
    info.layer.add(lableFadein, forKey: "fadein")
    
    
//    delay(seconds: 5) {
//        print("where are")
//    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    username.delegate = self
    password.delegate = self
    /*
  //1
    let flyRight = CABasicAnimation(keyPath: "position.x")
    flyRight.fromValue = -view.frame.width/2
    flyRight.toValue = view.frame.width/2
    flyRight.duration = 0.5
    flyRight.delegate = self
    flyRight.setValue("h", forKey: "jj")
    flyRight.setValue("form", forKey: "name")
    flyRight.setValue(heading.layer, forKey: "layer")
//    flyRight.isRemovedOnCompletion = false
    flyRight.fillMode = kCAFillModeBoth
    //kCAFillModeBackwards也可以，为了消除因为延迟动画而使得动画变样，所以在添加动画的时候就显示动画的first frame,而不是等待动画开始的时候
    
    heading.layer.add(flyRight, forKey: "flyRight")
    //2
//      flyRight.timeOffset = 0.3 + CACurrentMediaTime()
     /*
     这个timeOffset可能是这几个属性中比较难理解的一个,官方的文档也没有讲的很清楚.local time也分成两种一种是active local time 一种是basic local time.timeOffset则是active local time的偏移量.你将一个动画看作一个环,timeOffset改变的其实是动画在环内的起点,比如一个duration为5秒的动画,将timeOffset设置为2(或者7,模5为2),那么动画的运行则是从原来的2秒开始到5秒,接着再0秒到2秒,完成一次动画
 */
    flyRight.beginTime = 0.3 + CACurrentMediaTime()
    flyRight.setValue(username.layer, forKey: "layer")
    username.layer.add(flyRight, forKey: nil)
    //3
    flyRight.beginTime = 0.4 + CACurrentMediaTime()
    flyRight.setValue(password.layer, forKey: "layer")
    password.layer.add(flyRight, forKey: nil)
    
//    username.layer.position.x += view.frame.width
//    password.layer.position.x += view.frame.width
     */
    
    
    let formGrop = CAAnimationGroup()
    formGrop.duration = 0.5
    formGrop.fillMode = kCAFillModeBackwards
    
    let flyRightNew = CABasicAnimation(keyPath: "position.x")
    flyRightNew.fromValue = -view.frame.width/2
    flyRightNew.toValue = view.frame.width/2
    
    let fadeIn = CABasicAnimation(keyPath: "opacity")
    fadeIn.toValue = 1.0
    fadeIn.fromValue = 0.25
    formGrop.animations = [flyRightNew, fadeIn]
    heading.layer.add(formGrop, forKey: nil)
    
    //username
    formGrop.delegate = self
    formGrop.setValue("form", forKey: "name")
    formGrop.setValue(username.layer, forKey: "layer")
    formGrop.beginTime = CACurrentMediaTime() + 0.3
    username.layer.add(formGrop, forKey: nil)
    
    //password
    formGrop.setValue(password.layer, forKey: "layer")
    formGrop.beginTime = CACurrentMediaTime() + 0.4
    password.layer.add(formGrop, forKey: nil)
    
    
    
    let cloudFade = CABasicAnimation(keyPath: "opacity")
    cloudFade.duration = 0.5
    cloudFade.fromValue = 0.0
    cloudFade.toValue = 1.0 
    cloudFade.fillMode = kCAFillModeBackwards
    
    cloudFade.beginTime = CACurrentMediaTime() + 0.5
    cloud1.layer.add(cloudFade, forKey: nil)
    
    cloudFade.beginTime = CACurrentMediaTime() + 0.7
    cloud2.layer.add(cloudFade, forKey: nil)
    
    cloudFade.beginTime = CACurrentMediaTime() + 0.9
    cloud3.layer.add(cloudFade, forKey: nil)

    cloudFade.beginTime = CACurrentMediaTime() + 1.1
    cloud4.layer.add(cloudFade, forKey: nil)
    
    //4
    let animationGroup = CAAnimationGroup()
    animationGroup.beginTime = CACurrentMediaTime() + 0.5
    animationGroup.duration = 0.5
    animationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
    animationGroup.fillMode = kCAFillModeBackwards
    
    let scaleAn = CABasicAnimation(keyPath: "transform.scale")
    scaleAn.fromValue = 3.5
    scaleAn.toValue = 1
    
    let rotationAn = CABasicAnimation(keyPath: "transform.rotation")
    rotationAn.fromValue = CGFloat(M_PI_4)
    rotationAn.toValue = 0
    
    let fadeAn = CABasicAnimation(keyPath: "opacity")
    fadeAn.fromValue = 0.0
    fadeAn.toValue = 1.0
    
    animationGroup.animations = [scaleAn, rotationAn, fadeAn]
    self.loginButton.layer.add(animationGroup, forKey: nil)
    
    
    animateCloud(cloud1.layer)
    animateCloud(cloud2.layer)
    animateCloud(cloud3.layer)
    animateCloud(cloud4.layer)

  }
  
  // MARK: further methods
  
  @IBAction func login() {

    UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
      self.loginButton.bounds.size.width += 80.0
    }, completion: nil)

    UIView.animate(withDuration: 0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
      self.loginButton.center.y += 60.0
      
      self.spinner.center = CGPoint(x: 40.0, y: self.loginButton.frame.size.height/2)
      self.spinner.alpha = 1.0

    }, completion: {_ in
      self.showMessage(index: 0)
    })
    let tintColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
    tintBackgroundColor(layer: loginButton.layer, toColor: tintColor)
    
    roundCorners(layer: loginButton.layer, toRadius: 25.0)
    
    //balloon
    let balloon = CALayer()
    balloon.frame = CGRect(x: -50, y: 0, width: 50, height: 65)
    balloon.contents = UIImage(named: "balloon")?.cgImage
    view.layer.insertSublayer(balloon, below: username.layer)
    
    let flight = CAKeyframeAnimation(keyPath: "position")
    flight.duration = 12
    flight.values = [CGPoint.init(x: -50, y: 0), CGPoint.init(x: view.frame.width + 50, y: 160), CGPoint(x:-50, y: loginButton.center.y)].map {
        NSValue.init(cgPoint: $0)
    }
    flight.keyTimes = [0, 0.5, 1.0]
    balloon.add(flight, forKey: nil)
    balloon.position = CGPoint(x: -50, y: loginButton.center.y)
  }

  func showMessage(index: Int) {
    label.text = messages[index]
    
    UIView.transition(with: status, duration: 0.33, options:
      [.curveEaseOut, .transitionFlipFromBottom], animations: {
        self.status.isHidden = false
      }, completion: {_ in
        //transition completion
        delay(seconds: 2.0) {
          if index < self.messages.count-1 {
            self.removeMessage(index: index)
          } else {
            //reset form
            self.resetForm()
          }
        }
    })
  }

  func removeMessage(index: Int) {
    UIView.animate(withDuration: 0.33, delay: 0.0, options: [], animations: {
      self.status.center.x += self.view.frame.size.width
    }, completion: {_ in
      self.status.isHidden = true
      self.status.center = self.statusPosition
      
      self.showMessage(index: index+1)
    })
  }

  func resetForm() {
    
    let wobble = CAKeyframeAnimation(keyPath: "transform.rotation")
    wobble.duration = 0.25
    wobble.repeatCount = 4
    wobble.values = [0, -M_PI_4/2, 0, M_PI_4/2, 0]
    wobble.keyTimes = [0, 0.25, 0.5, 0.75, 1.0]
    heading.layer.add(wobble, forKey: nil)
    
    
    UIView.transition(with: status, duration: 0.2, options: .transitionFlipFromTop, animations: {
      self.status.isHidden = true
      self.status.center = self.statusPosition
    }, completion: nil)
    
    UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
      self.spinner.center = CGPoint(x: -20.0, y: 16.0)
      self.spinner.alpha = 0.0
      self.loginButton.bounds.size.width -= 80.0
      self.loginButton.center.y -= 60.0
        /* view and layer transform is not equal!!!
        self.loginButton.layer.transform
        self.loginButton.transform
         */
    }) {
        _ in
        let tintColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha:1.0)
        self.tintBackgroundColor(layer: self.loginButton.layer, toColor: tintColor)
        self.roundCorners(layer: self.loginButton.layer, toRadius: 10.0)
    }
  }
  
  func animateCloud(_ cloud: CALayer) {
    let cloudSpeed = 60.0 / view.frame.size.width
    let duration = (view.frame.size.width - cloud.frame.origin.x) * cloudSpeed
    
    
    let animation = CABasicAnimation(keyPath: "position.x")
    animation.toValue = self.view.frame.width + cloud.bounds.width/2
    animation.duration = CFTimeInterval(duration)
    animation.delegate = self
    animation.setValue("cloud", forKey: "name")
    animation.setValue(cloud, forKey: "layer")
    cloud.add(animation, forKey: nil)
    
    
    UIView.animate(withDuration: TimeInterval(duration), delay: 0.0, options: .curveLinear, animations: {
      cloud.frame.origin.x = self.view.frame.size.width
    }, completion: {_ in
      cloud.frame.origin.x = -cloud.frame.size.width
      self.animateCloud(cloud)
    })
  }
    
    func tintBackgroundColor(layer: CALayer, toColor: UIColor) {
        /*
        let buttonAn = CABasicAnimation(keyPath: "backgroundColor")
        buttonAn.fromValue = layer.backgroundColor
        buttonAn.toValue = toColor.cgColor
        buttonAn.duration = 1.0
        
        layer.add(buttonAn, forKey: nil)
        */
        
        if #available(iOS 9, *) {
            let buttonNew = CASpringAnimation(keyPath: "backgroundColor")
            buttonNew.fromValue = layer.backgroundColor
            buttonNew.toValue = toColor.cgColor
            buttonNew.mass = 200
            buttonNew.stiffness = 100
            buttonNew.duration = buttonNew.settlingDuration
            layer.add(buttonNew, forKey: nil)
        } else {
            
        }
        layer.backgroundColor = toColor.cgColor
        
    }
    
    func roundCorners(layer: CALayer, toRadius: CGFloat) {
        /*
        let cornerAn = CABasicAnimation(keyPath: "cornerRadius")
        cornerAn.toValue = toRadius
        cornerAn.duration = 0.33
        layer.add(cornerAn, forKey: nil)
        
        */
        
        if #available(iOS 9, *) {
            let cornerNew = CASpringAnimation(keyPath: "cornerRadius")
            cornerNew.initialVelocity = 20
            cornerNew.damping = 7
            cornerNew.toValue = toRadius
            cornerNew.duration = cornerNew.settlingDuration
            layer.add(cornerNew, forKey: nil)
            
        } else {
            
        }
        layer.cornerRadius = toRadius
    }
    
}

extension ViewController {
    // MARK: - cadelegate
    func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("animation ended")
        if let name = anim.value(forKey: "name") as? String {
            if name == "form" {
                let layer = anim.value(forKey: "layer") as? CALayer
                anim.setValue(nil, forKey: "layer")//破除循环应用
                
//                let pluse = CABasicAnimation(keyPath: "transform.scale")
                if #available(iOS 9.0, *) {
                    let pluse = CASpringAnimation(keyPath: "transform.scale")
                    pluse.fromValue = 1.25
                    pluse.toValue = 1
                    pluse.damping = 7.5
                    pluse.duration = pluse.settlingDuration
                    layer?.add(pluse, forKey: nil)
                } else {
                    // Fallback on earlier versions
                }
                
            }
            
            if name == "cloud" {
                let layer = anim.value(forKey: "layer") as? CALayer
                anim.setValue(nil, forKey: "layer")
                layer?.position.x =  -((layer?.bounds.width)! / 2.0)
                
                delay(seconds: 0.5, completion: {
                    self.animateCloud(layer!)
                })
            }
        }
    }
}

extension ViewController {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("====\(info.layer.animationKeys())")
        info.layer.removeAnimation(forKey: "infoappear")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text?.characters.count)! < 5 {
            if #available(iOS 9, *) {
                let jump = CASpringAnimation(keyPath: "position.y")
                jump.fromValue = textField.layer.position.y + 1
                jump.toValue = textField.layer.position.y
                jump.initialVelocity = 100
                jump.mass = 20
                jump.stiffness = 1500
                jump.damping = 50
                jump.duration = jump.settlingDuration
                textField.layer.add(jump, forKey: nil)
                
                //borderColor
                textField.layer.borderColor = UIColor.clear.cgColor
                textField.layer.borderWidth = 3.0
                
                let flash = CASpringAnimation(keyPath: "borderColor")
                flash.damping = 7
                flash.stiffness = 200
                flash.toValue = UIColor.clear.cgColor
                flash.fromValue = UIColor(red: 0.96, green: 0.27, blue: 0.0, alpha: 1.0).cgColor
                flash.duration = flash.settlingDuration
                textField.layer.add(flash, forKey: nil)
                
            } else {
                // Fallback on earlier versions
            }
            
        }
    }
}

