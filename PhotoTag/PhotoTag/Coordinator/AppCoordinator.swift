//
//  EntryCoordinator.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/26.
//

import UIKit

class AppCoordinator: NSObject, Coordinator {
    
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let appViewControllerFactory = AppViewControllersFactory()
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        //TODO:- with view model as parameter
        let loginViewController = appViewControllerFactory.loginViewController(coordinator: self)
        navigationController.delegate = self
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func navigateToSelectTagCategory() {
        // tagCoordinator is child coordinator of AppCoordinator
        let tagCoordinator = TagCoordinator(navigationController: navigationController)
        tagCoordinator.parentCoordinator = self
        childCoordinators.append(tagCoordinator)
        tagCoordinator.start()
    }
    
    func navigateToPhotoNoteList() {
        // photoNoteCoordinator is child coordinator of AppCoordinator
        let photoNoteCoordinator = PhotoNoteCoordinator(navigationController: navigationController)
        photoNoteCoordinator.parentCoordinator = self
        childCoordinators.append(photoNoteCoordinator)
        photoNoteCoordinator.start()
    }
    
    func navigateToSearchNote() {
        // searchCoordinator is child coordinator of AppCoordinator
        let searchCoordinator = SearchCoordinator(navigationController: navigationController)
        searchCoordinator.parentCoordinator = self
        childCoordinators.append(searchCoordinator)
        searchCoordinator.start()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

extension AppCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        if let tagCategoryViewController = fromViewController as? TagCategoryViewController {
            childDidFinish(tagCategoryViewController.coordinator)
        }
        
        if let searchViewController = fromViewController as? SearchViewController {
            childDidFinish(searchViewController.coordinator)
        }
        
        if let photoNoteListViewController = fromViewController as? PhotoNoteListViewController {
            childDidFinish(photoNoteListViewController.coordinator)
        }
    }
}
