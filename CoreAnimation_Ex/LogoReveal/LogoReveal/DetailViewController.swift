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

class DetailViewController: UITableViewController, UINavigationControllerDelegate {
  
  let maskLayer: CAShapeLayer = RWLogoLayer.logoLayer()
    weak var animator: RevealAnimator?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Pack List"
    tableView.rowHeight = 54.0
    maskLayer.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
    view.layer.mask = maskLayer
    
    if let vc = navigationController?.viewControllers.first as? MasterViewController {
        animator = vc.transition
    }
    
    let pan = UIPanGestureRecognizer(target: self, action:#selector(didPan(recognizer:)))
    view.addGestureRecognizer(pan)
  }
    
    func didPan(recognizer: UIPanGestureRecognizer) {
        
        if let animator = animator {
            
            if recognizer.state == .began {
                animator.interActive = true
                navigationController!.popViewController(animated: true)
            }
            
            animator.handlePan(recognizer)
        }
    }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    view.layer.mask = nil
  }
  
  // MARK: Table View methods
  let packItems = ["Icecream money", "Great weather", "Beach ball", "Swim suit for him", "Swim suit for her", "Beach games", "Ironing board", "Cocktail mood", "Sunglasses", "Flip flops"]
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
    cell.accessoryType = .none
    cell.textLabel!.text = packItems[indexPath.row]
    cell.imageView!.image = UIImage(named: "summericons_100px_0\(indexPath.row).png")
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}
