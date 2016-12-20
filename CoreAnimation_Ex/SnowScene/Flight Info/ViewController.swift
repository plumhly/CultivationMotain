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

//
// Util delay function
//
func delay(seconds: Double, completion:@escaping ()->()) {
  let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
  
  DispatchQueue.main.asyncAfter(deadline: popTime) {
    completion()
  }
}

class ViewController: UIViewController {
  
  @IBOutlet var bgImageView: UIImageView!
  
  @IBOutlet var summaryIcon: UIImageView!
  @IBOutlet var summary: UILabel!
  
  @IBOutlet var flightNr: UILabel!
  @IBOutlet var gateNr: UILabel!
  @IBOutlet var departingFrom: UILabel!
  @IBOutlet var arrivingTo: UILabel!
  @IBOutlet var planeImage: UIImageView!
  
  @IBOutlet var flightStatus: UILabel!
  @IBOutlet var statusBanner: UIImageView!
  
  //MARK: view controller methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //adjust ui
    summary.addSubview(summaryIcon)
    summaryIcon.center.y = summary.frame.size.height/2
    
    //start rotating the flights
    changeFlightDataTo(londonToParis)
    
    let emitter = CAEmitterLayer()
    let rect = CGRect(x: 0, y: -50, width: view.frame.width, height: 50.0)
    
    emitter.frame = rect
    emitter.emitterShape = kCAEmitterLayerRectangle
    //emitterPosition 发射粒子的中心点
    emitter.emitterPosition = CGPoint(x: rect.width/2, y: rect.height/2)
    emitter.emitterSize = rect.size
    
    let emiterCell = CAEmitterCell()
    emiterCell.contents = UIImage(named: "flake.png")?.cgImage
    emiterCell.birthRate = 150
    
    emiterCell.lifetime = 3.5
    emiterCell.lifetimeRange = 1.0
    
    emiterCell.yAcceleration = 70
    emiterCell.xAcceleration = 10
    emiterCell.velocity = 20
    emiterCell.velocityRange = 200 // velocity random [20-200,20+200]
    
    emiterCell.emissionLongitude = CGFloat(-M_PI)
    emiterCell.emissionRange = CGFloat(M_PI_2) // [-180, 0],向上代表-，向下+
    
    emiterCell.color = UIColor(red: 0.9, green: 1, blue: 1, alpha: 1).cgColor
    emiterCell.redRange = 0.1
    emiterCell.blueRange = 0.1
    emiterCell.greenRange = 0.1
    
    emiterCell.scale = 0.8
    emiterCell.scaleRange = 0.8
    emiterCell.scaleSpeed = -0.15
    
    emiterCell.alphaRange = 0.75
    emiterCell.alphaSpeed = -0.15
    
    //
    let emiterCell1 = CAEmitterCell()
    emiterCell1.contents = UIImage.init(named: "flake.png2")
    emiterCell1.spin = 1
    emiterCell1.scaleRange = 2.0
    emiterCell1.lifetime = 3.5
    
    
    emitter.emitterCells = [emiterCell, emiterCell1]
    view.layer.addSublayer(emitter)
    
    
  }
  
  //MARK: custom methods
  
  func changeFlightDataTo(_ data: FlightData) {
    
    // populate the UI with the next flight's data
    summary.text = data.summary
    flightNr.text = data.flightNr
    gateNr.text = data.gateNr
    departingFrom.text = data.departingFrom
    arrivingTo.text = data.arrivingTo
    flightStatus.text = data.flightStatus
    bgImageView.image = UIImage(named: data.weatherImageName)
  }
  
  
}
