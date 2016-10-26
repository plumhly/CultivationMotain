/*
* Copyright (c) 2014 Razeware LLC
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
import CoreData

class LoginViewController: UIViewController {
  
  var managedObjectContext: NSManagedObjectContext? = nil
    let myKeychainWrapper = KeychainWrapper();
    let createLoginButtonTag = 1
    let loginButtonTag = 0
    
    @IBOutlet weak var loginButton: UIButton!
    
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var createInfoLabel: UILabel!  

  
  override func viewDidLoad() {
    super.viewDidLoad()
    let has = NSUserDefaults.standardUserDefaults().boolForKey("username")
    if has {
        loginButton.setTitle("Login", forState: .Normal)
        loginButton.tag = loginButtonTag
        createInfoLabel.hidden = true
    } else {
        loginButton.setTitle("Create", forState: .Normal)
        loginButton.tag = createLoginButtonTag
        createInfoLabel.hidden = false
    }
    
    if let user = NSUserDefaults.standardUserDefaults().valueForKey("username") as? String {
        usernameTextField.text = user
    }
  }
  
  // MARK: - Action for checking username/password
  @IBAction func loginAction(sender: AnyObject) {
    if (usernameTextField.text == "" || passwordTextField.text == "") {
        let alertView = UIAlertController.init(title: "Login Problem", message: "Wrong username or password.", preferredStyle:.Alert)
        let okAction = UIAlertAction.init(title: "Foiled Again!", style: .Default, handler: nil)
        alertView.addAction(okAction)
        self.presentViewController(alertView, animated: true, completion: nil)
        return
    }
    
    //2
    usernameTextField.resignFirstResponder()
    passwordTextField.resignFirstResponder()
    
    //3
    if sender.tag == createLoginButtonTag {
        
        //4
        let hasLoginKey = NSUserDefaults.standardUserDefaults().boolForKey("hasLoginKey")
        if !hasLoginKey {
            NSUserDefaults.standardUserDefaults().setValue(usernameTextField.text, forKey: "username")
        }
        
        //5
        myKeychainWrapper.mySetObject(passwordTextField.text, forKey:kSecValueData)
        myKeychainWrapper.writeToKeychain()
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasLoginKey")
        NSUserDefaults.standardUserDefaults().synchronize()
        loginButton.tag = loginButtonTag
        self.performSegueWithIdentifier("dismissLogin", sender: self)
        
        
        
        
    } else if sender.tag == loginButtonTag {
        //6
        if checkLogin(usernameTextField.text!, password: passwordTextField.text!) {
            self.performSegueWithIdentifier("dismissLogin", sender: self)
        }
    } else {
        //7
        let alertView = UIAlertController(title: "Login Problem",
                                          message: "Wrong username or password." as String, preferredStyle:.Alert)
        let okAction = UIAlertAction(title: "Foiled Again!", style: .Default, handler: nil)
        alertView.addAction(okAction)
        self.presentViewController(alertView, animated: true, completion: nil)
    }

  }
  
    func checkLogin(username: String, password: String) -> Bool {
        if (password == myKeychainWrapper.myObjectForKey("v_Data") as? String || username == NSUserDefaults.standardUserDefaults().valueForKey("username") as? String){
            return true
        }
        return false
    }
  
  
}
