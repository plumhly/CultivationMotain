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

class ViewController: UIViewController, UITextFieldDelegate {
  
  // MARK: IB outlets
  
  @IBOutlet var loginButton: UIButton!
  @IBOutlet var heading: UILabel!
  @IBOutlet var username: UITextField!
  @IBOutlet var password: UITextField!
  
  @IBOutlet var cloud1: UIImageView!
  @IBOutlet var cloud2: UIImageView!
  @IBOutlet var cloud3: UIImageView!
  @IBOutlet var cloud4: UIImageView!
  
  // MARK: further UI
  
  let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
  let status = UIImageView(image: UIImage(named: "banner"))
  let label = UILabel()
  let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
  
  // MARK: view controller methods
    
    var statusPosition = CGPoint.zero
    
  
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
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    username.center.x -= view.bounds.width
    password.center.x -= view.bounds.width
    heading.center.x -= view.bounds.width
    
    UIView.animate(withDuration: 0.5, animations:{
        self.heading.center.x += self.view.bounds.width
        
    }
    )
    
    UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: [], animations: {
        self.username.center.x += self.view.bounds.width
    }, completion: nil)
    
    /*
    UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
        self.username.center.x += self.view.bounds.width
    }, completion: nil)
    
    UIView.animate(withDuration: 0.5, delay: 0.4, options: [], animations: {
        self.password.center.x += self.view.bounds.width
    }, completion: nil)
    */
    
    UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: [], animations: {
        self.password.center.x += self.view.bounds.width
    }, completion: nil)
    
    //cloud
    self.cloud1.alpha = 0.0;
    self.cloud2.alpha = 0.0;
    self.cloud3.alpha = 0.0;
    self.cloud4.alpha = 0.0;
    
    UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
        self.cloud1.alpha = 1
    }, completion: nil)
    
    UIView.animate(withDuration: 0.5, delay: 0.7, options: [], animations: {
        self.cloud2.alpha = 1
    }, completion: nil)
    
    UIView.animate(withDuration: 0.5, delay: 0.9, options: [], animations: {
        self.cloud3.alpha = 1
    }, completion: nil)
    
    UIView.animate(withDuration: 0.5, delay: 1.1, options: [], animations: {
        self.cloud4.alpha = 1
    }, completion: nil)
    
    //login button
    loginButton.alpha = 0.0
    loginButton.center.y += 30
    UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
        self.loginButton.alpha = 1.0
        self.loginButton.center.y -= 30
        self.loginButton.backgroundColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
    }, completion: nil)
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    animateCloud(imageView: cloud1)
    animateCloud(imageView: cloud2)
    animateCloud(imageView: cloud3)
    animateCloud(imageView: cloud4)
  }
  
  // MARK: further methods
  
  @IBAction func login() {
    view.endEditing(true)
    
    UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
        self.loginButton.bounds.size.width += 80
        
        self.spinner.center = CGPoint(x: 40, y: self.loginButton.bounds.height/2.0)
        self.spinner.alpha = 1.0
    }, completion: {
        _ in
        self.showMessage(0)
    })
    
    UIView.animate(withDuration: 0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
        self.loginButton.center.y += 60
    }, completion: nil)
  }
    
    func showMessage(_ index: Int) {
        label.text = messages[index]
        
        UIView.transition(with: status, duration: 0.33, options: [.curveEaseOut, .transitionFlipFromBottom], animations: {
            self.status.isHidden = false
        }, completion: {
            _ in
            //transition completion
            delay(seconds: 2.0, completion: {
                if index < self.messages.count - 1 {
                    self.removeMessage(index)
                } else {
                    //reset form
                    self.resetForm()
                }
            })
        })
    }
    
    func removeMessage(_ index: Int) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
            self.status.center.x += self.view.frame.width
        }, completion: {
            _ in
            self.status.isHidden = true
            self.status.center = self.statusPosition
            self.showMessage(index+1)
        })
    }
    
    func resetForm() {
        UIView.transition(with: status, duration: 0.2, options: [.curveEaseOut, .transitionFlipFromTop], animations:{
            self.status.isHidden = true
            self.status.center = self.statusPosition
            }, completion: nil)
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.spinner.center = CGPoint(x: -20, y: 16)
            self.spinner.alpha = 0.0
            
            self.loginButton.backgroundColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
            self.loginButton.frame.size.width -= 80
            self.loginButton.center.y -= 60
            self.loginButton.center.x += 40
        }, completion: nil)
    }
    
    func animateCloud(imageView: UIImageView) {
        let durationUnit = 60/(self.view.frame.width)
        let distance = self.view.frame.width - imageView.frame.origin.x
        let duration = TimeInterval(durationUnit * distance)
        
        UIView.animate(withDuration: duration, animations: {
            imageView.frame.origin.x += self.view.frame.width
        }, completion: {
            _ in
            imageView.frame.origin.x = -imageView.frame.width
            self.animateCloud(imageView: imageView)
        })
    }
  
  // MARK: UITextFieldDelegate
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let nextField = (textField === username) ? password : username
    nextField?.becomeFirstResponder()
    return true
  }
    
  
}

