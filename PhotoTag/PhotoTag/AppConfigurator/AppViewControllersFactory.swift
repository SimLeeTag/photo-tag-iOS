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
    
    func photoNoteListViewController(coordinator: PhotoNoteCoordinator) -> UIViewController {
        return PhotoNoteListViewController(coordinator: coordinator)
    }
    
    func tagCategoryViewController(coordinator: TagCoordinator) -> UIViewController {
        return TagCategoryViewController(coordinator: coordinator)
    }
    
    func tagManagementViewController(coordinator: TagCoordinator) -> UIViewController {
        return TagManagementViewController(coordinator: coordinator)
    }
    
    func searchViewController(coordinator: SearchCoordinator) -> UIViewController {
        return SearchViewController(coordinator: coordinator)
    }
}
