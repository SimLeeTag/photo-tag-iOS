//
//  EntryCoordinator.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/26.
//

import UIKit

class EntryCoordinator: Coordinator {

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

extension EntryCoordinator: TagSceneTransitionDelegate {
    func navigateToTagCategory() {
        let tagCoordinator = TagCoordinator(navigationController: navigationController)
        tagCoordinator.delegate = self
        childCoordinators.append(tagCoordinator)
        tagCoordinator.start()
    }
    
    func navigateToTagManagement() {
        let tagManagementViewController = LoginViewController()
        tagManagementViewController.delegate = self
        self.navigationController.pushViewController(tagManagementViewController, animated: true)
    }
}
