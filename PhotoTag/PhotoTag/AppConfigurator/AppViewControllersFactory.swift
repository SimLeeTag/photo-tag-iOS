//
//  AppViewControllersFactory.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/27.
//

import UIKit

struct AppViewControllersFactory {
    
    //TODO:- add viewModelFactory
    
    //TODO:- add viewModel as parameter
    func loginViewController(coordinator: AppCoordinator) -> UIViewController {
        return LoginViewController(coordinator: coordinator)
    }
    
    func tagCategoryViewController(coordinator: TagCoordinator) -> UIViewController {
        return TagCategoryViewController(with: TagCategoryViewModel(), coordinator: coordinator)
    }
    
    func tagManagementViewController(coordinator: TagCoordinator) -> UIViewController {
        let tagManagementViewController = TagManagementViewController(with: TagManagementViewModel(), coordinator: coordinator)
        let tableViewDelegate = TagManagementTableViewDelegate()
        tagManagementViewController.delegate = tableViewDelegate
        return tagManagementViewController
    }
    
    func photoNoteListViewController(coordinator: PhotoNoteCoordinator) -> UIViewController {
        return PhotoNoteListViewController(coordinator: coordinator)
    }
    
    func selectPhotoViewController(coordinator: PhotoNoteCoordinator) -> UIViewController {
        return SelectPhotoViewController(coordinator: coordinator)
    }
    
    func writePhotoNoteViewController(coordinator: PhotoNoteCoordinator) -> UIViewController {
        return NoteViewController(coordinator: coordinator)
    }
    
    func photoNoteViewController(coordinator: PhotoNoteCoordinator, viewModel: PhotoNoteViewModel, isCreatingMode: Bool) -> UIViewController {
        return PhotoNoteViewController(coordinator: coordinator, viewModel: viewModel, isCreating: isCreatingMode)
    }
    
    func searchViewController(coordinator: SearchCoordinator) -> UIViewController {
        return SearchViewController(coordinator: coordinator)
    }
    
    func selectPeriodViewController(coordinator: SearchCoordinator) -> UIViewController {
        return SelectPeriodViewController(coordinator: coordinator)
    }
}
