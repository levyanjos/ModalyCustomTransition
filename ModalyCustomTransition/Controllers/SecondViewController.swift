//
//  SecondViewController.swift
//  ModalyCustomTransition
//
//  Created by Levy Cristian on 05/09/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    // MARK: Varibles

    var interactor: Interactor?
    
    private lazy var swipeDownPanGesture: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer()
        pan.minimumNumberOfTouches = 1
        
        pan.addTarget(self, action: #selector(handleGesture(_:)))
        return pan
    }()
    
    private lazy var swipeDownLabel: UILabel = {
        let label = UILabel()
        label.text = "Swipe Down"
        
        view.addSubview(label)
        return label
    }()
    
    // MARK: Application life cicle functions

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Inital setups
        view.backgroundColor = .lightGray
        view.addGestureRecognizer(swipeDownPanGesture)
        
        swipeDownLabel.translatesAutoresizingMaskIntoConstraints = false
        swipeDownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        swipeDownLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    // MARK: Functions

    /** Functions responsible for hadle dismiss gesture in view. Here we set values to dismiss and compute animations dismiss progress. */
    @objc private func handleGesture(_ sender: UIPanGestureRecognizer) {
        //Control variable responsible for saving dismiss animation percentage automatically completion value. If the animation reaches 30% and user releases it on the screen, it will end automatically.
        let percentThreshold:CGFloat = 0.3
        
        let translation = sender.translation(in: view)
        let verticalMovement = translation.y / view.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        guard let interactor = interactor else { return }
        
        switch sender.state {
        case .began:
            interactor.hasStarted = true
            dismiss(animated: true, completion: nil)
        case .changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.update(progress)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            interactor.shouldFinish ? interactor.finish() : interactor.cancel()
        default:
            break
        }
        
    }

}
