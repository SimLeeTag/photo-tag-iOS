//
//  TagCategoryViewModel.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/12/17.
//

import Foundation
import UIKit.UIImage

final class TagCategoryViewModel {
    
    let tagNetworkManager = TagNetworkingManager()
    let title = Observable("Tags")
    let buttonText = Observable("Select Tag")
    let imageLoadTaskManager = ImageLoadTaskManager()
    private(set) var tags: Observable<[Tag]> = Observable([])
    private(set) var tagImages: Observable<[UIImage]> = Observable([])
    
    func fetchTags(size: Int, page: Int, completionHandler: @escaping (TagCategoryViewModel) -> Void) {
        tagNetworkManager.fetchTags(size: size, page: page) { tags in
            guard let hashtags = tags else { return }
            self.appendTags(with: hashtags)
            completionHandler(self)
        }
    }
    
    func fetchTagImage(with tags: [Tag], completionHandler: @escaping ([UIImage]) -> Void) {
        var images = [UIImage]()
        for tag in tags {
            guard let url = URL(string: tag.thumbnail) else { return }
            imageLoadTaskManager.fetchImage(with: url) { uiimage in
                guard let image = uiimage else { return }
                images.append(image)
            }
            completionHandler(images)
        }
    }
    
    func appendTags(with hashtags: [Tag]) {
        self.tags.value.append(contentsOf: hashtags)
        self.tags.value = Array(Set(self.tags.value)) // remove duplicate values
    }
}
