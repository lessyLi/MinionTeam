//
//  CustomNavigationController.swift
//  MinionTeam
//
//  Created by MacBook on 05.06.2022.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return PushAnimator()
        } else if operation == .pop {
            return PopAnimator()
        }
        return nil
    }
    
}
