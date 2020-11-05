//
//  PhotoNoteCoordinator.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/06.
//

import UIKit

class PhotoNoteCoordinator: ChildCoordinator {
    
    weak var parentCoordinator: AppCoordinator?
    
    override func start() {
        let photoNoteListViewController = appViewControllerFactory.photoNoteListViewController(coordinator: self)
        navigationController.pushViewController(photoNoteListViewController, animated: true)
    }
}
