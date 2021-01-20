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
    var selectedItems = [YPMediaItem]()
    
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
                self.presentAlert()
                picker.dismiss(animated: true, completion: nil)
                return
            }
            
            self.selectedItems = items // save photos (first chance to apply photo filter)
            picker.dismiss(animated: true, completion: nil)
            
            self.showSelectedItems()
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    private func showSelectedItems() {
        let gallery = YPSelectionsGalleryVC(items: self.selectedItems) { galleryVC, items in
            self.selectedItems = items // save photos (last chance to apply photo filter)
            galleryVC.dismiss(animated: true, completion: nil)
            
            // after check selected photos, navigate to next scene
            let selectedPhotos = self.filterPhotos(in: self.selectedItems)
            self.coordinator?.navigateToPhotoNote(with: selectedPhotos, isCreatingMode: .creating)
        }
        let navController = UINavigationController(rootViewController: gallery)
        self.present(navController, animated: true, completion: nil)
    }
    
    private func filterPhotos(in selectedItems: [YPMediaItem]) -> [UIImage] {
        var selectedPhotos = [UIImage]()
        if selectedItems.count != 0 {
            for item in selectedItems {
                switch item {
                case .photo(let photo):
                    selectedPhotos.append(photo.image)
                case .video(_): break
                }
            }
        }
        return selectedPhotos
    }
}

extension SelectPhotoViewController: AlertPresentable {
    var alertComponents: AlertComponents {
        let action = AlertActionComponent(title: "OK", handler: { _ in print("My task :)")})
        let alertComponents = AlertComponents(title: "Oops! 😵", message: "No photos are selected", actions: [action], completion: {
            self.coordinator?.navigateToPhotoNoteList()
    })
        return alertComponents
    }
}

extension SelectPhotoViewController: YPImagePickerDelegate {
    func noPhotos() {
        self.presentAlert()
    }
    
    func shouldAddToSelection(indexPath: IndexPath, numSelections: Int) -> Bool {
        return true
    }
}
