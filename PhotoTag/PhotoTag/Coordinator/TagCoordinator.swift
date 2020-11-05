//
//  TagCoordinator.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/24.
//

import UIKit

class TagCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tagCategoryViewController: TagCategoryViewController = TagCategoryViewController(delegate: self)
        self.navigationController.pushViewController(tagCategoryViewController, animated: true)
    }
}

