//
//  AppViewControllersFactory.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/27.
//

import UIKit

struct AppViewControllersFactory {
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
    
    func photoNoteListViewController(coordinator: PhotoNoteCoordinator, viewModel: PhotoNoteListViewModel) -> UIViewController {
        return PhotoNoteListViewController(coordinator: coordinator, viewModel: viewModel)
    }
    
    func selectPhotoViewController(coordinator: PhotoNoteCoordinator) -> UIViewController {
        return SelectPhotoViewController(coordinator: coordinator)
    }
    
    func writePhotoNoteViewController(coordinator: PhotoNoteCoordinator, with text: String, and photos: [NoteImage]) -> UIViewController {
        let noteViewController = NoteViewController(coordinator: coordinator, with: text, and: photos)
        return noteViewController
    }
    
    func photoNoteViewController(coordinator: PhotoNoteCoordinator, viewModel: PhotoNoteViewModel, isCreatingMode: NoteState) -> UIViewController {
        return PhotoNoteViewController(coordinator: coordinator, viewModel: viewModel, isCreating: isCreatingMode)
    }
    
    func searchViewController(coordinator: SearchCoordinator) -> UIViewController {
        return SearchViewController(coordinator: coordinator)
    }
    
    func selectPeriodViewController(coordinator: SearchCoordinator) -> UIViewController {
        return SelectPeriodViewController(coordinator: coordinator)
    }
}
