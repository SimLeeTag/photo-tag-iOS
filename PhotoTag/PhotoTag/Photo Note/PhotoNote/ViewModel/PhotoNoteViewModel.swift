//
//  PhotoNoteViewModel.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/12/30.
//

import Foundation
import UIKit.UIImage

class PhotoNoteViewModel {
    
    var selectedImages: [UIImage]
    var date: Date?
    
    init(with selectedItems: [UIImage]) {
        self.selectedImages = selectedItems
    }
    
    func passImages() -> (UIImage,[UIImage]) {
        return (firstItem(), secondToLastItems())
    }
    
    private func firstItem() -> UIImage {
        guard let firstPhoto = selectedImages.first else { return #imageLiteral(resourceName: "logo") }
        return firstPhoto
    }
    
    private func secondToLastItems() -> [UIImage] {
        var selectedImagesExceptFirst = selectedImages.map({$0})
        selectedImagesExceptFirst.remove(at: 0)
        return selectedImagesExceptFirst
    }
}
