//
//  PopAnimator.swift
//  MinionTeam
//
//  Created by MacBook on 05.06.2022.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to) else {return}
        
        transitionContext.containerView.addSubview(toVC.view)
        transitionContext.containerView.sendSubviewToBack(toVC.view)
        
        toVC.view.frame = fromVC.view.frame
        
        let rotation = CGAffineTransform(rotationAngle: .pi/2)
        let translation = CGAffineTransform(translationX: -1.5 * fromVC.view.frame.width, y: 0.5 * fromVC.view.frame.width)
        toVC.view.transform = rotation.concatenating(translation)
        
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .calculationModePaced) {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.75) {
                let rotation = CGAffineTransform(rotationAngle: -.pi/3)
                let translation = CGAffineTransform(translationX: 1.5 * fromVC.view.frame.width, y: -0.3 * fromVC.view.frame.width)
                fromVC.view.transform = rotation.concatenating(translation)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8) {
                toVC.view.transform = .identity
            }
            
        } completion: { finished in
            if finished && !transitionContext.transitionWasCancelled {
                fromVC.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                toVC.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
    
}
