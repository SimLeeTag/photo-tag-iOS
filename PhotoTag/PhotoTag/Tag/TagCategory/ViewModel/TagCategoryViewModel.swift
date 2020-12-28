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
    let tagImages: Observable<[UIImage]> = Observable([])
    let buttonText = Observable("Select Tag")
    let imageLoadTaskManager = ImageLoadTaskManager()
    private(set) var tags: Observable<[Tag]> = Observable([])
    
    func fetchTags(size: Int, page: Int, completionHandler: @escaping (TagCategoryViewModel) -> Void) {
        tagNetworkManager.fetchTags(size: size, page: page) { tags in
            guard let hashtags = tags else { return }
            self.updateTags(with: hashtags)
            self.updateTagImages(with: hashtags) { viewModelWithImages in
                completionHandler(viewModelWithImages)
            }
        }
    }
    
    func updateTags(with hashtags: [Tag]) {
        self.tags.value.append(contentsOf: hashtags)
    }
    
    func updateTagImages(with hashtags: [Tag], completionHandler: @escaping (TagCategoryViewModel) -> Void) {
        for tag in hashtags {
            guard let thumbnailUrl = URL(string: tag.thumbnail) else { debugPrint("Invalid thumbnail Url."); return }
            self.fetchTagImage(with: thumbnailUrl) { tagImage in
                self.tagImages.value.append(tagImage)
                completionHandler(self)
            }
        }
    }
    
    func addImage(newImage: UIImage) {
        tagImages.value.append(newImage)
    }
}

extension TagCategoryViewModel {
    func fetchTagImage(with url: URL, completionHandler: @escaping (UIImage) -> Void) {
        imageLoadTaskManager.fetchImage(with: url) { imageData in
            guard let data = imageData, let image = UIImage(data: data) else { return }
            completionHandler(image)
        }
    }
}
