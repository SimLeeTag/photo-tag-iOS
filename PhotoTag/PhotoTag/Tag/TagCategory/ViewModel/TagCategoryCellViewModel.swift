//
//  TagCategoryCellViewModel.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/12/17.
//

import Foundation
import UIKit.UIImage

final class TagCategoryCellViewModel {
    
    let tagNameLabelText = Observable("tag name")
    let noteCountLabelText = Observable(0)
    let image: Observable<UIImage?> = Observable(nil)
}
