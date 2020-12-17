//
//  TagCategoryCellViewModel.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/12/17.
//

import Foundation
import UIKit.UIImage

final class TagCategoryCellViewModel {
    
    let latestImageViewUrl = Observable("image url")
    let tagNameLabelText = Observable("tag name")
    let noteCountLabelText = Observable(0)
    let image: Observable<UIImage?> = Observable(nil)
    let imageLoadTaskManager = ImageLoadTaskManager()
}

extension TagCategoryCellViewModel {
    func updateTagImage(with url: URL, completionHandler: @escaping (UIImage) -> Void) {
        imageLoadTaskManager.fetchImage(with: url) { imageData in
            guard let data = imageData, let image = UIImage(data: data) else { return }
            completionHandler(image)
        }
    }
}
