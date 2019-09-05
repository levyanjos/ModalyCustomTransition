//
//  PresentAnimation.swift
//  ModalyCustomTransition
//
//  Created by Levy Cristian on 05/09/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class PresentAnimation : NSObject {
}

extension PresentAnimation : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }
        transitionContext.containerView.insertSubview(toVC.view, aboveSubview: fromVC.view)
        
        let screenBounds = UIScreen.main.bounds
        toVC.view.frame.origin = CGPoint(x: 0, y: screenBounds.height)
        
        let bottomLeftCorner = CGPoint(x: 0, y: 80)
        let finalFrame = CGRect(origin: bottomLeftCorner, size: screenBounds.size)
        
        let fromSnapshotView = fromVC.view.resizableSnapshotView(from: fromVC.view.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsets())
        transitionContext.containerView.insertSubview(fromSnapshotView!, belowSubview: toVC.view)
        
        let shadowView = UIView(frame: CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height))
        shadowView.backgroundColor = .black
        shadowView.alpha = 0.0
        transitionContext.containerView.insertSubview(shadowView, aboveSubview: fromSnapshotView!)
        toVC.view.layer.cornerRadius = 20
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                toVC.view.frame = finalFrame
                shadowView.alpha = 0.7
        },
            completion: { _ in
                
                transitionContext.completeTransition(true)
                
        }
        )
        
        
    }
}

