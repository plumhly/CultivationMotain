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

class ViewController: UIViewController {
  
  //MARK: IB outlets
  
  @IBOutlet var tableView: UITableView!
  @IBOutlet var buttonMenu: UIButton!
  @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var menuHeightConstraint: NSLayoutConstraint!
  
  //MARK: further class variables
  
  var slider: HorizontalItemList!
  var isMenuOpen = false
  var items: [Int] = [5, 6, 7]
    
    
  
  //MARK: class methods
  
  @IBAction func actionToggleMenu(_ sender: AnyObject) {
    isMenuOpen = !isMenuOpen
    
    for constraint in (titleLabel.superview?.constraints)! {
        if constraint.firstItem as! NSObject == self.titleLabel && constraint.firstAttribute == .centerX {
            constraint.constant = isMenuOpen ? -100.0 : 0.0
            continue
        } else {
            if constraint.identifier == "centerY" {
                constraint.isActive = false
                //add new constraint
                
                let newConstraint = NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: titleLabel.superview, attribute: .centerY, multiplier: 0.67, constant: 5)
                newConstraint.identifier = "centerY"
                newConstraint.isActive = true
                
                continue
            }
        }
    }
    
    titleLabel.text = isMenuOpen ? "Select Item" : "Packing List"
    menuHeightConstraint.constant = isMenuOpen ? 200 : 60
   
    
    UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
        self.view.layoutIfNeeded()
        let angle = self.isMenuOpen ? CGFloat(M_PI_4) : 0
        self.buttonMenu.transform = CGAffineTransform.init(rotationAngle: angle)
    }, completion: nil)
    
    if isMenuOpen {
        slider = HorizontalItemList(inView: view)
        slider.didSelectItem = {
            index in
            self.items.append(index)
            self.tableView.reloadData()
            self.actionToggleMenu(self)
            }
        self.titleLabel.superview?.addSubview(slider)
        } else {
        slider.removeFromSuperview()
    }
    
  }
  
  func showItem(_ index: Int) {
    print("tapped item \(index)")
    
    let imageView = UIImageView(image: UIImage.init(named: "summericons_100px_0\(index).png"))
    imageView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    imageView.layer.cornerRadius = 5
    imageView.layer.masksToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(imageView)
    
    //constraint
    let conx = imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    let bottom = imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: imageView.frame.height)
    let width = imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33, constant: -50)
    let height = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
    NSLayoutConstraint.activate([conx, bottom, width ,height])
    view.layoutIfNeeded()//立刻更新布局，如果没有更新,imageview的约束不会生效，导致imageview不知道自己的位置在哪里，保持在（0，0）位置，在进行动画就会从左上角进行动画。
    //animate
    UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [], animations: {
        bottom.constant = -imageView.frame.height/2
        width.constant = 0.0
        self.view.layoutIfNeeded()
        
    }, completion: nil)
    
    delay(time: 1.8, completion: {
        UIView.animate(withDuration: 0.5, animations: {
            imageView.alpha = 0.0
            imageView.removeFromSuperview()
        })
    })
  }
}

func delay(time: Double, completion: @escaping ()->()) {
    let popTime = DispatchTime.now() + Double(Int64(Double(NSEC_PER_SEC) * time)) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: popTime) {
        completion()
    }
    
}


let itemTitles = ["Icecream money", "Great weather", "Beach ball", "Swim suit for him", "Swim suit for her", "Beach games", "Ironing board", "Cocktail mood", "Sunglasses", "Flip flops"]

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  // MARK: View Controller methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView?.rowHeight = 54.0
  }
  
  // MARK: Table View methods
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
    cell.accessoryType = .none
    cell.textLabel?.text = itemTitles[items[indexPath.row]]
    cell.imageView?.image = UIImage(named: "summericons_100px_0\(items[indexPath.row]).png")
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    showItem(items[indexPath.row])
  }
  
}
