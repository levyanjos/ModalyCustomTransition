//
//  ViewController.swift
//  ModalyCustomTransition
//
//  Created by Levy Cristian on 05/09/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var interactor: Interactor = {
       let interactor = Interactor()
        
        return interactor
    }()
    
    lazy var secondViewButtom: UIButton = {
       let buttom = UIButton()
        buttom.setTitle("secondController", for: .normal)
        buttom.addTarget(self, action: #selector(secondViewButtomDidTaped(_:)), for: .touchUpInside)
        buttom.setTitleColor(.blue, for: .normal)
        
        view.addSubview(buttom)
        return buttom
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Configurações iniciais
        view.backgroundColor = .white
        
        secondViewButtom.translatesAutoresizingMaskIntoConstraints = false
        secondViewButtom.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        secondViewButtom.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    @objc func secondViewButtomDidTaped(_ buttom: UIButton){
        let secondViewController = SecondViewController()
        secondViewController.interactor = interactor
        secondViewController.transitioningDelegate = self
        present(secondViewController, animated: true, completion: nil)
    }

}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}

