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

    // MARK: Animation Functions

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //FromVC is our current view, in this case is the FristViewController. Also, toVC is the SecondViewController.
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }
        transitionContext.containerView.insertSubview(toVC.view, aboveSubview: fromVC.view)
        
        let screenBounds = UIScreen.main.bounds
        //toVC start at view bottom to be hidden form bottom to top before present.
        toVC.view.frame.origin = CGPoint(x: 0, y: screenBounds.height)
        
        //bottomLeftCorner is where the toVC should be when the transition ends, in this case it's the view height less 80 points of height
        let bottomLeftCorner = CGPoint(x: 0, y: 80)
        let finalFrame = CGRect(origin: bottomLeftCorner, size: screenBounds.size)
        
        //This SnapShot is necessary to show some context below our new view presentation, without it our transition background becomes aplication window color.
        guard let fromSnapshotView = fromVC.view.resizableSnapshotView(from: fromVC.view.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsets()) else { return }
        transitionContext.containerView.insertSubview(fromSnapshotView, belowSubview: toVC.view)
        
        //Insert a shadowView between above SnapShot to create a focus in presentation view, it could be and bluer view our whatever you want to.
        let shadowView = UIView(frame: CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height))
        shadowView.backgroundColor = .black
        shadowView.alpha = 0.0
        transitionContext.containerView.insertSubview(shadowView, aboveSubview: fromSnapshotView)
        
        toVC.view.layer.cornerRadius = 20
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                toVC.view.frame = finalFrame
                shadowView.alpha = 0.7
            
            },completion: { _ in
                
                transitionContext.completeTransition(true)
            }
        )
    }
    
}

