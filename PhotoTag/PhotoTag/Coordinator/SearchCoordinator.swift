//
//  SearchCoordinator.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/06.
//

import UIKit

class SearchCoordinator: ChildCoordinator {
    
    override func start() {
        let searchViewController = appViewControllerFactory.searchViewController(coordinator: self)
        navigationController.pushViewController(searchViewController, animated: true)
    }
    
    func navigateToSelectPeriod() {
        let searchViewController = appViewControllerFactory.searchViewController(coordinator: self)
        navigationController.pushViewController(searchViewController, animated: true)
    }
}
