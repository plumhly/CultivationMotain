//
//  PopAnimator.swift
//  BeginnerCook
//
//  Created by libo on 2016/12/21.
//  Copyright © 2016年 Razeware LLC. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Property
    let duration: TimeInterval = 1.0
    var presenting = true
    var originalFrame = CGRect.zero
    var dismissComplete: ( ()->() )?
    
    
    //MARK: - function
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey:UITransitionContextViewKey.to)!
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        
        let herbView = presenting ? toView : fromView
        
        let initiaFrame = presenting ? originalFrame : fromView.frame
        let finalFrame = presenting ? herbView.frame : originalFrame
        let scaleX = presenting ?
            initiaFrame.width / finalFrame.width : finalFrame.width / initiaFrame.width
        let scaleY = presenting ?
            initiaFrame.height / finalFrame.height : finalFrame.height / initiaFrame.height
        let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        
        if presenting {
            herbView.transform = transform
            herbView.center = CGPoint(x: initiaFrame.midX, y: initiaFrame.midY)
            herbView.clipsToBounds = true
        }
        
//        toView.alpha = 0.0
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: herbView)
        
        let toViewVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let fromViewVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let vc = (presenting ? toViewVC : fromViewVC) as!HerbDetailsViewController
        if presenting {
            vc.containerView.alpha = 0.0
        }
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [], animations: {
            herbView.transform = self.presenting ? CGAffineTransform.identity : transform
            herbView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            vc.containerView.alpha = self.presenting ? 1 : 0
        }, completion: {
            _ in
            if !self.presenting {
                self.dismissComplete?()
            }
            transitionContext.completeTransition(true)
        })
        
        /*
        UIView.animate(withDuration: duration, animations: {
            toView.alpha = 1.0
        }, completion: {
            _ in
            transitionContext.completeTransition(true)
            
        })
        */
        
        let ani = CABasicAnimation(keyPath: "cornerRadius")
        ani.fromValue = presenting ?  20 / scaleX : 0
        ani.toValue = presenting ? 0 : 20 / scaleX
        ani.duration = duration/2
        herbView.layer.add(ani, forKey: nil)
        herbView.layer.cornerRadius = presenting ? 0 : 20 / scaleX
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    
    
}
