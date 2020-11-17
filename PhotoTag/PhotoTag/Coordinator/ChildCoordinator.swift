//
//  ChildCoordinator.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/06.
//

import UIKit

class ChildCoordinator: NSObject, Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let appViewControllerFactory = AppViewControllersFactory()
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
}
