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
        return TagCategoryViewController(coordinator: coordinator)
    }
    
    func tagManagementViewController(coordinator: TagCoordinator) -> UIViewController {
        return TagManagementViewController(coordinator: coordinator)
    }
    
    func photoNoteListViewController(coordinator: PhotoNoteCoordinator) -> UIViewController {
        return PhotoNoteListViewController(coordinator: coordinator)
    }
    
    func selectPhotoViewController(coordinator: PhotoNoteCoordinator) -> UIViewController {
        return SelectPhotoViewController(coordinator: coordinator)
    }
    
    func writePhotoNoteViewController(coordinator: PhotoNoteCoordinator) -> UIViewController {
        return WritePhotoNoteViewController(coordinator: coordinator)
    }
    
    func photoNoteViewController(coordinator: PhotoNoteCoordinator) -> UIViewController {
        return PhotoNoteViewController(coordinator: coordinator)
    }
    
    func searchViewController(coordinator: SearchCoordinator) -> UIViewController {
        return SearchViewController(coordinator: coordinator)
    }
    
    func selectPeriodViewController(coordinator: SearchCoordinator) -> UIViewController {
        return SelectPeriodViewController(coordinator: coordinator)
    }
}
