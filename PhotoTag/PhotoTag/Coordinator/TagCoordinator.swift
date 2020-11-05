//
//  TagCoordinator.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/24.
//

import UIKit

class TagCoordinator: ChildCoordinator {
    
    weak var parentCoordinator: AppCoordinator?
    
    override func start() {
        let tagCategoryViewController = appViewControllerFactory.tagCategoryViewController(coordinator: self)
        navigationController.pushViewController(tagCategoryViewController, animated: true)
    }
}
