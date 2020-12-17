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
    private(set) var tagsWithImage: Observable<[Tag]> = Observable([])

    func fetchTags(size: Int, page: Int, completionHandler: @escaping (TagCategoryViewModel) -> Void) {
        // modify limit and offset
        tagNetworkManager.fetchTagsWithImage(size: 0, page: 0) { tags in
            guard let hashtags = tags else { return }
            self.tagsWithImage = Observable(hashtags)
            completionHandler(self)
        }
    }
    
    func addImage(newImage: UIImage) {
        tagImages.value.append(newImage)
    }
}
