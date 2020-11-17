//
//  TagCoordinator.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/24.
//

import UIKit

class TagCoordinator: ChildCoordinator {
    
    override func start() {
        let tagCategoryViewController = appViewControllerFactory.tagCategoryViewController(coordinator: self)
        navigationController.pushViewController(tagCategoryViewController, animated: true)
    }
    
    func navigateToTagManagement() {
        let tagManagementViewController = appViewControllerFactory.tagManagementViewController(coordinator: self)
        navigationController.pushViewController(tagManagementViewController, animated: true)
    }
    
    func navigateToPhotoNoteList() {
        guard let appCoordinator =  parentCoordinator as? AppCoordinator else { return }
        appCoordinator.navigateToPhotoNoteList()
    }
}
