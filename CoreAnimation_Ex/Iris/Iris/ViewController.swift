//
//  ViewController.swift
//  Siri
//
//  Created by Marin Todorov on 6/23/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  @IBOutlet weak var meterLabel: UILabel!
  @IBOutlet weak var speakButton: UIButton!
  
  let monitor = MicMonitor()
  let assistant = Assistant()
    let replicator = CAReplicatorLayer()
    let dot = CALayer()
    
    let dotLength: CGFloat = 6.0
    let dotOffset: CGFloat = 8.0
    var lastTransformScale: CGFloat = 0.0
    
    
  
  override func viewDidLoad() {
    super.viewDidLoad()
    replicator.frame = view.bounds
    replicator.instanceCount = Int(view.frame.width / dotOffset)
    replicator.instanceTransform = CATransform3DMakeTranslation(-dotOffset, 0, 0)
    view.layer.addSublayer(replicator)
    
    dot.frame = CGRect(x: replicator.frame.size.width - dotLength, y: replicator.position.y, width: dotLength, height: dotLength)
    dot.backgroundColor = UIColor.lightGray.cgColor
    dot.borderColor = UIColor(white: 1.0, alpha: 1.0).cgColor
    dot.borderWidth = 0.5
    dot.cornerRadius = 1.5
    replicator.addSublayer(dot)
    
    replicator.instanceDelay = 0.02
    
    //
    /*
    let move = CABasicAnimation(keyPath: "position.y")
    move.fromValue = dot.position.y
    move.toValue = dot.position.y - 50
    move.duration = 1.0
    move.repeatCount = 10
    dot.add(move, forKey: nil)
 */
    
    
  }
  
  @IBAction func actionStartMonitoring(_ sender: AnyObject) {
    dot.backgroundColor = UIColor.green.cgColor
    monitor.startMonitoringWithHandler { (level) in
        self.meterLabel.text = String.init(format: "%.2f db", level)
        let scaleFactor = max(0.2, CGFloat(level) + 50) / 2
        
        let scale = CABasicAnimation(keyPath: "transform.scale.y")
        scale.fromValue = self.lastTransformScale
        scale.toValue = scaleFactor
        scale.duration = 1.0
        scale.isRemovedOnCompletion = false
        scale.fillMode = kCAFillModeForwards
        self.dot.add(scale, forKey: nil)
        
        self.lastTransformScale = scaleFactor
    }
  }
  
  @IBAction func actionEndMonitoring(_ sender: AnyObject) {
    
    monitor.stopMonitoring()
    
    let scale = CABasicAnimation(keyPath: "transform.scale.y")
    scale.toValue = 1.0
    scale.duration = 1.0
    scale.isRemovedOnCompletion = false
    scale.fillMode = kCAFillModeForwards
    self.dot.add(scale, forKey: nil)
    
    let color = CABasicAnimation(keyPath: "backgroundColor")
    color.fromValue = UIColor.green.cgColor
    color.toValue = UIColor.magenta.cgColor
    color.duration = 1.0
    color.isRemovedOnCompletion = false
    color.fillMode = kCAFillModeBackwards
    self.dot.add(color, forKey: nil)
    
//    dot.removeAllAnimations()
    //speak after 1 second
    delay(seconds: 1.0, completion: {
      self.startSpeaking()
    })
  }
  
  func startSpeaking() {
    
    meterLabel.text = assistant.randomAnswer()
    assistant.speak(meterLabel.text!, completion: endSpeaking)
    speakButton.isHidden = true
    
    print("speak back")
    let scale = CABasicAnimation(keyPath: "transform")
    scale.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
    scale.toValue = NSValue(caTransform3D: CATransform3DMakeScale(1.4, 15, 1.0))
    scale.autoreverses = true
    scale.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    scale.duration = 0.33
    scale.repeatCount = Float.infinity
    dot.add(scale, forKey: "dotScale")
    
    let fade = CABasicAnimation(keyPath: "opacity")
    fade.fromValue = 1.0
    fade.toValue = 0.2
    fade.duration = 0.33
    fade.beginTime = CACurrentMediaTime() + 0.33
    fade.repeatCount = Float.infinity
    fade.autoreverses = true
    fade.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    dot.add(fade, forKey: "dotFade")
    
    let tint = CABasicAnimation(keyPath: "backgroundColor")
    tint.fromValue = UIColor.magenta.cgColor
    tint.toValue = UIColor.cyan.cgColor
    tint.fillMode = kCAFillModeForwards
    tint.autoreverses = true
    tint.beginTime = CACurrentMediaTime() + 0.28
    tint.duration = 0.66
    tint.repeatCount = Float.infinity
    tint.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    dot.add(tint, forKey: "dotTint")
    
    //CAReplicatorLayer animation
    
    let actionStartMonitoring = CABasicAnimation(keyPath: "instanceTransform.rotation")
    actionStartMonitoring.fromValue = 0.0
    actionStartMonitoring.toValue = 0.01
    actionStartMonitoring.duration = 0.33
    actionStartMonitoring.isRemovedOnCompletion = false
    actionStartMonitoring.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    actionStartMonitoring.fillMode = kCAFillModeForwards
    replicator.add(actionStartMonitoring, forKey: "initialRotation")
    
    let rotation = CABasicAnimation(keyPath:"instanceTransform.rotation")
    rotation.fromValue = 0.01
    rotation.toValue = -0.01
    rotation.duration = 0.99
    rotation.beginTime = CACurrentMediaTime() + 0.33
    rotation.repeatCount = Float.infinity
    rotation.autoreverses = true
    rotation.timingFunction = CAMediaTimingFunction(name:
        kCAMediaTimingFunctionEaseInEaseOut)
    replicator.add(rotation, forKey: "replicatorRotation")
  }
  
  func endSpeaking() {
    replicator.removeAllAnimations()
    
    let scale = CABasicAnimation(keyPath: "transform")
    scale.toValue = NSValue(caTransform3D: CATransform3DIdentity)
    scale.duration = 0.33
    scale.isRemovedOnCompletion = false
    scale.fillMode = kCAFillModeForwards
    dot.add(scale, forKey: nil)
    
    dot.removeAnimation(forKey: "dotColor")
    dot.removeAnimation(forKey: "dotOpacity")
    dot.backgroundColor = UIColor.lightGray.cgColor
    speakButton.isHidden = false
  }
}
