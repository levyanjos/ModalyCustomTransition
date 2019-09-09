//
//  DismissAnimation.swift
//  ModalyCustomTransition
//
//  Created by Levy Cristian on 05/09/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class DismissAnimation: NSObject{
    
}

extension DismissAnimation: UIViewControllerAnimatedTransitioning{
    
    // MARK: Animation Functions

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //FromVC is our current view, in this case is the SecondViewController . Also, toVC is the FristViewController.
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }
        
        transitionContext.containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        
        let screenBounds = UIScreen.main.bounds
        //toVC start at view top and end at view bottom.
        let bottomLeftCorner = CGPoint(x: 0, y: screenBounds.height )
        let finalFrame = CGRect(origin: bottomLeftCorner, size: screenBounds.size)
        
        //Insert a shadowView between above toVC to create a focus in presentation view, it could be and bluer view our whatever you want to.
        let shadowView = UIView(frame: CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height))
        shadowView.backgroundColor = .black
        shadowView.alpha = 0.7
        
        transitionContext.containerView.insertSubview(shadowView, aboveSubview: toVC.view)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                fromVC.view.frame = finalFrame
                shadowView.alpha = 0.0
        },
            completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        )
    }
}

