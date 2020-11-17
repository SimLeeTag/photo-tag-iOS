//
//  PhotoNoteCoordinator.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/06.
//

import UIKit

class PhotoNoteCoordinator: ChildCoordinator {
    
    override func start() {
        let photoNoteListViewController = appViewControllerFactory.photoNoteListViewController(coordinator: self)
        navigationController.pushViewController(photoNoteListViewController, animated: true)
    }
    
    func navigateToPhotoNoteList() {
        let photoNoteListViewController = appViewControllerFactory.photoNoteListViewController(coordinator: self)
        navigationController.pushViewController(photoNoteListViewController, animated: true)
    }
    
    func navigateToSelectPhoto() {
        let selectPhotoViewController = appViewControllerFactory.photoNoteListViewController(coordinator: self)
        navigationController.pushViewController(selectPhotoViewController, animated: true)
    }
    
    func navigateToWritePhotoNote() {
        let writePhotoNoteViewController = appViewControllerFactory.photoNoteListViewController(coordinator: self)
        navigationController.pushViewController(writePhotoNoteViewController, animated: true)
    }
    
    func navigateToPhotoNote() {
        let photoNoteViewController = appViewControllerFactory.photoNoteViewController(coordinator: self)
        navigationController.pushViewController(photoNoteViewController, animated: true)
    }
}
