//
//  PhotoNoteCoordinator.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/06.
//

import UIKit

final class PhotoNoteCoordinator: ChildCoordinator {
    
    override func start() {
        let photoNoteListViewController = appViewControllerFactory.photoNoteListViewController(coordinator: self, viewModel: PhotoNoteListViewModel())
        navigationController.pushViewController(photoNoteListViewController, animated: true)
    }
    
    func navigateToPhotoNoteList() {
        let photoNoteListViewController = appViewControllerFactory.photoNoteListViewController(coordinator: self, viewModel: PhotoNoteListViewModel())
        navigationController.pushViewController(photoNoteListViewController, animated: true)
    }
    
    func navigateToSelectPhoto() {
        let selectPhotoViewController = appViewControllerFactory.selectPhotoViewController(coordinator: self)
        navigationController.pushViewController(selectPhotoViewController, animated: true)
    }
    
    func navigateToWritePhotoNote(with text: String) {
        let writePhotoNoteViewController = appViewControllerFactory.writePhotoNoteViewController(coordinator: self, with: text)
        navigationController.pushViewController(writePhotoNoteViewController, animated: true)
    }
    
    // selectedItems are used when creating new note mode
    func navigateToPhotoNote(with selectedItems: [UIImage] = [], noteId: NoteID = 4, isCreatingMode: NoteState) {
        let photoNoteViewController = appViewControllerFactory.photoNoteViewController(coordinator: self, viewModel: PhotoNoteViewModel(with: selectedItems, noteId: noteId), isCreatingMode: isCreatingMode, selectedImages: selectedItems )
        navigationController.pushViewController(photoNoteViewController, animated: true)
    }
}
