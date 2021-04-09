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
    private(set) var tags: Observable<[Tag]> = Observable([])
    private(set) var tagImages: Observable<[UIImage]> = Observable([])
    private(set) var tagImageUrls: Observable<[String]> = Observable([])
    
    func fetchTags(size: Int, page: Int, completionHandler: @escaping (TagCategoryViewModel) -> Void) {
        tagNetworkManager.fetchTags(size: size, page: page) { tags in
            guard let hashtags = tags else { return }
            self.appendTags(with: hashtags)
            self.appendTagImageUrls(with: hashtags)
            completionHandler(self)
        }
    }
    
    private func appendTags(with hashtags: [Tag]) {
        self.tags.value.append(contentsOf: hashtags)
        self.tags.value = self.tags.value.uniques // remove duplicate values
    }
    
    private func appendTagImageUrls(with hashtags: [Tag]) {
        let tagImagesUrls = hashtags.map({$0.thumbnail})
        self.tagImageUrls.value.append(contentsOf: tagImagesUrls)
    }
}
