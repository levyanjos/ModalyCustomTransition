//
//  Interactor.swift
//  ModalyCustomTransition
//
//  Created by Levy Cristian on 05/09/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import Foundation

import Foundation
import UIKit

/** Singleton responsible for management of dismiss animation */
class Interactor: UIPercentDrivenInteractiveTransition{
    
    // MARK: Variables
    
    /** Control variable responsible for save animation start stage */
    var hasStarted = false
    
    /** Control variable responsible for save value if animation should finish with user moviment. */
    var shouldFinish = false
}
