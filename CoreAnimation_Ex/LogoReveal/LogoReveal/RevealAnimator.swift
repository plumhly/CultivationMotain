//
//  RevealAnimator.swift
//  LogoReveal
//
//  Created by libo on 2016/12/21.
//  Copyright © 2016年 Razeware LLC. All rights reserved.
//

import UIKit


class RevealAnimator: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    
    let aduration: TimeInterval = 2.0
    var  operation: UINavigationControllerOperation = .push
    weak var context: UIViewControllerContextTransitioning?
    var interActive = false
    
    func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view?.superview)
        var progress = abs(translation.x / 200)
        progress = min(max(progress, 0.01), 0.99)
        switch gesture.state {
        case .changed:
            update(progress)
        default:
            break
        }
    }
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return aduration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        context = transitionContext
        if operation == .push {
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! MasterViewController
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! DetailViewController
            
            transitionContext.containerView.addSubview(toVC.view)
            let animation = CABasicAnimation(keyPath: "transform")
            animation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
            let transform = CATransform3DConcat(CATransform3DMakeTranslation(0, -10, 0), CATransform3DMakeScale(15, 15, 1.0))
            animation.toValue = NSValue(caTransform3D: transform)
            animation.duration = aduration
            animation.delegate = self
            animation.fillMode = kCAFillModeForwards
            animation.isRemovedOnCompletion = false
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            toVC.maskLayer.add(animation, forKey: nil)
            fromVC.logo.add(animation, forKey: nil)
            
            
            let basic = CABasicAnimation(keyPath: "opacity")
            basic.fromValue = 0.0
            basic.toValue = 1.0
            basic.duration = aduration
            toVC.maskLayer.add(basic, forKey: nil)
        } else {
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! DetailViewController
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! MasterViewController
            transitionContext.containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
            
            UIView.animate(withDuration: aduration, animations: {
                fromVC.view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            }, completion: {
                _ in
                if let aContext = self.context {
                    aContext.completeTransition(!aContext.transitionWasCancelled)
                    
                }
                self.context = nil
            })
        }
        
    }
}

extension RevealAnimator {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let aContext = context {
            aContext.completeTransition(!aContext.transitionWasCancelled)
            //reset logo
            let fromVC = context?.viewController(forKey: UITransitionContextViewControllerKey.from) as! MasterViewController
            fromVC.logo.removeAllAnimations()
            
        }
        context = nil
    }
}
