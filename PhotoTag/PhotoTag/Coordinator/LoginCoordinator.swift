//
//  LoginCoordinator.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/24.
//

import UIKit

class LoginCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let loginViewController: LoginViewController = LoginViewController()
        loginViewController.delegate = self
        self.navigationController.viewControllers = [loginViewController]
    }
}

extension LoginCoordinator: LoginDelegate {
    func navigateToTagCategory() {
        //TODO: - set up and start TagCoordinator
        print(#function)
    }
}
