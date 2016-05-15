//
//  ViewController.swift
//  Flo
//
//  Created by plum on 16/5/4.
//  Copyright © 2016年 plum. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var counterLabel: UILabel!
    
    @IBOutlet weak var counterView: CounterView!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var graphView: UIView!
    
    
    
    
    var isGraphViewShowing = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changNumber(sender: PushButtonView) {
        if sender.isAddbutton {
            counterView.counter += 1
        } else {
            if counterView.counter > 0 {
                counterView.counter -= 1
            }
        }
        counterLabel.text = String(counterView.counter)
        if isGraphViewShowing {
            counterViewTap(nil)
        }
    }
    
    @IBAction func counterViewTap(sender: UITapGestureRecognizer?) {
        if isGraphViewShowing {
            //hide
            let options: UIViewAnimationOptions = [.ShowHideTransitionViews, .TransitionFlipFromLeft]
            UIView.transitionFromView(graphView, toView: counterView, duration: 1.0, options: options , completion: nil)
        } else {
            let options: UIViewAnimationOptions = [.ShowHideTransitionViews, .TransitionFlipFromLeft]
            UIView.transitionFromView(counterView, toView: graphView, duration: 1.0, options: options, completion: nil)
        }
        isGraphViewShowing = !isGraphViewShowing
    }
    

}

