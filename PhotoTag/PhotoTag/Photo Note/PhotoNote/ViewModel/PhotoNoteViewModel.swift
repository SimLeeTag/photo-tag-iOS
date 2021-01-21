//
//  PhotoNoteViewModel.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/12/30.
//

import Foundation
import UIKit.UIImage

class PhotoNoteViewModel {
    
    private(set) var selectedImages: [UIImage]
    var date: Date?
    var noteContentText: String?
    
    init(with selectedItems: [UIImage]) {
        self.selectedImages = selectedItems
    }
}
