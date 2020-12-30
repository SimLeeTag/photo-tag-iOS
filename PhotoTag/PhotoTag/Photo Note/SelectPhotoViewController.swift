//
//  SelectPhotoViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/06.
//

import UIKit
import YPImagePicker

final class SelectPhotoViewController: UIViewController {

    weak var coordinator: PhotoNoteCoordinator?
    var selectedItems = [YPMediaItem]() // should move to View Model
    
    //TODO:- add viewModel as parameter
    init(coordinator: PhotoNoteCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectPhotos()
    }
    
    private func selectPhotos() {
        
        func configuration() -> YPImagePickerConfiguration {
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photoAndVideo
            config.library.itemOverlayType = .grid
            config.albumName = "Photo Tag"
            config.screens = [.library, .photo]
            config.wordings.libraryTitle = "Gallery"
            config.hidesStatusBar = true
            config.hidesBottomBar = false
            config.maxCameraZoomFactor = 2.0
            config.library.maxNumberOfItems = 5
            config.library.minNumberOfItems = 1
            config.gallery.hidesRemoveButton = false
            config.library.skipSelectionsGallery = true
            return config
        }
        
        func imagePicker(with configuration: YPImagePickerConfiguration) -> YPImagePicker {
            let picker = YPImagePicker(configuration: config)

            picker.imagePickerDelegate = self
            return picker
        }
        
        let config = configuration()
        let picker = imagePicker(with: config)
        
        picker.didFinishPicking { [unowned picker] items, cancelled in

            if cancelled {
                // TODO: - show alert
                print("Picker was canceled")
                picker.dismiss(animated: true, completion: nil)
                return
            }
            self.selectedItems = items
            picker.dismiss(animated: true, completion: nil)
            self.showSelectedItems()
        }
        present(picker, animated: true, completion: nil)
    }
    
    private func showSelectedItems() {
        let gallery = YPSelectionsGalleryVC(items: self.selectedItems) { galleryVC, items in
            self.selectedItems = items
            // TODO: - update viewModel
            galleryVC.dismiss(animated: true, completion: nil)
            self.coordinator?.navigateToPhotoNote()
            // TODO: - pass selected images to photo note
        }
        let navController = UINavigationController(rootViewController: gallery)
        self.present(navController, animated: true, completion: nil)
    }
}

extension SelectPhotoViewController: YPImagePickerDelegate {
    func noPhotos() {
        // TODO: - show alert
    }
    
    func shouldAddToSelection(indexPath: IndexPath, numSelections: Int) -> Bool {
        return true
    }
}
