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
            for url in self.tagImageUrls.value {
                guard let url = URL(string: url) else { return }
                ImageDownloadManager.fetchImage(with: url) { image in
                    guard let newImage = image else { return }
                    self.tagImages.value.append(newImage)
                }
            }
            completionHandler(self)
        }
    }
    
    func fetchTagImage(with url: String, completionHandler: @escaping (UIImage) -> Void) {
        guard let imageUrl = URL(string: url) else { return }
        ImageDownloadManager.fetchImage(with: imageUrl) { image in
            guard let newImage = image else { return }
            completionHandler(newImage)
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
