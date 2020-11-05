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
    func loginViewController(delegate: CoordinatorDelegate) -> UIViewController {
        return LoginViewController(delegate: delegate)
    }
    
    func photoNoteListViewController(delegate: CoordinatorDelegate) -> UIViewController {
        return PhotoNoteListViewController(delegate: delegate)
    }
    
    func tagCategoryViewController(delegate: TagCoordinator) -> UIViewController {
        return TagCategoryViewController(delegate: delegate)
    }
    
    func tagManagementViewController(delegate: CoordinatorDelegate) -> UIViewController {
        return TagManagementViewController(delegate: delegate)
    }
}
