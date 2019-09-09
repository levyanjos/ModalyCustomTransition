//
//  ViewController.swift
//  ModalyCustomTransition
//
//  Created by Levy Cristian on 05/09/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Varibles
    
    lazy var interactor: Interactor = {
       let interactor = Interactor()
        
        return interactor
    }()
    
    lazy var clickHereButtom: UIButton = {
       let buttom = UIButton()
        buttom.setTitle("Click Here", for: .normal)
        buttom.addTarget(self, action: #selector(secondViewButtomDidTaped(_:)), for: .touchUpInside)
        buttom.setTitleColor(.blue, for: .normal)
        
        view.addSubview(buttom)
        return buttom
    }()
    
    // MARK: Application life cicle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //initial setups
        view.backgroundColor = .white
        
        clickHereButtom.translatesAutoresizingMaskIntoConstraints = false
        clickHereButtom.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        clickHereButtom.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    // MARK: Functions
    
    /** Functions called when secondButtonView was tapped to present the second controller. */
    @objc func secondViewButtomDidTaped(_ buttom: UIButton){
        let secondViewController = SecondViewController()
        secondViewController.interactor = interactor
        secondViewController.transitioningDelegate = self
        present(secondViewController, animated: true, completion: nil)
        
    }

}

extension ViewController: UIViewControllerTransitioningDelegate {
    // MARK: Extension
    
    /** Functions to set custo transiton as present. */
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation()
    }
    
    /** Functions to set custo transiton as dusmiss. */
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation()
    }
    
    /** Functions to set custo interactor for dismiss transition. */
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}

