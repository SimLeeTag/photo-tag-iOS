//
//  EntryCoordinator.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/26.
//

import UIKit

class AppCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let loginViewController: LoginViewController = LoginViewController()
        loginViewController.delegate = self
        self.navigationController.viewControllers = [loginViewController]
    }
}

extension AppCoordinator: CoordinatorDelegate {
    func navigateToSelectPhoto() {
        //TODO:- present action sheet
    }
    
    func navigateToPhotoNote() {
        //TODO:- present PhotoNoteViewController
    }
    
    func navigateToWritePhotoNote() {
        //TODO:- present WritePhotoNoteViewController over PhotoNoteViewController
    }
    
    func navigateToPhotoNoteList() {
        let photoNoteListViewController = PhotoNoteListViewController()
        photoNoteListViewController.delegate = self
        self.navigationController.pushViewController(photoNoteListViewController, animated: true)
    }
    
    func navigateToTagCategory() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator.delegate = self
        childCoordinators.append(mainCoordinator)
        mainCoordinator.start()
    }
    
    func navigateToTagManagement() {
        let tagManagementViewController = TagManagementViewController()
        tagManagementViewController.delegate = self
        self.navigationController.pushViewController(tagManagementViewController, animated: true)
    }
}
