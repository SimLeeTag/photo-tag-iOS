//
//  TagCoordinator.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/24.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var delegate: CoordinatorDelegate?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tagCategoryViewController: TagCategoryViewController = TagCategoryViewController(delegate: self)
        self.navigationController.pushViewController(tagCategoryViewController, animated: true)
    }
}

extension MainCoordinator: CoordinatorDelegate {
    func navigateToSelectPhoto() {
        self.delegate?.navigateToSelectPhoto()
    }
    
    func navigateToPhotoNote() {
        self.delegate?.navigateToPhotoNote()
    }
    
    func navigateToWritePhotoNote() {
        self.delegate?.navigateToWritePhotoNote()
    }
    
    func navigateToTagManagement() {
        self.delegate?.navigateToTagManagement()
    }
    
    func navigateToPhotoNoteList() {
        self.delegate?.navigateToPhotoNoteList()
    }
    
    func navigateToTagCategory() {
        self.delegate?.navigateToTagCategory()
    }

}
