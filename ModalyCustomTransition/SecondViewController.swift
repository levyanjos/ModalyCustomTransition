//
//  SecondViewController.swift
//  ModalyCustomTransition
//
//  Created by Levy Cristian on 05/09/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var interactor: Interactor?
    
    private lazy var panGesture: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer()
        pan.addTarget(self, action: #selector(handleGesture(_:)))
        pan.minimumNumberOfTouches = 1
        return pan
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Configurações iniciais
        view.backgroundColor = .lightGray
        view.addGestureRecognizer(panGesture)
        
    }
    
    @objc private func handleGesture(_ sender: UIPanGestureRecognizer) {
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
