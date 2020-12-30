//
//  PhotoNoteViewModel.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/12/30.
//

import Foundation
import YPImagePicker

class PhotoNoteViewModel {
    
    var selectedImages: [YPMediaItem]
    
    init(with selectedItems: [YPMediaItem]) {
        self.selectedImages = selectedItems
    }
}
